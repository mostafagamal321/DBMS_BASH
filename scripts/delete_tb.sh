#!/bin/bash
# Program to drop from a table

read -p "Enter table name: " table

if [[ ! -f "$table.data" || ! -f "$table.meta" ]]; 
then
    echo "Table doesn't exist."
    exit 1
fi


columns=()
while IFS=',' read -r col _ _; 
do
    columns+=("$col")
done < "$table.meta"


echo "Columns: ${columns[*]}"



read -p "Enter column to filter by for deletion: " cond_col
read -p "Enter value to match in $cond_col: " cond_value



cond_index=-1
for i in "${!columns[@]}"; 
do
    if [[ "${columns[i]}" == "$cond_col" ]]; 
    then
        cond_index=$i
        break
    fi
done

if [[ $cond_index -eq -1 ]]; 
then
    echo "Column not found."
    exit 1
fi

awk -F',' -v c=$((cond_index+1)) -v v="$cond_value" 'BEGIN {OFS=","} $c != v {print}' "$table.data" > "$table.data.tmp" \
&& mv "$table.data.tmp" "$table.data"

echo -e "\e[32mMatching rows deleted successfully.\e[0m"
