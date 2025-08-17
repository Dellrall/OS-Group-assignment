#!/bin/bash

# tenna.sh made by Lye Wei Lun

# Enable alternate screen buffer
#tput smcup             # Save current terminal content and switch to alternate buffer
#trap 'tput rmcup' EXIT # Restore original terminal content on exit

# =======================================Task 1========================================
# Task 1: Implement Main menu and page selection


# Variables
title="Equipment Maintenance Menu"
a="A - Add New Computer Lab Equipment Details"
s="S - Search Equipment by Serial Number"
u="U - Update an Equipmement Details"
d="D - Delete an Equipmement Details"
m="M - Sort Equipment by Model"
t="T - Sort Equipment by Status"
p="P - Sort Equipment by Type"
q="Q - Exit from Program"
select="Please select a choice: "

# Print the menu
show_menu() {
  printf '%s\n\n' "$title"
  printf '%s\n' "$a" "$s" "$u" "$d" "$m" "$t" "$p"
  printf '\n%s\n\n' "$q"
}


#========================================Task 2========================================
# Task 2: Implement Add Equipment function

#--------------------------------------------------------------------------------------
#Validate date format function
validate_date() {
  local date_input=$1
  local error_msg=$2
  local format=${3:-"MM-DD-YYYY"}  # Default format
    
    case $format in
      "MM-DD-YYYY")
        # Check format
        if [[ ! "$date_input" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
          echo "$error_msg Format must be MM-DD-YYYY."
          return 1
        fi
        
        # Extract month, day, year
        local month=${date_input:0:2}
        local day=${date_input:3:2}
        local year=${date_input:6:4}
        ;;
        
      "YYYY-MM-DD")
        # Check format
        if [[ ! "$date_input" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
          echo "$error_msg Format must be YYYY-MM-DD."
          return 1
        fi
  
      # Extract year, month, day
      local year=${date_input:0:4}
      local month=${date_input:5:2}
      local day=${date_input:8:2}
      ;;
      
    *)
      echo "Unsupported date format: $format"
      return 1
      ;;
  esac
  
  # Remove leading zeros
  month=$((10#$month))
  day=$((10#$day))
  
  # Check month range
  if (( month < 1 || month > 12 )); then
    echo "$error_msg Month must be between 01 and 12."
    return 1
  fi
  
  # Check day range based on month
  local days_in_month=31
  case $month in
    4|6|9|11) days_in_month=30 ;;
    2)
      # Check for leap year
      if (( year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) )); then
        days_in_month=29
      else
        days_in_month=28
      fi
      ;;
  esac
  
if (( day < 1 || day > days_in_month )); then
    echo "$error_msg Day must be between 01 and $days_in_month for month $month."
    return 1
  fi
  
  # Check for reasonable year (optional)
  if (( year < 1900 || year > 2100 )); then
    echo "$error_msg Year must be between 1900 and 2100."
    return 1
  fi
  
  return 0
}

#--------------------------------------------------------------------------------------
# Date conversion function
convert_date_format() {
  local date_input=$1
  local from_format=$2
  local to_format=$3
  
  case "$from_format:$to_format" in
    "MM-DD-YYYY:YYYY-MM-DD")
      # MM-DD-YYYY to YYYY-MM-DD
      echo "${date_input:6:4}-${date_input:0:2}-${date_input:3:2}"
      ;;
    "YYYY-MM-DD:MM-DD-YYYY")
      # YYYY-MM-DD to MM-DD-YYYY
      echo "${date_input:5:2}-${date_input:8:2}-${date_input:0:4}"
      ;;
    *)
      # Same format or unsupported conversion
      echo "$date_input"
      ;;
  esac
}
#--------------------------------------------------------------------------------------
# Null check function
null_check() {
  local input_value="$1"
  local field_name="$2"
  local error_lines="${3:-2}"  # Default to 2 lines to clear
  
  if [[ -z "$input_value" ]]; then
    echo "$field_name cannot be empty."
    sleep 2
    tput cuu $error_lines
    tput ed
    return 1
  fi
  return 0
}

