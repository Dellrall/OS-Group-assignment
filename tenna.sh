#!/bin/bash

# tenna.sh made by Lye Wei Lun

# Enable alternate screen buffer
tput smcup             # Save current terminal content and switch to alternate buffer
trap 'tput rmcup' EXIT # Restore original terminal content on exit

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
selection=($a $s $u $d $m $t $p)

# Print the menu
show_menu() {
  printf '%s\n\n' "$title"
  printf '%s\n' "$a" "$s" "$u" "$d" "$m" "$t" "$p"
  printf '\n%s\n\n' "$q"
}

# Main menu
main_menu() {
  # Main loop
  while true; do
    clear
    show_menu
    # Read user input and validate input
    read -rp "$select" choice
     choice=${choice//[[:space:]]/}

  if [[ ${#choice} -ne 1 ]]; then
      echo "Invalid: enter exactly one letter."
      printf '\nPress Enter to continue...'; read -r _
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
        Q) break ;;
        *) echo "Invalid option. Try again." ;;
    esac
    printf '\nPress Enter to continue...'
    read -r _
  done
}

#========================================Task 2========================================
# Task 2: Implement Add Equipment function

# Add Equipment
add_equipment() {







 }
#========================================Task 3========================================
# Task 3: Implement Search Equipment function

# Search Equipment
search_equipment() {




}

#========================================Task 4========================================
# Task 4: Implement Update Equipment function

# Update Equipment
update_equipment() {




}

#========================================Task 5========================================
# Task 5: Implement Delete Equipment function

# Delete Equipment
delete_equipment() {




}

#========================================Task 6========================================

# Sort by Model
sort_by_model() {



}
#--------------------------------------------------------------------------------------
# Sort by Status
sort_by_status() {



}
#--------------------------------------------------------------------------------------
# Sort by Type
sort_by_type() {



}
#--------------------------------------------------------------------------------------


main_menu 