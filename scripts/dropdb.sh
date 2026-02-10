#! /bin/bash
# Program to drop database from DBMS

cd "$HOME/databases" || exit

read -p "Enter the name of the database you want to drop: " dbname
dbname="${dbname%/}"

if [[ -d "$dbname" ]];
then

    read -p "are you sure you want to permanently delete the database: '$dbname' ? [y/n]:  " answer

if [[ "$answer" =~ ^[Yy]$ || "$answer" == 'yes' || "$answer" == "YES" ]];
then
    rm -r "$dbname"
    if [[ $? -eq 0 ]];
    then
        echo -e "\e[32mDatabase '$dbname' has been deleted sucessfully!\e[0m"
    else
        echo "There is  an error occurred while deleting '$dbname'."
    fi
else

    echo "deletion operation was cancelled"
fi

else
    echo "Database '$dbname' doesn't exists."

fi