#--------------------------------------------------------------------------------------
# Add Equipment
add_equipment() {
  clear
  choice="Y"
  confirmation(){
     read -rp "Add another new Equipment details? (y)es or (q)uit : " choice
     choice=${choice^^}
  }
  while true; do
    if [[ $choice == "Y" ]]; then
        clear
        printf '%s\n' "Add Equipment Details Form"
        printf '%s\n' "==========================="
        # Input Equipment ID
        while true; do
          read -rp "Equipment ID(format E0001): " equipment_id
          if null_check "$equipment_id" "Equipment ID"; then
            if [[ ! "$equipment_id" =~ ^[E][0-9]{4}$ ]]; then
                echo "Invalid Equipment ID format. Please use the format: E0001"
                sleep 2
                tput cuu 3
                tput ed
            elif [[ -f Equipment.txt && -n $(grep -w "$equipment_id" Equipment.txt) ]]; then
                echo "Equipment ID already exists. Please enter a unique ID."
                sleep 2
                tput cuu 2
                tput ed                
          else
              break
              fi
          fi
        done

        while true; do
        read -rp "Type: " equipment_type
          if null_check "$equipment_type" "Equipment Type"; then
          if [[ ! "$equipment_type" == "keyboard" && ! "$equipment_type" == "mouse" && ! "$equipment_type" == "monitor" && ! "$equipment_type" == "webcam" && ! "$equipment_type" == "mousepad" && ! "$equipment_type" == "laptop" ]]; then
              echo "Invalid equipment type. Please enter keyboard, mouse, monitor, webcam, mousepad, or laptop."
              sleep 2
              tput cuu 2
              tput ed
          else
              break
              fi
          fi
        done
        
        while true; do
          read -rp "Model: " equipment_model
          if null_check "$equipment_model" "Equipment Model"; then
            break
          fi
        done


        while true; do
        read -rp "Serial Number: " equipment_serial
          if null_check "$equipment_serial" "Equipment Serial Number"; then
            if [[ ! "$equipment_serial" =~ ^[A-Z]{2}[0-9]{9}$ ]]; then
              echo "Invalid Serial Number format. Please use the format: AB123456789"
              sleep 2
              tput cuu 2
              tput ed
            elif [[ -f Equipment.txt && -n $(grep -w "$equipment_serial" Equipment.txt) ]]; then
              echo "Serial Number already exists. Please enter a unique Serial Number."
              sleep 2
              tput cuu 2
              tput ed
          else
              break
              fi
          fi
        done

        while true; do
        read -rp "Status (Available/Unavailable): " equipment_status
          if null_check "$equipment_status" "Equipment Status"; then
          if [[ ! "$equipment_status" == "Available" && ! "$equipment_status" == "Unavailable" ]]; then
              echo "Invalid status. Please enter Available or Unavailable."
              sleep 2
              tput cuu 2
              tput ed
          else
              break
              fi
          fi
        done
        

        while true; do
          # Get current date in MM-DD-YYYY format
          current_date=$(date +"%m-%d-%Y")
        read -rp "Purchase Date (MM-DD-YYYY) [${current_date}]: " equipment_purchase_date
        if [[ -z "$equipment_purchase_date" ]]; then
            equipment_purchase_date="$current_date"
          break
        fi

        if ! validate_date "$equipment_purchase_date" "Invalid purchase date."; then
            echo "Invalid date format. Please use MM-DD-YYYY."
            sleep 2
            tput cuu 2
            tput ed
        else
            break
        fi
        done

        while true; do
          read -rp "Warranty Date (MM-DD-YYYY): " equipment_expiry_date
  
          # First validate the date format
          if ! validate_date "$equipment_expiry_date" "Invalid warranty date."; then
            sleep 2
            tput cuu 2
            tput ed
            continue
          fi
          
            # Convert MM-DD-YYYY to YYYY-MM-DD format for date command
              purchase_iso=$(echo "${equipment_purchase_date}" | awk -F'-' '{print $3"-"$1"-"$2}')
              warranty_iso=$(echo "${equipment_expiry_date}" | awk -F'-' '{print $3"-"$1"-"$2}')
          # Convert dates to seconds since epoch for comparison
           if ! purchase_date_seconds=$(date -d "${purchase_iso}" +%s 2>/dev/null) || 
              ! warranty_date_seconds=$(date -d "${warranty_iso}" +%s 2>/dev/null); then
              echo "Error processing dates."
              sleep 2
              tput cuu 2
              tput ed
              continue
            fi
          
          # Calculate difference in days
          difference_days=$(( (warranty_date_seconds - purchase_date_seconds) / 86400 ))
          
          # Check if warranty date is at least 30 days after purchase date
          if (( difference_days < 30 )); then
              echo "Warranty date must be at least 30 days after purchase date."
              sleep 2
              tput cuu 2
              tput ed
              continue
            fi
            break
          done

        if [ ! -f Equipment.txt ]; then
          touch Equipment.txt
          echo "ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate" >> Equipment.txt
          echo "$equipment_id:$equipment_type:$equipment_model:$equipment_serial:$equipment_status:$equipment_purchase_date:$equipment_expiry_date" >> Equipment.txt
        else
          echo "$equipment_id:$equipment_type:$equipment_model:$equipment_serial:$equipment_status:$equipment_purchase_date:$equipment_expiry_date" >> Equipment.txt
        fi

        #Return or add new equipment
        printf '\n%s\n\n' "Press (q) to return to Equipment Maintenance Menu."
        confirmation
    elif [[ "$choice" == "Q" ]]; then
        echo "Returning to Equipment Maintenance Menu...."
        sleep 2
        break
      else
        printf "\nInvalid choice, please enter either y or q"
        sleep 2
        tput cuu 3
        tput ed
        printf '\n'
        confirmation
      fi
done
}
#========================================Task 3========================================
# Task 3: Implement Search Equipment function

