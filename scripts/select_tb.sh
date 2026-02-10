#!/bin/bash
# program to select from table 

read -p "Enter table name: " table

if [[ ! -f "$table.data" || ! -f "$table.meta" ]]; then
    echo "Table doesn't exist."
    exit 1
fi

## extracting data
columns=()
while IFS=',' read -r col _ _; 
do
    columns+=("$col")
done < "$table.meta"


echo "Columns: ${columns[*]}"


read -p "Do you want to filter rows? (y/n): " filter

if [[ "$filter" =~ ^[Yy]$ ]]; then
    read -p "Enter column to filter by: " cond_col
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
    if [[ $cond_index -eq -1 ]]; then
        echo "Column not found."
        exit 1
    fi

    echo "--------------------------------------------"
    echo "             DATA IN TABLE                  "
    awk -F',' -v idx=$((cond_index+1)) -v val="$cond_value" 'BEGIN{OFS=","} $idx==val{print}' "$table.data"
     echo "--------------------------------------------"
else
    cat "$table.data"
fi
