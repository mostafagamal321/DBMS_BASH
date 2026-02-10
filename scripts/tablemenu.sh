#! /bin/bash

# program to show table menu for connected database
print_table_menu() {
    echo "------ DATABASE MAIN MENU ------"
    echo "1) Create Database"
    echo "2) Connect to database"
    echo "3) list Current Databases"
    echo "4) Drop Database"
    echo "5) Exit"
    echo "------------------------------"
}
echo -e "\e[1mWelcome To Tables Main Menu:\e[0m"
echo "--------------------------------------------"

OPTIONS=( "Create New Table" 
"List Current Tables" 
"Update Table" 
"Insert in table" 
"Select From Table" 
"Delete From Table" 
"Drop Table" 
"Exit" )

PS3="What do you want to do?: "
while true;
do
    select opt in "${OPTIONS[@]}";
    do
    case $opt in
    "Create New Table")
    echo "You selected: Create New Table"
    bash ~/project/create_tb.sh
    break
    ;;
    "List Current Tables")
    echo "You selected : list current tables"
    bash ~/project/list_tb.sh
    break
    ;;
    "Update Table")
    echo "You selected : update a table"
    bash  ~/project/update_tb.sh
    break
    ;;

    "Insert in table")
    echo "You selected : insert into a table"
    bash  ~/project/insert_tb.sh
    break
    ;;
    "Select From Table")
    echo "You selected : select from a table"
    bash  ~/project/select_tb.sh
    break
    ;;
    "Delete From Table")
    echo "You selected : delete from table"
    bash ~/project/delete_tb.sh
    break
    ;;
    "Drop Table")
    echo "You selected : Drop Table"
    bash ~/project/drop_tb.sh
    break
    ;;
    "Exit")
    echo "Returning to Main Menu..."
    print_table_menu
    exit 0
    ;;
    *)
    echo "Please choose a valid option:"
    ;;

        
        esac
    done
done