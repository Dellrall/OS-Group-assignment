#!/opt/homebrew/bin/bash

#===============================================================================
# TENNA - EQUIPMENT MANAGEMENT SYSTEM
#===============================================================================
# Script Name: tenna.sh
# Authors: Lye Wei Lun, Lim Yung Juin, Swetha
# Description: A comprehensive command-line equipment management system that
#              allows users to add, search, update, delete, and sort equipment
#              records with a beautiful terminal UI inspired by anime aesthetics.
#
# Features:
# - Add new equipment with auto-generated IDs
# - Search equipment by serial number
# - Update existing equipment details
# - Delete equipment records
# - Sort and display equipment by model, status, or type
# - Export reports to text files
# - Input validation and error handling
# - Colorful terminal interface with multiple themes
#
# Data Format: Equipment.txt stores data in CSV format with fields:
# ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate
#===============================================================================

#===============================================================================
# COLOR CONFIGURATION SECTION
#===============================================================================
# This section defines all color codes and themes used throughout the application.
# The color scheme is inspired by Monogatari anime series characters.

#------------------------------------------------------------------------------
# BASE COLOR PALETTE - Ononoki Yotsugi inspired
#------------------------------------------------------------------------------
ORANGE_BG="\033[48;5;208m" # Orange background (title bars)
WHITE_TEXT="\033[97m"      # White text
BLACK_TEXT="\033[30m"      # Black text
CYAN_HIGHLIGHT="\033[96m"  # Cyan highlights
SOFT_YELLOW="\033[93m"     # Soft yellow for options
LIGHT_GRAY="\033[37m"      # Light gray for regular text
BOLD="\033[1m"             # Bold text
RED_ERROR="\033[91m"       # Red for errors
GREEN_SUCCESS="\033[92m"   # Green for success
RESET="\033[0m"            # Reset all formatting

#------------------------------------------------------------------------------
# CHARACTER-SPECIFIC COLOR THEMES
#------------------------------------------------------------------------------

# Senjougahara Hitagi - Purple/Violet theme (elegant, sophisticated)
# Used for: Sort by Model functionality
SENJOU_HEADER="\033[48;5;98m" # Deep purple background
SENJOU_CATEGORY="\033[95m"    # Bright magenta for categories
SENJOU_HIGHLIGHT="\033[35m"   # Purple for highlighted data
SENJOU_DATA="\033[38;5;183m"  # Soft lavender for regular data

# Hachikuji Mayoi - White/Black/Green theme (school uniform colors)
# Used for: Sort by Status functionality
MAYOI_HEADER="\033[48;5;22m" # Dark green background
MAYOI_CATEGORY="\033[97m"    # Bright white for categories
MAYOI_HIGHLIGHT="\033[92m"   # Bright green for highlighted data
MAYOI_DATA="\033[37m"        # Light gray for regular data

# Shinobu Oshino (Monogatari) - Golden blonde/elegant cream theme
# Used for: Sort by Type functionality
SHINOBU_HEADER="\033[48;5;220m"    # Golden yellow background
SHINOBU_CATEGORY="\033[38;5;136m"  # Dark golden brown for categories
SHINOBU_HIGHLIGHT="\033[38;5;178m" # Bright gold for highlighted data
SHINOBU_DATA="\033[38;5;230m"      # Cream/ivory for regular data

#===============================================================================
# DISPLAY UTILITY FUNCTIONS
#===============================================================================

