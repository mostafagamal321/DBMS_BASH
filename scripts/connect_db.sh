#! /bin/bash
# Program to connect to a database
while true
do
    read -p "Enter database Name: " dbname

    if [[ -d $dbname ]];
    then
    cd $dbname
    echo -e "\e[32mYou are connected to $dbname sucessfully!\e[0m"
    bash ~/project/tablemenu.sh  
    break

    else
    echo "This database doesn't exists"
    fi
done