# Search Equipment
search_equipment() {
  clear
  search_another="Y"
  confirmation() {
    read -rp "Search another Equipment? (y)es or (q)uit: " search_another
    search_another=${search_another^^}
  }


printf '%s\n\n' "Search Equipment"
while [[ "$search_another" == "Y" ]]; do
  if [ ! -f Equipment.txt ]; then
    echo "No equipment registered yet, please register equipment first."
    echo "-------------------------------------------------------------------------"
    sleep 4
    break
  fi
    
  echo "Please enter the Serial Number of the equipment you want to search for."
    read -rp "Enter Serial Number: " EquipSerial
    echo "-------------------------------------------------------------------------"
    if null_check "$EquipSerial" "Equipment Serial"; then
      if   [[ ! "$EquipSerial" =~ ^[A-Z]{2}[0-9]{9}$ ]]; then
                echo "Invalid Serial Number format. Please use the format: AB123456789"
                sleep 2
                tput cuu 2
                tput ed
                continue
      elif  ! grep -q ":$EquipSerial:" Equipment.txt ; then
              echo "No equipment found with serial number: $EquipSerial"
              sleep 2
              tput cuu 2
              tput ed
              continue
    fi
  


  #Find the matching record and extract fields
  record=$(grep ":$EquipSerial:" Equipment.txt)
  #Get infor from information field separator
  IFS=':' read -r eq_id eq_type eq_model eq_serial eq_status eq_purchase_date eq_expiry_date <<< "$record"

    printf '\n'
    echo "Equipment ID: $eq_id"
    echo "Type: $eq_type"
    echo "Model: $eq_model"
    echo "Serial: $eq_serial"
    echo "Status: $eq_status"
    echo "Purchase Date: $eq_purchase_date"
    echo "Warranty Date: $eq_expiry_date"
    printf '\n'
    echo "-------------------------------------------------------------------------"

    printf '\n\n%s\n\n' "Press (q) to return to Equipment Maintenance Menu."
    read -rp "Search another Equipment? (y)es or (q)uit: " search_another
    search_another=${search_another^^}
    
elif [[ $search_another == "Q" ]]; then
            echo "Returning to Equipment Maintenance Menu...."
            sleep 2
            break
        else
            echo "Invalid choice, please enter either y or q"
            sleep 2
            tput cuu 3
            tput ed
            printf '\n'
            confirmation
    fi
done
}

