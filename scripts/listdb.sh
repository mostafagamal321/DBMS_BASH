#! /bin/bash
# program to list the existed database 

if [[ ! -d "$HOME/databases" ]];
then
    echo "No database directory exists"
    exit 1
fi

cd "$HOME/databases" || exit

databases=$(ls -d */ 2>/dev/null)

if [[ -z "$databases" ]];
then
    echo "No databases was found."

else
    echo "Current databases"
    echo "-----------------"

for db in "$databases";
do
    echo "${db%/}"
done

fi

