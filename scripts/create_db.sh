#! /bin/bash
# Program to create a databases

while true
do
    read -p "Enter database name: " dbname

    if [[ $dbname =~ ^[a-zA-Z_][a-zA-Z0-9_]{2,30}$ ]]
    then
        
        if [[ -d "$dbname" ]]
        then
            echo -e "\e[31mThis database already exists.\e[0m"
        else
            mkdir "$dbname"
            echo -e "\e[32mDatabase was created successfully!\e[0m"
            break
        fi

    else
        echo "Invalid database name."
    fi
done

        
    