#========================================Task 4========================================
# Task 4: Implement Update Equipment function

# Update Equipment
update_equipment() {
  clear
  update_another="Y"
  confirmation() {
    read -rp "Update another Equipment? (y)es or (q)uit: " update_another
    update_another=${update_another^^}
  }

  printf '%s\n\n' "Update Equipment Details"
while [[ $update_another == "Y" ]]; do
    if [ ! -f Equipment.txt ]; then
        echo "No equipment registered yet, please register equipment first."
        echo "-------------------------------------------------------------------------"
        sleep 4
        break
      fi
      read -rp "Enter Equipment ID: " equipment_id
      echo "-------------------------------------------------------------------------"
        # Check if equipment exists
        if null_check "$equipment_id" "Equipment ID"; then
          if equipment_id=$(echo "$equipment_id" | tr -d '[:space:]'); then
          if [[ ! "$equipment_id" =~ ^[E][0-9]{4}$ ]]; then
            echo "Invalid Equipment ID format. Please use the format: E0001"
            sleep 2
            tput cuu 2
            tput ed
            continue
          fi
            if ! grep -q ":$equipment_id:" Equipment.txt; then
              echo "No equipment found with ID: $equipment_id"
              sleep 2
              tput cuu 2
              tput ed
              continue
          fi
          fi
        fi

      
        # Find the matching record and extract fields
        record=$(grep ":$equipment_id:" Equipment.txt)
        # Get info from information field separator
        IFS=':' read -r eq_id eq_type eq_model eq_serial eq_status eq_purchase_date eq_expiry_date <<< "$record"

        # Prompt for new values
        while true; do
          read -rp "New Serial Number: " new_serial
          if [[ -n $new_serial ]]; then
            if [[ ! "$new_serial" =~ ^[A-Z]{2}[0-9]{9}$ ]]; then
              echo "Invalid Serial Number format. Keeping current value."
              sleep 2
              tput cuu 1
              tput ed
              new_serial=""
              
            fi
          fi
          break
        done

        while true; do
          read -rp "New Type: " new_type
          if [[ -n $new_type ]]; then
            if [[ ! "$new_type" == "keyboard" && ! "$new_type" == "mouse" && ! "$new_type" == "monitor" && ! "$new_type" == "webcam" && ! "$new_type" == "mousepad" && ! "$new_type" == "laptop" ]]; then
              echo "Invalid equipment type. Keeping current value."
              sleep 2
              tput cuu 1
              tput ed
              new_type=""
            fi
          fi
          break
        done

        while true; do
          read -rp "New Model: " new_model
          if [[ -n $new_model ]]; then
            if [[ ! "$new_model" =~ ^[A-Za-z0-9\ ]+$ ]]; then
              echo "Invalid Model format. Keeping current value."
              sleep 2
              tput cuu 1
              tput ed
              new_model=""

            fi
          fi
          break
        done

        while true; do
          read -rp "New Status: " new_status
          if [[ -n $new_status ]]; then
            if [[ ! "$new_status" == "Available" && ! "$new_status" == "Unavailable" ]]; then
              echo "Invalid status. Keeping current value."
              sleep 2
              tput cuu 1
              tput ed
              new_status=""
              break
            fi
          fi
          break
        done

        # Purchase Date with format validation
          while true; do
            read -rp "New Purchase Date: " new_purchase_date
            if [[ -z "$new_purchase_date" ]]; then
              break
            fi
            if validate_date "$new_purchase_date" "Invalid purchase date." "MM-DD-YYYY"; then
              break
            else
              echo "Please try again or leave empty to keep current date."
            fi
            break
          done

        # Warranty Date with format validation
          while true; do
            read -rp "New Warranty Date: " new_expiry_date
            if [[ -z "$new_expiry_date" ]]; then
              break
            fi
            if validate_date "$new_expiry_date" "Invalid warranty date." "MM-DD-YYYY"; then
              sleep 2
              tput cuu 2
              tput ed
              continue
            fi

            # Check if warranty is at least 30 days after purchase
              purchase_check_date=${new_purchase_date:-$eq_purchase_date}
              purchase_iso=$(convert_date_format "$purchase_check_date" "MM-DD-YYYY" "YYYY-MM-DD")
              warranty_iso=$(convert_date_format "$new_expiry_date" "MM-DD-YYYY" "YYYY-MM-DD")
              
              
              if purchase_date_seconds=$(date -d "${purchase_iso}" +%s 2>/dev/null) && 
                warranty_date_seconds=$(date -d "${warranty_iso}" +%s 2>/dev/null); then
                echo "Error processing dates. Please try again."
              fi
                difference_days=$(( (warranty_date_seconds - purchase_date_seconds) / 86400 ))
                if (( difference_days >= 30 )); then
                  echo "Warranty date must be at least 30 days after purchase date."
                  continue
                fi
                break
          done
     

        # Update fields if new values are provided
        [[ -n $new_type ]] && eq_type=$new_type
        [[ -n $new_model ]] && eq_model=$new_model
        [[ -n $new_serial ]] && eq_serial=$new_serial
        [[ -n $new_status ]] && eq_status=$new_status
        [[ -n $new_purchase_date ]] && eq_purchase_date=$new_purchase_date
        [[ -n $new_expiry_date ]] && eq_expiry_date=$new_expiry_date

        # Create updated record
        updated_record="$eq_id:$eq_type:$eq_model:$eq_serial:$eq_status:$eq_purchase_date:$eq_expiry_date"

        # Replace old record with updated record
        sed -i "s|^$record|$updated_record|" Equipment.txt

        confirmation
if [[ $update_another == "Y" ]]; then
      update_equipment
  
elif [[ $update_another == "Q" ]]; then
        echo "Returning to Equipment Maintenance Menu...."
        sleep 2
        break
      else
        echo "Invalid choice, please enter either y or q"
        sleep 2
        tput cuu 3
        tput ed
        printf '\n'
        confirmation
    fi
done
}


