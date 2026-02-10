#!/bin/bash
# progam to update table entries
read -p "Enter table name: " table

# Check if table exists
if [[ ! -f "$table.data" || ! -f "$table.meta" ]]; 
then
    echo "Table doesn't exist."
    exit 1
fi

# Read meta into arrays
declare -a columns
declare -a datatypes
while IFS=',' read -r col datatype _;
 do
    columns+=("$col")
    datatypes+=("$datatype")
done < "$table.meta"

total_cols=${#columns[@]}

echo "Columns in table are: ${columns[*]}"

# Condition column
read -p "Enter column to filter by: " cond_col
cond_index=-1
for ((i=0; i<total_cols; i++)); do
    if [[ "${columns[$i]}" == "$cond_col" ]]; then
        cond_index=$i
        break
    fi
done
if [[ $cond_index -eq -1 ]]; then
    echo "Column not found."
    exit 1
fi

read -p "Enter value of $cond_col to match: " cond_value


read -p "Enter column to update: " update_col
update_index=-1
for ((i=0; i<total_cols; i++)); do
    if [[ "${columns[$i]}" == "$update_col" ]]; 
    then
        update_index=$i
        break
    fi
done
if [[ $update_index -eq -1 ]]; 
then
    echo "Column not found."
    exit 1
fi

datatype="${datatypes[$update_index]}"


while true; do
    read -p "Enter new value for $update_col ($datatype): " new_value

    case $datatype in
        int)
            [[ "$new_value" =~ ^[0-9]+$ ]] || { echo "Must be an integer"; continue; }
            ;;
        float)
            [[ "$new_value" =~ ^[0-9]+(\.[0-9]+)?$ ]] || { echo "Must be a float"; continue; }
            ;;
        string)
            ;;
        *)
            echo "Unknown datatype $datatype"; continue
            ;;
    esac
    break
done


awk -F',' -v cond_idx=$((cond_index+1)) -v cond_val="$cond_value" \
    -v update_idx=$((update_index+1)) -v new_val="$new_value" \
    'BEGIN {OFS=","} 
     {if ($cond_idx == cond_val) $update_idx = new_val} 1' \
    "$table.data" > "$table.data.tmp" && mv "$table.data.tmp" "$table.data"

echo -e "\e[32mTable updated successfully.\e[0m"