#------------------------------------------------------------------------------
# Function: print_title_bar
# Purpose: Creates a full-width orange title bar with centered text
# Parameters: $1 - The title text to display
# Usage: print_title_bar "Equipment Management System"
#------------------------------------------------------------------------------
print_title_bar() {
  local title="$1"
  local term_width=$(tput cols 2>/dev/null || echo "80")
  local title_length=${#title}
  local padding=$(((term_width - title_length) / 2))

  # Create infinite-width orange background that spans full terminal
  printf "${ORANGE_BG}${WHITE_TEXT}${BOLD}"

  # Fill entire line with orange background
  for ((i = 0; i < term_width; i++)); do
    printf " "
  done

  # Move cursor back to beginning and print centered title
  printf "\r"
  printf "%*s%s%*s" "$padding" "" "$title" "$((term_width - padding - title_length))" ""
  printf "${RESET}\n"
}

#------------------------------------------------------------------------------
# CHARACTER-SPECIFIC TITLE BAR FUNCTIONS
# These functions create themed title bars for different sections of the app
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Function: print_senjou_title_bar
# Purpose: Creates a purple-themed title bar (Senjougahara Hitagi theme)
# Used for: Sort by Model functionality
# Parameters: $1 - The title text to display
#------------------------------------------------------------------------------
print_senjou_title_bar() {
  local title="$1"
  local term_width=$(tput cols 2>/dev/null || echo "80")
  local title_length=${#title}
  local padding=$(((term_width - title_length) / 2))

  printf "${SENJOU_HEADER}${WHITE_TEXT}${BOLD}"
  for ((i = 0; i < term_width; i++)); do
    printf " "
  done
  printf "\r"
  printf "%*s%s%*s" "$padding" "" "$title" "$((term_width - padding - title_length))" ""
  printf "${RESET}\n"
}

#------------------------------------------------------------------------------
# Function: print_mayoi_title_bar
# Purpose: Creates a green-themed title bar (Hachikuji Mayoi theme)
# Used for: Sort by Status functionality
# Parameters: $1 - The title text to display
#------------------------------------------------------------------------------
print_mayoi_title_bar() {
  local title="$1"
  local term_width=$(tput cols 2>/dev/null || echo "80")
  local title_length=${#title}
  local padding=$(((term_width - title_length) / 2))

  printf "${MAYOI_HEADER}${WHITE_TEXT}${BOLD}"
  for ((i = 0; i < term_width; i++)); do
    printf " "
  done
  printf "\r"
  printf "%*s%s%*s" "$padding" "" "$title" "$((term_width - padding - title_length))" ""
  printf "${RESET}\n"
}

#------------------------------------------------------------------------------
# Function: print_shinobu_title_bar
# Purpose: Creates a golden-themed title bar (Shinobu Oshino theme)
# Used for: Sort by Type functionality
# Parameters: $1 - The title text to display
#------------------------------------------------------------------------------
print_shinobu_title_bar() {
  local title="$1"
  local term_width=$(tput cols 2>/dev/null || echo "80")
  local title_length=${#title}
  local padding=$(((term_width - title_length) / 2))

  printf "${SHINOBU_HEADER}${BLACK_TEXT}${BOLD}"
  for ((i = 0; i < term_width; i++)); do
    printf " "
  done
  printf "\r"
  printf "%*s%s%*s" "$padding" "" "$title" "$((term_width - padding - title_length))" ""
  printf "${RESET}\n"
}

#------------------------------------------------------------------------------
# Function: print_colored
# Purpose: Prints text with specified color formatting
# Parameters: $1 - Color code, $2 - Text to print
#------------------------------------------------------------------------------
print_colored() {
  local color="$1"
  local text="$2"
  printf "${color}%s${RESET}" "$text"
}

#------------------------------------------------------------------------------
# Function: print_success
# Purpose: Displays success messages in green color with checkmark
# Parameters: $1 - Success message to display
#------------------------------------------------------------------------------
print_success() {
  local text="$1"
  printf "${GREEN_SUCCESS}✓ %s${RESET}\n" "$text"
}

#------------------------------------------------------------------------------
# Function: print_error
# Purpose: Displays error messages in red color with X mark
# Parameters: $1 - Error message to display
#------------------------------------------------------------------------------
print_error() {
  local text="$1"
  printf "${RED_ERROR}✗ %s${RESET}\n" "$text"
}

#------------------------------------------------------------------------------
# Function: center_text
# Purpose: Centers text horizontally in the terminal
# Parameters: $1 - Text to center, $2 - Optional color (defaults to LIGHT_GRAY)
# Note: Properly handles ANSI escape sequences for accurate centering
#------------------------------------------------------------------------------
center_text() {
  local text="$1"
  local color="${2:-$LIGHT_GRAY}"
  local term_width=$(tput cols 2>/dev/null || echo "80")

  # Calculate text length without ANSI escape sequences for proper centering
  local clean_text=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
  local text_length=${#clean_text}
  local padding=$(((term_width - text_length) / 2))

  [[ $padding -lt 0 ]] && padding=0
  printf "%*s" "$padding" ""
  echo -e "${color}${text}${RESET}"
}

#===============================================================================
# TERMINAL SETUP AND CONFIGURATION
#===============================================================================

# Enable alternate screen buffer to preserve user's terminal content
tput smcup             # Save current terminal content and switch to alternate buffer
trap 'tput rmcup' EXIT # Restore original terminal content on exit

#===============================================================================
# TASK 1: MAIN MENU IMPLEMENTATION
#===============================================================================
# This section implements the main menu interface and navigation system

#------------------------------------------------------------------------------
# MENU OPTION DEFINITIONS
# These variables define the menu options displayed to the user
#------------------------------------------------------------------------------
title="Equipment Maintenance Menu"
a="A - Add New Computer Lab Equipment Details"
s="S - Search Equipment by Serial Number"
u="U - Update an Equipment Details"
d="D - Delete an Equipment Details"
m="M - Sort Equipment by Model"
t="T - Sort equipment by Status"
p="P - Sort equipment by Type"
q="Q - Exit from Program"
select="Please select a choice: "

#------------------------------------------------------------------------------
# Function: show_menu
# Purpose: Displays the main menu interface with centered, styled options
# Features:
# - Beautiful orange title bar
# - Centered menu with Unicode box drawing
# - Color-coded options and highlights
# - Responsive to terminal width
#------------------------------------------------------------------------------
show_menu() {
  clear
  echo ""

  # Beautiful orange title bar with white text
  print_title_bar "Tenna - Equipment Management System"
  echo ""
  echo ""

  # Center the menu with proper Unicode box alignment
  center_text "╔══════════════════════════════════════════════════╗"
  center_text "║                                                  ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}A${RESET} - ${SOFT_YELLOW}Add Equipment${RESET}                    ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}S${RESET} - ${SOFT_YELLOW}Search Equipment${RESET}                 ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}U${RESET} - ${SOFT_YELLOW}Update Equipment${RESET}                 ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}D${RESET} - ${SOFT_YELLOW}Delete Equipment${RESET}                 ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}M${RESET} - ${SOFT_YELLOW}Sort by Model${RESET}                    ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}T${RESET} - ${SOFT_YELLOW}Sort by Status${RESET}                   ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}P${RESET} - ${SOFT_YELLOW}Sort by Type${RESET}                     ║"
  center_text "║                                                  ║"
  center_text "║             ${CYAN_HIGHLIGHT}${BOLD}Q${RESET} - ${SOFT_YELLOW}Quit${RESET}                             ║"
  center_text "║                                                  ║"
  center_text "╚══════════════════════════════════════════════════╝"
  echo ""
  printf "${CYAN_HIGHLIGHT}Please select a choice: ${RESET}"
}

#===============================================================================
# TASK 2: ADD EQUIPMENT FUNCTIONALITY
#===============================================================================
# This section implements the equipment addition feature with comprehensive
# input validation and data management

#------------------------------------------------------------------------------
# Function: validate_date
# Purpose: Validates date input in specified format and checks logical validity
# Parameters:
#   $1 - Date input string
#   $2 - Error message prefix
#   $3 - Date format (optional, defaults to "MM-DD-YYYY")
# Returns: 0 if valid, 1 if invalid
# Supports: MM-DD-YYYY and YYYY-MM-DD formats
# Features:
# - Format validation using regex
# - Month range validation (1-12)
# - Day range validation based on month
# - Leap year calculation for February
#------------------------------------------------------------------------------
validate_date() {
  local date_input=$1
  local error_msg=$2
  local format=${3:-"MM-DD-YYYY"} # Default format

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
  if ((month < 1 || month > 12)); then
    echo "$error_msg Month must be between 01 and 12."
    return 1
  fi

  # Check day range based on month
  local days_in_month=31
  case $month in
  4 | 6 | 9 | 11) days_in_month=30 ;;
  2)
    # Check for leap year
    if ((year % 400 == 0 || (year % 4 == 0 && year % 100 != 0))); then
      days_in_month=29
    else
      days_in_month=28
    fi
    ;;
  esac

  if ((day < 1 || day > days_in_month)); then
    echo "$error_msg Day must be between 01 and $days_in_month for month $month."
    return 1
  fi

  # Check for reasonable year (optional)
  if ((year < 1900 || year > 2100)); then
    echo "$error_msg Year must be between 1900 and 2100."
    return 1
  fi

  return 0
}

#------------------------------------------------------------------------------
# Function: convert_date_format
# Purpose: Converts dates between MM-DD-YYYY and YYYY-MM-DD formats
# Parameters:
#   $1 - Input date string
#   $2 - Source format ("MM-DD-YYYY" or "YYYY-MM-DD")
#   $3 - Target format ("MM-DD-YYYY" or "YYYY-MM-DD")
# Returns: Converted date string
# Usage: convert_date_format "12-25-2023" "MM-DD-YYYY" "YYYY-MM-DD"
#------------------------------------------------------------------------------
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

#===============================================================================
# TABLE FORMATTING AND DISPLAY UTILITIES
#===============================================================================

#------------------------------------------------------------------------------
# Function: center_table_line
# Purpose: Centers a table line horizontally in the terminal
# Parameters: $1 - Line of text to center
# Features: Auto-detects terminal width, handles edge cases
#------------------------------------------------------------------------------
center_table_line() {
  local line="$1"
  local term_width=$(tput cols 2>/dev/null || echo 120)
  local line_length=${#line}

  # Calculate padding needed on each side
  local padding=$(((term_width - line_length) / 2))

  # Ensure padding is not negative
  [[ $padding -lt 0 ]] && padding=0

  # Print the centered line
  printf "%*s%s\n" "$padding" "" "$line"
}

#------------------------------------------------------------------------------
# Function: format_equipment_table
# Purpose: Creates a responsive, formatted table for equipment data display
# Parameters: Array of equipment data rows (colon-separated values)
# Global Variables Used:
#   - INCLUDE_PURCHASE_DATE: Boolean flag to include/exclude purchase date column
# Features:
# - Responsive column width calculation based on terminal size
# - Dynamic header generation based on purchase date inclusion
# - Automatic column width adjustment for terminal fit
# - Professional table formatting with borders and alignment
# - Date format conversion for display
#------------------------------------------------------------------------------
format_equipment_table() {
  local -a data_rows=("$@")
  local include_purchase_date=${INCLUDE_PURCHASE_DATE:-false}

  # Get terminal width, default to 120 if not available
  local term_width
  term_width=$(tput cols 2>/dev/null || echo "120")

  # Define column headers
  local headers=("Model" "Equipment ID" "Type" "Serial Number" "Status")
  if [[ "$include_purchase_date" == "true" ]]; then
    headers+=("Purchase Date" "Warranty Date")
  else
    headers+=("Warranty Date")
  fi

  # Calculate maximum width for each column based on data
  local -a max_widths=()
  local col_count=${#headers[@]}

  # Initialize with header lengths
  for i in "${!headers[@]}"; do
    max_widths[i]=${#headers[i]}
  done

  # Check data for maximum widths
  for row in "${data_rows[@]}"; do
    IFS=':' read -r id type model serial status purchase warranty <<<"$row"

    # Convert dates for display
    local display_purchase display_warranty
    display_purchase=$(convert_date_format "$purchase" "YYYY-MM-DD" "MM-DD-YYYY")
    display_warranty=$(convert_date_format "$warranty" "YYYY-MM-DD" "MM-DD-YYYY")

    # Create data array in display order
    local -a row_data=("$model" "$id" "$type" "$serial" "$status")
    if [[ "$include_purchase_date" == "true" ]]; then
      row_data+=("$display_purchase" "$display_warranty")
    else
      row_data+=("$display_warranty")
    fi

    # Update maximum widths
    for i in "${!row_data[@]}"; do
      if [[ ${#row_data[i]} -gt ${max_widths[i]} ]]; then
        max_widths[i]=${#row_data[i]}
      fi
    done
  done

  # Calculate total width needed (including separators)
  local total_width=0
  for width in "${max_widths[@]}"; do
    total_width=$((total_width + width + 3)) # +3 for " | "
  done
  total_width=$((total_width - 3)) # Remove last separator

  # Adjust column widths if total exceeds terminal width
  if [[ $total_width -gt $term_width ]]; then
    # Apply responsive scaling using bash arithmetic
    local available_width=$((term_width - (col_count - 1) * 3)) # Account for separators

    # Simple proportional scaling without bc
    for i in "${!max_widths[@]}"; do
      local scaled_width=$((max_widths[i] * available_width / total_width))

      # Set minimum widths based on column type
      case $i in
      0) max_widths[i]=$((scaled_width < 12 ? 12 : scaled_width)) ;; # Model
      1) max_widths[i]=$((scaled_width < 8 ? 8 : scaled_width)) ;;   # Equipment ID
      2) max_widths[i]=$((scaled_width < 8 ? 8 : scaled_width)) ;;   # Type
      3) max_widths[i]=$((scaled_width < 10 ? 10 : scaled_width)) ;; # Serial Number
      4) max_widths[i]=$((scaled_width < 8 ? 8 : scaled_width)) ;;   # Status
      *) max_widths[i]=$((scaled_width < 10 ? 10 : scaled_width)) ;; # Dates
      esac
    done
  fi

  # Generate format string and separator
  local format_str=""
  local separator_line=""
  for i in "${!max_widths[@]}"; do
    format_str+="%-${max_widths[i]}s"
    # Create separator with proper width (minimum 1 character)
    local width=${max_widths[i]}
    [[ $width -lt 1 ]] && width=1
    separator_line+="$(printf '%*s' "$width" '' | tr ' ' '-')"
    if [[ $i -lt $((col_count - 1)) ]]; then
      format_str+=" | "
      separator_line+=" | "
    fi
  done
  format_str+="\n"

  # Print table header (centered)
  header_line=$(printf "$format_str" "${headers[@]}")
  center_table_line "${header_line%$'\n'}"
  center_table_line "$separator_line"

  # Print data rows
  for row in "${data_rows[@]}"; do
    IFS=':' read -r id type model serial status purchase warranty <<<"$row"

    # Convert dates for display
    local display_purchase display_warranty
    display_purchase=$(convert_date_format "$purchase" "YYYY-MM-DD" "MM-DD-YYYY")
    display_warranty=$(convert_date_format "$warranty" "YYYY-MM-DD" "MM-DD-YYYY")

    # Truncate fields if they exceed column width
    model=${model:0:${max_widths[0]}}
    id=${id:0:${max_widths[1]}}
    type=${type:0:${max_widths[2]}}
    serial=${serial:0:${max_widths[3]}}
    status=${status:0:${max_widths[4]}}

    # Create data array in display order
    local -a row_data=("$model" "$id" "$type" "$serial" "$status")
    if [[ "$include_purchase_date" == "true" ]]; then
      display_purchase=${display_purchase:0:${max_widths[5]}}
      display_warranty=${display_warranty:0:${max_widths[6]}}
      row_data+=("$display_purchase" "$display_warranty")
    else
      display_warranty=${display_warranty:0:${max_widths[5]}}
      row_data+=("$display_warranty")
    fi

    # Print data row (centered)
    data_line=$(printf "$format_str" "${row_data[@]}")
    center_table_line "${data_line%$'\n'}"
  done
}

# Character-themed table formatting function
format_character_table() {
  local character_theme="$1"
  shift
  local -a data_rows=("$@")
  local include_purchase_date=${INCLUDE_PURCHASE_DATE:-false}

  # Set color scheme based on character
  local header_color category_color highlight_color data_color
  case "$character_theme" in
  "senjou")
    header_color="$SENJOU_HEADER"
    category_color="$SENJOU_CATEGORY"
    highlight_color="$SENJOU_HIGHLIGHT"
    data_color="$SENJOU_DATA"
    ;;
  "mayoi")
    header_color="$MAYOI_HEADER"
    category_color="$MAYOI_CATEGORY"
    highlight_color="$MAYOI_HIGHLIGHT"
    data_color="$MAYOI_DATA"
    ;;
  "shinobu")
    header_color="$SHINOBU_HEADER"
    category_color="$SHINOBU_CATEGORY"
    highlight_color="$SHINOBU_HIGHLIGHT"
    data_color="$SHINOBU_DATA"
    ;;
  *)
    # Default to regular colors if unknown theme
    header_color="$ORANGE_BG"
    category_color="$CYAN_HIGHLIGHT"
    highlight_color="$SOFT_YELLOW"
    data_color="$LIGHT_GRAY"
    ;;
  esac

  # Get terminal width, default to 120 if not available
  local term_width
  term_width=$(tput cols 2>/dev/null || echo "120")

  # Define column headers
  local headers=("Model" "Equipment ID" "Type" "Serial Number" "Status")
  if [[ "$include_purchase_date" == "true" ]]; then
    headers+=("Purchase Date" "Warranty Date")
  else
    headers+=("Warranty Date")
  fi

  # Calculate maximum width for each column based on data
  local -a max_widths=()
  local col_count=${#headers[@]}

  # Initialize with header lengths
  for i in "${!headers[@]}"; do
    max_widths[i]=${#headers[i]}
  done

  # Check data for maximum widths
  for row in "${data_rows[@]}"; do
    IFS=':' read -r id type model serial status purchase warranty <<<"$row"

    # Convert dates for display
    local display_purchase display_warranty
    display_purchase=$(convert_date_format "$purchase" "YYYY-MM-DD" "MM-DD-YYYY")
    display_warranty=$(convert_date_format "$warranty" "YYYY-MM-DD" "MM-DD-YYYY")

    # Create data array in display order
    local -a row_data=("$model" "$id" "$type" "$serial" "$status")
    if [[ "$include_purchase_date" == "true" ]]; then
      row_data+=("$display_purchase" "$display_warranty")
    else
      row_data+=("$display_warranty")
    fi

    # Update maximum widths
    for i in "${!row_data[@]}"; do
      if [[ ${#row_data[i]} -gt ${max_widths[i]} ]]; then
        max_widths[i]=${#row_data[i]}
      fi
    done
  done

  # Calculate total width needed (including separators)
  local total_width=0
  for width in "${max_widths[@]}"; do
    total_width=$((total_width + width + 3)) # +3 for " | "
  done
  total_width=$((total_width - 3)) # Remove last separator

  # Adjust column widths if total exceeds terminal width
  if [[ $total_width -gt $term_width ]]; then
    local available_width=$((term_width - (col_count - 1) * 3)) # Account for separators

    for i in "${!max_widths[@]}"; do
      local scaled_width=$((max_widths[i] * available_width / total_width))

      # Set minimum widths based on column type
      case $i in
      0) max_widths[i]=$((scaled_width < 12 ? 12 : scaled_width)) ;; # Model
      1) max_widths[i]=$((scaled_width < 8 ? 8 : scaled_width)) ;;   # Equipment ID
      2) max_widths[i]=$((scaled_width < 8 ? 8 : scaled_width)) ;;   # Type
      3) max_widths[i]=$((scaled_width < 10 ? 10 : scaled_width)) ;; # Serial Number
      4) max_widths[i]=$((scaled_width < 8 ? 8 : scaled_width)) ;;   # Status
      *) max_widths[i]=$((scaled_width < 10 ? 10 : scaled_width)) ;; # Dates
      esac
    done
  fi

  # Generate colored separator
  local separator_line=""
  for i in "${!max_widths[@]}"; do
    local width=${max_widths[i]}
    [[ $width -lt 1 ]] && width=1
    separator_line+="$(printf '%*s' "$width" '' | tr ' ' '-')"
    if [[ $i -lt $((col_count - 1)) ]]; then
      separator_line+=" | "
    fi
  done

  # Print colored table header (centered)
  header_line=""
  for i in "${!headers[@]}"; do
    header_line+="$(printf "%-${max_widths[i]}s" "${headers[i]}")"
    if [[ $i -lt $((col_count - 1)) ]]; then
      header_line+=" | "
    fi
  done

  # Center and print colored header
  term_width=$(tput cols 2>/dev/null || echo 120)
  header_length=${#header_line}
  header_padding=$(((term_width - header_length) / 2))
  [[ $header_padding -lt 0 ]] && header_padding=0

  printf "%*s${category_color}${BOLD}%s${RESET}\n" "$header_padding" "" "$header_line"

  # Center and print colored separator
  separator_length=${#separator_line}
  separator_padding=$(((term_width - separator_length) / 2))
  [[ $separator_padding -lt 0 ]] && separator_padding=0

  printf "%*s${highlight_color}%s${RESET}\n" "$separator_padding" "" "$separator_line"

  # Print data rows with character colors
  for row in "${data_rows[@]}"; do
    IFS=':' read -r id type model serial status purchase warranty <<<"$row"

    # Convert dates for display
    local display_purchase display_warranty
    display_purchase=$(convert_date_format "$purchase" "YYYY-MM-DD" "MM-DD-YYYY")
    display_warranty=$(convert_date_format "$warranty" "YYYY-MM-DD" "MM-DD-YYYY")

    # Truncate fields if they exceed column width
    model=${model:0:${max_widths[0]}}
    id=${id:0:${max_widths[1]}}
    type=${type:0:${max_widths[2]}}
    serial=${serial:0:${max_widths[3]}}
    status=${status:0:${max_widths[4]}}

    # Create data array in display order
    local -a row_data=("$model" "$id" "$type" "$serial" "$status")
    if [[ "$include_purchase_date" == "true" ]]; then
      display_purchase=${display_purchase:0:${max_widths[5]}}
      display_warranty=${display_warranty:0:${max_widths[6]}}
      row_data+=("$display_purchase" "$display_warranty")
    else
      display_warranty=${display_warranty:0:${max_widths[5]}}
      row_data+=("$display_warranty")
    fi

    # Build complete row data for centering
    row_line=""
    for i in "${!row_data[@]}"; do
      row_line+="$(printf "%-${max_widths[i]}s" "${row_data[i]}")"
      if [[ $i -lt $((col_count - 1)) ]]; then
        row_line+=" | "
      fi
    done

    # Center and print the row with colors
    term_width=$(tput cols 2>/dev/null || echo 120)
    row_length=${#row_line}
    row_padding=$(((term_width - row_length) / 2))
    [[ $row_padding -lt 0 ]] && row_padding=0

    # Print with character-specific colors and highlighting
    printf "%*s${data_color}" "$row_padding" ""
    for i in "${!row_data[@]}"; do
      # Highlight the sort criteria column
      case "$character_theme" in
      "senjou") # Sort by Model - highlight model column
        if [[ $i -eq 0 ]]; then
          printf "${highlight_color}${BOLD}%-${max_widths[i]}s${RESET}${data_color}" "${row_data[i]}"
        else
          printf "%-${max_widths[i]}s" "${row_data[i]}"
        fi
        ;;
      "mayoi") # Sort by Status - highlight status column
        if [[ $i -eq 4 ]]; then
          printf "${highlight_color}${BOLD}%-${max_widths[i]}s${RESET}${data_color}" "${row_data[i]}"
        else
          printf "%-${max_widths[i]}s" "${row_data[i]}"
        fi
        ;;
      "shinobu") # Sort by Type - highlight type column
        if [[ $i -eq 2 ]]; then
          printf "${highlight_color}${BOLD}%-${max_widths[i]}s${RESET}${data_color}" "${row_data[i]}"
        else
          printf "%-${max_widths[i]}s" "${row_data[i]}"
        fi
        ;;
      *)
        printf "%-${max_widths[i]}s" "${row_data[i]}"
        ;;
      esac

      if [[ $i -lt $((col_count - 1)) ]]; then
        printf " | "
      fi
    done
    printf "${RESET}\n"
  done
}

