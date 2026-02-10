#!/bin/bash
# Program to drop the entire table

read -p "Enter table name to drop: " table
table="${table%.data}"  


if [[ ! -f "$table.data" || ! -f "$table.meta" ]]; 
then
    echo "Table doesn't exist."
    exit 1
fi


read -p "Are you sure you want to drop table '$table'? This cannot be undone! (y/n): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Drop table cancelled."
    exit 0
fi


rm -f "$table.data" "$table.meta"

echo -e "\e[32mTable '$table' has been dropped successfully.\e[0m"
