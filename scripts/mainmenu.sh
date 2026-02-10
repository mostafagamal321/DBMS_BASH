#! /bin/bash
# This a program defines the main menu user pick from 
PS3='please Select an option: '
echo -e "\e[1mWelcome To Database Main Menu:\e[0m"
echo "--------------------------------------------"
#  check if dir exists and create dir if doesn't exist 

mkdir -p "$HOME/databases" 
cd "$HOME/databases" || exit 1



OPTIONS=( "Create Database" 
"Connect to database" 
"list Current Databases" 
"Drop Database" 
"Exit" )

while true;
do
    select opt in "${OPTIONS[@]}"
    do
    case $opt in
    "Create Database")
    echo "Performing Database Creation in Action..."
    bash ~/project/create_db.sh
    ;;
    "Connect to database")
    echo "You choose to connect database..."
    bash ~/project/connect_db.sh
    ;;
    "list Current Databases")
    echo "You chose to list current databases..."
    bash ~/project/listdb.sh
    ;;
    "Drop Database")
    echo "You chose to drop a database..."
    bash ~/project/dropdb.sh
    ;;
    "Exit")
    echo "Goodbye!"
    exit 0
    ;; 
    *)
    echo "Please choose a valid option:"
    ;;

        esac
    done
done