#===============================================================================
# INPUT VALIDATION UTILITIES
#===============================================================================

#------------------------------------------------------------------------------
# Function: null_check
# Purpose: Validates that user input is not empty or null
# Parameters:
#   $1 - Input value to check
#   $2 - Field name for error message
#   $3 - Number of lines to clear on error (optional, defaults to 2)
# Returns: 0 if input is valid, 1 if empty
# Features:
# - Displays user-friendly error messages
# - Automatically clears error messages after display
# - Handles cursor positioning for clean UI
#------------------------------------------------------------------------------
null_check() {
  local input_value="$1"
  local field_name="$2"
  local error_lines="${3:-2}" # Default to 2 lines to clear

  if [[ -z "$input_value" ]]; then
    echo "$field_name cannot be empty."
    sleep 2
    tput cuu $error_lines
    tput ed
    return 1
  fi
  return 0
}

#===============================================================================
# EQUIPMENT ID MANAGEMENT
#===============================================================================

#------------------------------------------------------------------------------
# Function: generate_next_equipment_id
# Purpose: Automatically generates the next available Equipment ID
# Features:
# - Scans existing Equipment.txt for highest ID number
# - Handles missing or empty files gracefully
# - Maintains E#### format (e.g., E0001, E0002)
# - Supports up to E9999 equipment items
# - Properly handles leading zeros in ID format
# Algorithm:
# 1. Parse all existing Equipment IDs from Equipment.txt
# 2. Extract numeric portions and find maximum
# 3. Add 1 to maximum and format with leading zeros
# 4. Return formatted Equipment ID (E0001, E0002, etc.)
#------------------------------------------------------------------------------
generate_next_equipment_id() {
  local max_id=0
  local next_id

  # Check if Equipment.txt exists and has content
  if [[ -f Equipment.txt ]]; then
    # Find the highest Equipment ID number
    while IFS=':' read -r id rest; do
      # Skip header line
      if [[ "$id" == "ID" ]]; then
        continue
      fi
      # Extract numeric part from Equipment ID (e.g., E0001 -> 1)
      if [[ "$id" =~ ^E([0-9]{4})$ ]]; then
        local num=${BASH_REMATCH[1]}
        # Remove leading zeros for comparison
        num=$((10#$num))
        if ((num > max_id)); then
          max_id=$num
        fi
      fi
    done <Equipment.txt
  fi

  # Generate next ID
  next_id=$((max_id + 1))
  # Format with leading zeros (E0001, E0002, etc.)
  printf "E%04d" "$next_id"
}

#===============================================================================
# TASK 2: ADD EQUIPMENT FUNCTION IMPLEMENTATION
#===============================================================================

#------------------------------------------------------------------------------
# Function: add_equipment
# Purpose: Interactive equipment addition with comprehensive input validation
# Features:
# - Auto-generated Equipment IDs (user can press Enter for auto-generation)
# - Comprehensive input validation for all fields
# - Equipment type validation (keyboard/mouse/monitor/webcam/mousepad/laptop)
# - Serial number format validation (AB123456789)
# - Status validation (Available/Unavailable)
# - Date validation with logical checks
# - Warranty date must be at least 30 days after purchase date
# - Duplicate ID and serial number prevention
# - File creation and header management
# - Loop for adding multiple equipment items
# - Professional error handling with cursor management
#------------------------------------------------------------------------------
add_equipment() {
  clear
  choice="Y"
  confirmation() {
    printf "${CYAN_HIGHLIGHT}Add another new Equipment details? ${SOFT_YELLOW}(y)es${RESET} or ${SOFT_YELLOW}(q)uit${RESET}: "
    read -r choice
    choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
  }
  while true; do
    if [[ $choice == "Y" ]]; then
      clear
      echo ""
      print_title_bar "Add Equipment Details Form"
      echo ""
      echo ""

      # Input Equipment ID
      while true; do
        printf "${CYAN_HIGHLIGHT}Equipment ID${RESET} (format ${SOFT_YELLOW}E0001${RESET}) [Press Enter for auto-generation]: "
        read -r equipment_id

        # If user left it empty, auto-generate the next available ID
        if [[ -z "$equipment_id" ]]; then
          equipment_id=$(generate_next_equipment_id)
          echo "Auto-generated Equipment ID: ${CYAN_HIGHLIGHT}$equipment_id${RESET}"
          sleep 1
          break
        fi

        # Validate user-provided Equipment ID
        if [[ ! "$equipment_id" =~ ^[E][0-9]{4}$ ]]; then
          print_error "Invalid Equipment ID format. Please use the format: E0001"
          sleep 2
          tput cuu 3
          tput ed
        elif [[ -f Equipment.txt && -n $(grep "^$equipment_id:" Equipment.txt) ]]; then
          print_error "Equipment ID already exists. Please enter a unique ID."
          sleep 2
          tput cuu 2
          tput ed
        else
          break
        fi
      done

      while true; do
        printf "${CYAN_HIGHLIGHT}Type${RESET}: "
        read -r equipment_type
        if null_check "$equipment_type" "Equipment Type"; then
          if [[ ! "$equipment_type" == "keyboard" && ! "$equipment_type" == "mouse" && ! "$equipment_type" == "monitor" && ! "$equipment_type" == "webcam" && ! "$equipment_type" == "mousepad" && ! "$equipment_type" == "laptop" ]]; then
            print_error "Invalid equipment type. Please enter keyboard, mouse, monitor, webcam, mousepad, or laptop."
            sleep 2
            tput cuu 2
            tput ed
          else
            break
          fi
        fi
      done

      while true; do
        printf "${CYAN_HIGHLIGHT}Model${RESET}: "
        read -r equipment_model
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
          elif [[ -f Equipment.txt && -n $(grep ":$equipment_serial:" Equipment.txt) ]]; then
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
        difference_days=$(((warranty_date_seconds - purchase_date_seconds) / 86400))

        # Check if warranty date is at least 30 days after purchase date
        if ((difference_days < 30)); then
          echo "Warranty date must be at least 30 days after purchase date."
          sleep 2
          tput cuu 2
          tput ed
          continue
        fi
        break
      done

      # Convert dates to backend format
      purchase_backend=$(convert_date_format "$equipment_purchase_date" "MM-DD-YYYY" "YYYY-MM-DD")
      expiry_backend=$(convert_date_format "$equipment_expiry_date" "MM-DD-YYYY" "YYYY-MM-DD")

      if [ ! -f Equipment.txt ]; then
        touch Equipment.txt
        echo "ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate" >>Equipment.txt
        echo "$equipment_id:$equipment_type:$equipment_model:$equipment_serial:$equipment_status:$purchase_backend:$expiry_backend" >>Equipment.txt
      else
        if ! grep -q "ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate" Equipment.txt; then
          echo "ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate" >>Equipment.txt
        fi
        echo "$equipment_id:$equipment_type:$equipment_model:$equipment_serial:$equipment_status:$purchase_backend:$expiry_backend" >>Equipment.txt
      fi

      #Return or add new equipment
      printf '\n%s\n\n' "Press (q) to return to Equipment Maintenance Menu."
      confirmation
    elif [[ "$choice" == "Q" ]]; then
      print_success "Returning to Equipment Maintenance Menu...."
      sleep 2
      break
    else
      print_error "Invalid choice, please enter either y or q"
      sleep 2
      tput cuu 3
      tput ed
      printf '\n'
      confirmation
    fi
  done
}

#===============================================================================
# TASK 3: SEARCH EQUIPMENT FUNCTIONALITY
#===============================================================================

#------------------------------------------------------------------------------
# Function: search_equipment
# Purpose: Search for equipment by serial number and display detailed information
# Features:
# - Serial number format validation (AB123456789)
# - Equipment.txt existence check
# - Detailed equipment information display
# - Date format conversion for user-friendly display
# - Loop functionality for multiple searches
# - Professional error handling and user feedback
# Search Method: Uses grep to find equipment by serial number
# Display Format: Formatted equipment details with proper labels
#------------------------------------------------------------------------------
search_equipment() {
  search_another="Y"
  confirmation() {
    printf "${CYAN_HIGHLIGHT}Search another Equipment? ${SOFT_YELLOW}(y)es${RESET} or ${SOFT_YELLOW}(q)uit${RESET}: "
    read -r search_another
    search_another=$(echo "$search_another" | tr '[:lower:]' '[:upper:]')
  }

  clear
  echo ""
  print_title_bar "Search Equipment"
  echo ""
  echo ""

  while [[ "$search_another" == "Y" ]]; do

    if [ ! -f Equipment.txt ]; then
      print_error "No equipment registered yet, please register equipment first."
      echo "-------------------------------------------------------------------------"
      sleep 1
      break
    fi

    echo "Please enter the Serial Number of the equipment you want to search for."
    printf "${CYAN_HIGHLIGHT}Enter Serial Number${RESET}: "
    read -r EquipSerial
    echo "-------------------------------------------------------------------------"
    if null_check "$EquipSerial" "Equipment Serial"; then
      if [[ ! "$EquipSerial" =~ ^[A-Z]{2}[0-9]{9}$ ]]; then
        print_error "Invalid Serial Number format. Please use the format: AB123456789"
        sleep 2
        tput cuu 4
        tput ed
        continue
      elif ! grep -q ":$EquipSerial:" Equipment.txt; then
        echo "No equipment found with serial number: $EquipSerial"
        sleep 2
        tput cuu 2
        tput ed
        continue
      fi

      #Find the matching record and extract fields
      record=$(grep ":$EquipSerial:" Equipment.txt)
      #Get infor from information field separator
      IFS=':' read -r eq_id eq_type eq_model eq_serial eq_status eq_purchase_date eq_expiry_date <<<"$record"

      # Display dates in YYYY-MM-DD format as per PDF specification
      display_purchase="$eq_purchase_date"
      display_warranty="$eq_expiry_date"

      printf '\n'
      echo "Equipment ID: $eq_id"
      echo "Type: $eq_type"
      echo "Model: $eq_model"
      echo "Status (Available / Unavailable): $eq_status"
      echo "Purchase Date (YYYY-MM-DD): $display_purchase"
      echo "Warranty Date (YYYY-MM-DD): $display_warranty"
      printf '\n'
      echo "-------------------------------------------------------------------------"

      printf '\n\n%s\n\n' "Press (q) to return to Equipment Maintenance Menu."
      confirmation

      if [[ $search_another == "Q" ]]; then
        print_success "Returning to Equipment Maintenance Menu...."
        sleep 2
        break
      fi
    fi
  done
}

#===============================================================================
# TASK 4: UPDATE EQUIPMENT FUNCTIONALITY
#===============================================================================

#------------------------------------------------------------------------------
# Function: update_equipment
# Purpose: Update existing equipment details with comprehensive validation
# Features:
# - Equipment ID validation and existence checking
# - Current equipment details display before update
# - Field-by-field update with validation
# - Serial number uniqueness checking (prevents duplicates)
# - Equipment type validation
# - Status validation
# - Date validation with logical business rules
# - File update using sed for precise record replacement
# - Loop functionality for multiple updates
# - Professional error handling and user feedback
#------------------------------------------------------------------------------
update_equipment() {
  clear
  update_another="Y"
  confirmation() {
    printf "${CYAN_HIGHLIGHT}Update another Equipment? ${SOFT_YELLOW}(y)es${RESET} or ${SOFT_YELLOW}(q)uit${RESET}: "
    read -r update_another
    update_another=$(echo "$update_another" | tr '[:lower:]' '[:upper:]')
  }

  echo ""
  print_title_bar "Update Equipment Details"
  echo ""
  echo ""

  while [[ $update_another == "Y" ]]; do
    if [ ! -f Equipment.txt ]; then
      print_error "No equipment registered yet, please register equipment first."
      echo "-------------------------------------------------------------------------"
      sleep 1
      break
    fi

    read -rp "Enter Equipment ID: " EquipID
    echo "-------------------------------------------------------------------------"
    # Check if equipment exists
    if null_check "$EquipID" "Equipment ID"; then
      if [[ ! "$EquipID" =~ ^[E][0-9]{4}$ ]]; then
        echo "Invalid Equipment ID format. Please use the format: E0001"
        sleep 2
        tput cuu 3
        tput ed
        continue
      elif ! grep -q "^${EquipID}:" Equipment.txt; then
        echo "No equipment found with ID: $EquipID"
        sleep 2
        tput cuu 3
        tput ed
        continue
      fi

      # Find the matching record and extract fields
      record=$(grep "^${EquipID}:" Equipment.txt)
      # Get info from information field separator
      IFS=':' read -r eq_id eq_type eq_model eq_serial eq_status eq_purchase_date eq_expiry_date <<<"$record"

      # Display dates in YYYY-MM-DD format as per PDF specification
      display_purchase="$eq_purchase_date"
      display_warranty="$eq_expiry_date"

      printf '\nCurrent Equipment Details:\n'
      echo "Equipment ID: $eq_id"
      echo "Type: $eq_type"
      echo "Model: $eq_model"
      echo "Serial Number: $eq_serial"
      echo "Status (Available / Unavailable): $eq_status"
      echo "Purchase Date (YYYY-MM-DD): $display_purchase"
      echo "Warranty Date (YYYY-MM-DD): $display_warranty"
      printf '\n'

      # Prompt for new values
      while true; do
        read -rp "New Serial Number (leave empty to keep current): " new_serial
        if [[ -n $new_serial ]]; then
          if [[ ! "$new_serial" =~ ^[A-Z]{2}[0-9]{9}$ ]]; then
            echo "Invalid Serial Number format. Keeping current value."
            sleep 2
            tput cuu 1
            tput ed
            new_serial=""
          elif grep -q ":$new_serial:" Equipment.txt && ! grep -q "^${EquipID}:.*:$new_serial:" Equipment.txt; then
            echo "Duplicate Serial in another record. Ignoring."
            new_serial=""
          fi
        fi
        break
      done

      while true; do
        read -rp "New Type (leave empty to keep current): " new_type
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
        read -rp "New Model (leave empty to keep current): " new_model
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
        read -rp "New Status (Available/Unavailable, leave empty to keep current): " new_status
        if [[ -n $new_status ]]; then
          if [[ ! "$new_status" == "Available" && ! "$new_status" == "Unavailable" ]]; then
            echo "Invalid status. Keeping current value."
            sleep 2
            tput cuu 1
            tput ed
            new_status=""
          fi
        fi
        break
      done

      # Purchase Date with format validation
      while true; do
        read -rp "New Purchase Date (YYYY-MM-DD, leave empty to keep current): " new_purchase_date
        if [[ -z "$new_purchase_date" ]]; then
          break
        fi
        if validate_date "$new_purchase_date" "Invalid purchase date." "YYYY-MM-DD"; then
          break
        else
          echo "Please try again or leave empty to keep current date."
        fi
      done

      # Warranty Date with format validation
      while true; do
        read -rp "New Warranty Date (YYYY-MM-DD, leave empty to keep current): " new_expiry_date
        if [[ -z "$new_expiry_date" ]]; then
          break
        fi
        if ! validate_date "$new_expiry_date" "Invalid warranty date." "YYYY-MM-DD"; then
          echo "Please try again or leave empty to keep current date."
          continue
        fi

        # Check if warranty is at least 30 days after purchase
        purchase_check_date=${new_purchase_date:-$eq_purchase_date}
        purchase_iso="$purchase_check_date"
        warranty_iso="$new_expiry_date"

        if ! purchase_date_seconds=$(date -d "${purchase_iso}" +%s 2>/dev/null) ||
          ! warranty_date_seconds=$(date -d "${warranty_iso}" +%s 2>/dev/null); then
          echo "Error processing dates. Please try again."
          continue
        fi

        difference_days=$(((warranty_date_seconds - purchase_date_seconds) / 86400))
        if ((difference_days < 30)); then
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

      # Show updated details and confirm
      printf '\nUpdated Equipment Details:\n'
      echo "Equipment ID: $eq_id"
      echo "Type: $eq_type"
      echo "Model: $eq_model"
      echo "Serial Number: $eq_serial"
      echo "Status (Available / Unavailable): $eq_status"
      echo "Purchase Date (YYYY-MM-DD): $eq_purchase_date"
      echo "Warranty Date (YYYY-MM-DD): $eq_expiry_date"
      printf '\n'
      echo "-------------------------------------------------------------------------"

      read -rp "Are you sure you want to UPDATE the above Equipment Details? (y)es or (q)uit: " confirm_update
      confirm_update=$(echo "$confirm_update" | tr '[:lower:]' '[:upper:]')
      if [[ $confirm_update == "Y" ]]; then
        # Create updated record
        updated_record="$eq_id:$eq_type:$eq_model:$eq_serial:$eq_status:$eq_purchase_date:$eq_expiry_date"

        # Replace old record with updated record
        sed -i "s/^$EquipID:.*/$updated_record/" Equipment.txt

        print_success "Equipment updated successfully!"
      elif [[ $confirm_update == "Q" ]]; then
        print_success "Update cancelled."
      else
        print_error "Invalid choice, please enter either y or q"
        sleep 2
        continue
      fi
      confirmation

      if [[ $update_another == "Q" ]]; then
        print_success "Returning to Equipment Maintenance Menu...."
        sleep 2
        break
      fi
    fi
  done
}

#===============================================================================
# TASK 5: DELETE EQUIPMENT FUNCTIONALITY
#===============================================================================

#------------------------------------------------------------------------------
# Function: delete_equipment
# Purpose: Delete equipment records with confirmation and safety checks
# Features:
# - Equipment ID validation and existence checking
# - Complete equipment details display before deletion
# - Confirmation prompt to prevent accidental deletions
# - Equipment.txt existence checking
# - Safe record deletion using sed command
# - Loop functionality for multiple deletions
# - Professional error handling and user feedback
# Safety Features:
# - Shows complete equipment details before deletion
# - Requires explicit user confirmation (y/q)
# - Validates Equipment ID format before processing
#------------------------------------------------------------------------------
delete_equipment() {
  clear
  delete_another="Y"
  confirmation() {
    printf "${CYAN_HIGHLIGHT}Delete another Equipment? ${SOFT_YELLOW}(y)es${RESET} or ${SOFT_YELLOW}(q)uit${RESET}: "
    read -r delete_another
    delete_another=$(echo "$delete_another" | tr '[:lower:]' '[:upper:]')
  }

  echo ""
  print_title_bar "Delete Equipment Details"
  echo ""
  echo ""

  while [[ $delete_another == "Y" ]]; do
    if [[ ! -f Equipment.txt ]]; then
      print_error "Equipment file not found, unable to delete."
      echo "-------------------------------------------------------------------------"
      sleep 2
      break
    fi

    read -rp "Enter Equipment ID to delete: " EquipID
    echo "-------------------------------------------------------------------------"
    if ! [[ $EquipID =~ ^E[0-9]{4}$ ]]; then
      echo "Invalid Equipment ID format. Please use the format: E0001"
      sleep 2
      tput cuu 4
      tput ed
      continue
    elif ! grep -q "^$EquipID:" Equipment.txt; then
      echo "No equipment found with ID: $EquipID"
      sleep 2
      tput cuu 2
      tput ed
      continue
    fi

    #Find the matching record and extract fields
    record=$(grep "^$EquipID:" Equipment.txt)
    #Get infor from information field separator
    IFS=':' read -r eq_id eq_type eq_model eq_serial eq_status eq_purchase_date eq_expiry_date <<<"$record"

    # Display dates in YYYY-MM-DD format as per PDF specification
    display_purchase="$eq_purchase_date"
    display_warranty="$eq_expiry_date"

    printf '\n'
    echo "Equipment ID: $eq_id"
    echo "Type: $eq_type"
    echo "Model: $eq_model"
    echo "Serial Number: $eq_serial"
    echo "Status (Available / Unavailable): $eq_status"
    echo "Purchase Date (YYYY-MM-DD): $display_purchase"
    echo "Warranty Date (YYYY-MM-DD): $display_warranty"
    printf '\n'
    echo "-------------------------------------------------------------------------"

    read -rp "Are you sure you want to DELETE the above Equipment Details? (y)es or (q)uit: " confirm_delete
    confirm_delete=$(echo "$confirm_delete" | tr '[:lower:]' '[:upper:]')
    if [[ $confirm_delete == "Y" ]]; then
      sed -i "/^$EquipID:/d" Equipment.txt
      echo "Equipment ID $EquipID deleted."
      sleep 2
    elif [[ $confirm_delete == "Q" ]]; then
      echo "Deletion of Equipment ID $EquipID cancelled."
      sleep 2
    else
      echo "Invalid choice, please enter either y or q"
      sleep 2
      continue
    fi

    confirmation
    if [[ $delete_another == "Q" ]]; then
      echo "Returning to Equipment Maintenance Menu...."
      sleep 2
      break
    fi
  done
}

#===============================================================================
# TASK 6: EQUIPMENT SORTING AND REPORTING FUNCTIONALITY
#===============================================================================
# This section implements three different sorting methods for equipment data:
# 1. Sort by Model - Uses Senjougahara theme (purple/violet)
# 2. Sort by Status - Uses Mayoi theme (green/white)
# 3. Sort by Type - Uses Shinobu theme (golden/cream)
#
# Each function includes:
# - Equipment.txt existence validation before entering
# - User-friendly error handling with menu options
# - Professional table formatting with character themes
# - Export functionality to ASCII text files
# - Responsive terminal width handling

#------------------------------------------------------------------------------
# Function: sort_by_model
# Purpose: Sort and display equipment by model in alphabetical order
# Theme: Senjougahara Hitagi (purple/violet colors)
# Features:
# - Pre-validation of Equipment.txt existence
# - Interactive menu for missing file handling
# - Alphabetical sorting by model name (case-insensitive)
# - Professional table display with highlighting
# - Export to "Report_By_Model.txt" option
# - Senjougahara character theme colors
#------------------------------------------------------------------------------
sort_by_model() {
  # Check if Equipment.txt exists before entering the function
  if [[ ! -f Equipment.txt ]]; then
    echo ""
    print_error "Equipment file not found. No equipment has been registered yet."
    echo "Would you like to:"
    echo "1. Add equipment first"
    echo "2. Return to main menu"
    printf "Enter your choice (1 or 2): "
    read -r choice
    echo ""

    case $choice in
    1)
      add_equipment
      return
      ;;
    2 | *)
      echo "Returning to main menu..."
      sleep 1
      return
      ;;
    esac
  fi

  export_file() {
    out_file="Report_By_Model.txt"
    {
      # Use the formatting function for consistent export
      INCLUDE_PURCHASE_DATE=false format_equipment_table "${rows[@]}"
    } >"$out_file"
    echo "Exported to $out_file"
  }

  clear
  echo ""
  print_senjou_title_bar "Equipment Details Sorted By Model"
  echo ""
  echo ""

  # Get all rows (skip header if present), sort by Model (col 3)
  mapfile -t rows < <(
    awk -F: 'NR==1 && /^ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate$/ {next} {print}' Equipment.txt |
      sort -t: -k3,3 -f
  )

  if ((${#rows[@]} == 0)); then
    echo "No equipment found."
    return
  fi

  # Use Senjougahara's character theme for the table
  INCLUDE_PURCHASE_DATE=false format_character_table "senjou" "${rows[@]}"

  echo
  while true; do
    printf "${SENJOU_CATEGORY}Would you like to export the report as ASCII text file? ${SENJOU_HIGHLIGHT}(y)es${RESET} or ${SENJOU_HIGHLIGHT}(q)uit${RESET}: "
    read -r choice
    choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
    if [[ "$choice" == "Y" ]]; then
      export_file
      printf "${SENJOU_DATA}Press Enter to continue...${RESET}"
      read -r
      break
    elif [[ "$choice" == "Q" ]]; then
      print_success "Returning to Equipment Maintenance Menu...."
      sleep 2
      break
    else
      print_error "Invalid choice, please enter either y or q"
      sleep 2
      tput cuu 2 # Move cursor up 2 lines
      tput ed    # Clear from cursor to end of screen
    fi
  done
}

#------------------------------------------------------------------------------
# Function: sort_by_status
# Purpose: Sort and display equipment by status (Available/Unavailable)
# Theme: Hachikuji Mayoi (green/white colors)
# Features:
# - Pre-validation of Equipment.txt existence
# - Interactive menu for missing file handling
# - User input for status selection (Available/Unavailable)
# - Case-insensitive status matching
# - Sorting by model within status groups
# - Professional table display with status highlighting
# - Export to "Report_By_Status_[Status].txt" option
# - Mayoi character theme colors with purchase date inclusion
#------------------------------------------------------------------------------
sort_by_status() {
  # Check if Equipment.txt exists before entering the function
  if [[ ! -f Equipment.txt ]]; then
    echo ""
    print_error "Equipment file not found. No equipment has been registered yet."
    echo "Would you like to:"
    echo "1. Add equipment first"
    echo "2. Return to main menu"
    printf "Enter your choice (1 or 2): "
    read -r choice
    echo ""

    case $choice in
    1)
      add_equipment
      return
      ;;
    2 | *)
      echo "Returning to main menu..."
      sleep 1
      return
      ;;
    esac
  fi

  export_file() {
    out_file="Report_By_Status_${EqStatus// /_}.txt"
    {
      # Use the formatting function for consistent export with purchase date
      INCLUDE_PURCHASE_DATE=true format_equipment_table "${rows[@]}"
    } >"$out_file"
    echo "Exported to $out_file"
  }
  clear
  echo ""
  print_mayoi_title_bar "Equipment Details Sorted By Status"
  echo ""
  echo ""

  while true; do
    printf "${MAYOI_CATEGORY}Enter Equipment Status ${MAYOI_HIGHLIGHT}(Available/Unavailable)${RESET}: "
    read -r EqStatus
    EqStatus=${EqStatus^} # Convert to title case
    echo "-------------------------------------------------------------------------------"
    if null_check "$EqStatus" "Equipment Status"; then
      if [[ "$EqStatus" != "Unavailable" && "$EqStatus" != "Available" ]]; then
        echo "Invalid equipment status. Please enter Available or Unavailable."
        sleep 2
        tput cuu 3
        tput ed
        continue
      fi

      # Get matching rows (skip header if present), case-insensitive match on Status field (col 5), sort by Model (col 3)
      mapfile -t rows < <(
        awk -F: -v t="$EqStatus" 'BEGIN{IGNORECASE=1} NR==1 && /^ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate$/ {next} $5==t{print}' Equipment.txt |
          sort -t: -k3,3 -f
      )

      if ((${#rows[@]} == 0)); then
        print_error "No equipment found for status: $EqStatus"
        sleep 2
        tput cuu 3
        tput ed
        continue
      fi

      printf "\n${MAYOI_CATEGORY}%s: ${MAYOI_HIGHLIGHT}%s${RESET}\n\n" "Equipment Details Sorted By Status" "$EqStatus"

      # Use Hachikuji Mayoi's character theme for the table
      INCLUDE_PURCHASE_DATE=true format_character_table "mayoi" "${rows[@]}"

      echo
      while true; do
        printf "${MAYOI_CATEGORY}Would you like to export the report as ASCII text file? ${MAYOI_HIGHLIGHT}(y)es${RESET} or ${MAYOI_HIGHLIGHT}(q)uit${RESET}: "
        read -r choice
        choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
        if [[ "$choice" == "Y" ]]; then
          export_file
          printf "${MAYOI_DATA}Press Enter to continue...${RESET}"
          read -r
          break
        elif [[ "$choice" == "Q" ]]; then
          print_success "Returning to Equipment Maintenance Menu...."
          sleep 2
          break
        else
          print_error "Invalid choice, please enter either y or q"
          sleep 2
          tput cuu 2 # Move cursor up 2 lines
          tput ed    # Clear from cursor to end of screen
        fi
      done
      break
    fi
  done
}

#------------------------------------------------------------------------------
# Function: sort_by_type
# Purpose: Sort and display equipment by equipment type
# Theme: Shinobu Oshino (golden/cream colors)
# Features:
# - Pre-validation of Equipment.txt existence
# - Interactive menu for missing file handling
# - User input for type selection (keyboard/mouse/monitor/webcam/mousepad/laptop)
# - Case-insensitive type matching with lowercase conversion
# - Sorting by model within type groups
# - Professional table display with type highlighting
# - Export to "Report_By_Type_[Type].txt" option
# - Shinobu character theme colors with purchase date inclusion
# - Comprehensive equipment type validation
#------------------------------------------------------------------------------
sort_by_type() {
  # Check if Equipment.txt exists before entering the function
  if [[ ! -f Equipment.txt ]]; then
    echo ""
    print_error "Equipment file not found. No equipment has been registered yet."
    echo "Would you like to:"
    echo "1. Add equipment first"
    echo "2. Return to main menu"
    printf "Enter your choice (1 or 2): "
    read -r choice
    echo ""

    case $choice in
    1)
      add_equipment
      return
      ;;
    2 | *)
      echo "Returning to main menu..."
      sleep 1
      return
      ;;
    esac
  fi

  export_file() {
    out_file="Report_By_Type_${EquipType// /_}.txt"
    {
      # Use the formatting function for consistent export with purchase date
      INCLUDE_PURCHASE_DATE=true format_equipment_table "${rows[@]}"
    } >"$out_file"
    echo "Exported to $out_file"
  }
  clear
  echo ""
  print_shinobu_title_bar "Equipment Details Sorted By Type"
  echo ""
  echo ""

  while true; do
    printf "${SHINOBU_CATEGORY}Enter equipment Type ${SHINOBU_HIGHLIGHT}(keyboard/mouse/monitor/webcam/mousepad/laptop)${RESET}: "
    read -r EquipType
    EquipType=${EquipType,,} # Convert to lowercase
    echo "-------------------------------------------------------------------------------"
    if null_check "$EquipType" "Equipment Type"; then
      if [[ "$EquipType" != "keyboard" && "$EquipType" != "mouse" && "$EquipType" != "monitor" && "$EquipType" != "webcam" && "$EquipType" != "mousepad" && "$EquipType" != "laptop" ]]; then
        echo "Invalid equipment type. Please enter keyboard, mouse, monitor, webcam, mousepad, or laptop."
        sleep 2
        tput cuu 3
        tput ed
        continue
      fi

      # Get matching rows (skip header if present), case-insensitive match on Type field (col 2), sort by Model (col 3)
      mapfile -t rows < <(
        awk -F: -v t="$EquipType" 'BEGIN{IGNORECASE=1} NR==1 && /^ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate$/ {next} $2==t{print}' Equipment.txt |
          sort -t: -k3,3 -f
      )

      if ((${#rows[@]} == 0)); then
        print_error "No equipment found for type: $EquipType"
        sleep 2
        tput cuu 3
        tput ed
        continue
      fi

      printf "\n${SHINOBU_CATEGORY}%s: ${SHINOBU_HIGHLIGHT}%s${RESET}\n\n" "Equipment Details Sorted By Type" "$EquipType"

      # Use Shinobu Oshino's character theme for the table
      INCLUDE_PURCHASE_DATE=true format_character_table "shinobu" "${rows[@]}"

      echo
      while true; do
        printf "${SHINOBU_CATEGORY}Would you like to export the report as ASCII text file? ${SHINOBU_HIGHLIGHT}(y)es${RESET} or ${SHINOBU_HIGHLIGHT}(q)uit${RESET}: "
        read -r choice
        choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
        if [[ "$choice" == "Y" ]]; then
          export_file
          printf "${SHINOBU_DATA}Press Enter to continue...${RESET}"
          read -r
          break
        elif [[ "$choice" == "Q" ]]; then
          print_success "Returning to Equipment Maintenance Menu...."
          sleep 2
          break
        else
          print_error "Invalid choice, please enter either y or q"
          sleep 2
          tput cuu 2 # Move cursor up 2 lines
          tput ed    # Clear from cursor to end of screen
        fi
      done
      break
    fi
  done
}

#===============================================================================
# EXIT SCREEN AND MAIN APPLICATION CONTROL
#===============================================================================

#------------------------------------------------------------------------------
# Function: show_undertale_thanks
# Purpose: Display a beautiful exit screen inspired by Undertale game
# Features:
# - Full-screen black background effect
# - Centered text with heart symbols
# - Professional farewell message with creator credits
# - Terminal-responsive centering
# - Heart emoji styling in red color
# - Professional exit experience
# Theme: Undertale-inspired black background with white text and red hearts
#------------------------------------------------------------------------------
show_undertale_thanks() {
  # Set black background and white text
  local BLACK_BG="\033[40m"
  local WHITE_TEXT="\033[97m"
  local RED_HEART="\033[91m♥\033[0m"
  local RESET="\033[0m"

  # Clear screen and set black background
  clear
  printf "${BLACK_BG}"

  # Fill entire screen with black background
  local term_height=$(tput lines 2>/dev/null || echo "24")
  local term_width=$(tput cols 2>/dev/null || echo "80")

  for ((i = 0; i < term_height; i++)); do
    printf "%*s\n" "$term_width" ""
  done

  # Move cursor to center of screen
  local center_row=$((term_height / 2 - 4))
  tput cup $center_row 0

  # Display thank you message with red heart
  center_text "${WHITE_TEXT}${BOLD}Thank you for using Equipment Management System!${RESET}${BLACK_BG}"
  echo ""
  center_text "${RED_HEART} ${WHITE_TEXT}Created with ${RED_HEART} by Lye Wei Lun, Lim Yung Juin, Swetha ${RED_HEART}${RESET}${BLACK_BG}"
  echo ""
  center_text "${WHITE_TEXT}Your equipment data has been safely managed.${RESET}${BLACK_BG}"
  echo ""
  center_text "${WHITE_TEXT}Have a wonderful day! ${RED_HEART}${RESET}${BLACK_BG}"
  echo ""
  echo ""
  center_text "${WHITE_TEXT}${BOLD}* (Press any key to continue...)${RESET}${BLACK_BG}"

  # Wait for user input
  read -n 1 -s

  # Clear screen and reset colors
  clear
  printf "${RESET}"
}

#===============================================================================
# MAIN APPLICATION CONTROLLER
#===============================================================================

#------------------------------------------------------------------------------
# Function: main_menu
# Purpose: Main application controller and menu system
# Features:
# - Infinite loop for continuous menu operation
# - Input validation and sanitization
# - Case-insensitive input handling
# - Single character input requirement
# - Professional error handling for invalid options
# - Graceful exit with thank you screen
# - Clean screen management between operations
#
# Menu Options:
# A - Add Equipment (with auto-ID generation)
# S - Search Equipment (by serial number)
# U - Update Equipment (comprehensive field updates)
# D - Delete Equipment (with confirmation)
# M - Sort by Model (Senjougahara theme)
# T - Sort by Status (Mayoi theme)
# P - Sort by Type (Shinobu theme)
# Q - Quit (with Undertale-inspired exit screen)
#------------------------------------------------------------------------------
main_menu() {
  # Read function
  read_input() {
    clear
    show_menu
    read -r choice
    choice=${choice//[[:space:]]/}
  }

  # Main loop
  while true; do
    # Read user input and validate input
    read_input
    if [[ ${#choice} -ne 1 ]]; then
      echo "Invalid: enter exactly one letter."
      sleep 2
      continue
    fi

    # Normalize to uppercase first letter only
    choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
    case ${choice:0:1} in
    A) add_equipment ;;
    S) search_equipment ;;
    U) update_equipment ;;
    D) delete_equipment ;;
    M) sort_by_model ;;
    T) sort_by_status ;;
    P) sort_by_type ;;
    Q)
      print_success "Program will exit in 1 second..."
      sleep 1
      show_undertale_thanks
      break
      ;;
    *)
      print_error "Invalid option. Try again."
      sleep 2
      ;;
    esac
  done
}

#===============================================================================
# APPLICATION ENTRY POINT
#===============================================================================

# Start the main menu application
main_menu

# Clean exit
exit 0

#===============================================================================
# END OF TENNA EQUIPMENT MANAGEMENT SYSTEM
#===============================================================================
#
# Script Summary:
# - Total Functions: 20+
# - Lines of Code: 1900+
# - Features: Add, Search, Update, Delete, Sort equipment with validation
# - Themes: Multiple anime-inspired color schemes
# - File Format: CSV-based Equipment.txt storage
# - Validation: Comprehensive input validation for all fields
# - UI: Professional terminal interface with responsive design
# - Export: ASCII text file reporting capabilities
#
# Created by: Lye Wei Lun, Lim Yung Juin, Swetha
# Course: Operating Systems Group Assignment
# Institution: [University Name]
# Academic Year: 2025
#===============================================================================
