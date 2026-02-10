#! /bin/bash
# program to create new table 

while true;
    do
        read -p "What's your table name: " tablename

        tablename=$(echo "$tablename" | xargs)

        # table name validation
        if [[ $tablename =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]
        then
            # check if table already exists
            if [[ -f "$tablename.data" ]]
            then
                echo "This table already exists."
            else
                table="$tablename"
                break
            fi
        else
            echo "Invalid table name."
        fi
    done


while true;
    do
        read -p "Enter Number of columns: " No_of_columns
        if  [[  $No_of_columns =~ ^[1-9][0-9]*$ ]];
        then 
            break
        else
            echo "Invalid number. Please enter a positive integer."
        fi
    done

columns=()
col_types=()
pk_column=""

# loop through each column
for (( i=1; i<=No_of_columns; i++ ));
    do
        # column name
        while true;
            do
                read -p "Enter column $i Name: " col_name
                if [[ $col_name =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]];
                then
                    columns+=("$col_name")
                    break
                else
                    echo "Invalid column name."
                fi
            done

        # column data type
        while true;
            do
                read -p "enter column $i data type: ( int , string , float ) " data_type
                data_type=${data_type,,}
                if [[ "$data_type" == "int" || "$data_type" == "string" || "$data_type" == "float" ]];
                then
                    col_types+=("$data_type")
                    break
                else
                    echo "Invalid data type"
                fi
            done

        # primary key
        if [[ -z "$pk_column" ]];
        then
            while true;
                do
                    read -p "Set this column as primary key? (yes/no): " pk_cons
                    pk_cons=${pk_cons,,}

                    if [[ "$pk_cons" == "yes" || "$pk_cons" == "y" ]];
                    then
                        pk_column="$col_name"
                        break
                    elif [[ "$pk_cons" == "no" || "$pk_cons" == "n" ]];
                    then
                        break
                    else
                        echo "Please answer with a yes or no."
                    fi
                done
        fi
    done   # end columns loop

# meta data file
meta_file="${table}.meta"
> "$meta_file"     # create / clear metadata file

for (( i=0; i<No_of_columns; i++ ));
    do
        if [[ "${columns[$i]}" == "$pk_column" ]];
        then
            echo "${columns[$i]},${col_types[$i]},pk" >> "$meta_file"
        else
            echo "${columns[$i]},${col_types[$i]}" >> "$meta_file"
        fi
    done

# create table file
touch "$table.data"

echo -e "\e[32mtable '$table' was created successfully.\e[0m"
