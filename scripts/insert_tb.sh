#!  /bin/bash
# Program to insert inside table 
read -p "Enter table name: " table

if [[ ! -f "$table.data" || ! -f "$table.meta" ]]; then
    echo -e "\e[31mTable Doesn't Exist.\e[0m"
    return
fi

record=""
pk_index=0
col_index=1
declare -a columns
declare -a datatypes
declare -a constraints

while IFS=',' read -r col datatype constraint; 
do
    columns+=("$col")
    datatypes+=("$datatype")
    constraints+=("$constraint")
    if [[ "$constraint" == "pk" ]]; then
        pk_index=$col_index
    fi
    ((col_index++))
done < "$table.meta"

total_cols=${#columns[@]}


pk_value=""
if [[ $pk_index -ne 0 && "${datatypes[$((pk_index-1))]}" == "int" ]];
    then
    if [[ -s "$table.data" ]]; 
    then
        last_pk=$(cut -d ',' -f"$pk_index" "$table.data" | sort -n | tail -1)
        pk_value=$(( last_pk + 1 ))
    else
        pk_value=1
    fi
    echo "Auto-generated ${columns[$((pk_index-1))]} = $pk_value"
fi


for ((i=0; i<total_cols; i++)); 
do
    col="${columns[$i]}"
    datatype="${datatypes[$i]}"
    constraint="${constraints[$i]}"
    value=""

    if [[ $((i+1)) -eq $pk_index && "$datatype" == "int" ]]; 
    then
        
        value="$pk_value"
    else
        while true; do
            read -p "Enter $col ($datatype): " value

            
            if [[ -z "$value" ]]; 
            then
                echo "$col can't be null"
                continue
            fi

            
            case $datatype in
                int)
                    [[ "$value" =~ ^[0-9]+$ ]] || { echo "Must be an integer"; continue; }
                    ;;
                float)
                    [[ "$value" =~ ^[0-9]+(\.[0-9]+)?$ ]] || { echo "Must be a float"; continue; }
                    ;;
                string)
                    ;;
                *)
                    echo "Unknown datatype $datatype"; continue
                    ;;
            esac

        
            if [[ "$constraint" == "unique" || "$constraint" == "pk" ]]; 
            then
                if [[ -s "$table.data" ]]; then
                    if cut -d',' -f$((i+1)) "$table.data" | grep -Fxq "$value"; 
                    then
                        echo "$col must be unique, value already exists"
                        continue
                    fi
                fi
            fi

            break
        done
    fi

    record+="$value,"
done


record="${record::-1}"


echo "$record" >> "$table.data"
echo -e "\e[32mRecord inserted successfully\e[0m"