#========================================Task 5========================================
# Task 5: Implement Delete Equipment function

# Delete Equipment
delete_equipment() {
  echo "nothing"

}

#========================================Task 6========================================

# Sort by Model
sort_by_model() {
  echo "nothing"

}
#--------------------------------------------------------------------------------------
# Sort by Status
sort_by_status() {

  echo "nothing"

}
#--------------------------------------------------------------------------------------
# Sort by Type
sort_by_type() {

  echo "nothing"

}
#--------------------------------------------------------------------------------------

# Main menu
main_menu() {
  # Read function
  read_input(){
    clear
    show_menu
    read -rp "$select" choice
     choice=${choice//[[:space:]]/}
    }
  # Main loop
  while true; do
    # Read user input and validate input
    read_input
    if [[ ${#choice} -ne 1 ]]; then
        echo "Invalid: enter exactly one letter."
        sleep 2 
        tput cuu 3
        tput ed
        echo
        continue
      fi
      # Normalize to uppercase first letter only
      
      choice=${choice^^}
        case ${choice:0:1} in
          A) add_equipment ;;
          S) search_equipment ;;
          U) update_equipment ;;
          D) delete_equipment ;;
          M) sort_by_model ;;
          T) sort_by_status ;;
          Q) echo "Exiting program..."
          sleep 2
          break ;;
          *) echo "Invalid option. Try again." ;;
     esac
        sleep 2 
        tput cuu 3
        tput ed
        echo
        continue
  done
}

main_menu 

exit 0