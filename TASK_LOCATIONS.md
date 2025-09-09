# 📍 Task Location Guide - tenna.sh

This document provides a comprehensive guide to the location of each task and function within the `tenna.sh` file (1558 lines total).

---

## 📚 Table of Contents

- [🎨 UI & Utility Functions](#-ui--utility-functions-lines-1-185)
  - [Color Definitions](#color-definitions--variables-lines-1-36)
  - [Title Bar Functions](#title-bar-functions-lines-37-102)
  - [Print Utilities](#print-utilities-lines-103-153)
  - [Menu Display](#menu-display-lines-154-185)
- [🔧 Data Validation Functions](#-data-validation-functions-lines-186-286)
  - [Date Validation](#date-validation-lines-186-263)
  - [Date Conversion](#date-conversion-lines-264-286)
- [📊 Table Formatting Functions](#-table-formatting-functions-lines-287-661)
  - [Table Utilities](#table-utilities-lines-287-303)
  - [Equipment Table Formatting](#equipment-table-formatting-lines-304-436)
  - [Character-Themed Table Formatting](#character-themed-table-formatting-lines-437-661)
- [✅ Task 1: System Initialization](#-task-1-system-initialization-lines-662-678)
- [➕ Task 2: Add Equipment](#-task-2-add-equipment-lines-679-864)
- [🔍 Task 3: Search Equipment](#-task-3-search-equipment-lines-865-941)
- [✏️ Task 4: Update Equipment](#️-task-4-update-equipment-lines-942-1155)
- [🗑️ Task 5: Delete Equipment](#️-task-5-delete-equipment-lines-1156-1244)
- [📈 Task 6: Sorting Functions](#-task-6-sorting-functions-lines-1245-1466)
  - [Senjougahara Theme - Sort by Model](#senjougahara-theme---sort-by-model-lines-1245-1305)
  - [Shinobu Theme - Sort by Status](#shinobu-theme---sort-by-status-lines-1306-1386)
  - [Mayoi Theme - Sort by Type](#mayoi-theme---sort-by-type-lines-1387-1466)
- [💖 Undertale Features](#-undertale-features-lines-1467-1522)
- [🎮 Main Program Loop](#-main-program-loop-lines-1523-1558)

---

## 🎨 UI & Utility Functions (Lines 1-185)

### Color Definitions & Variables (Lines 1-36)
```bash
Lines 1-36: Color variables and system constants
```
- ANSI color codes for themes
- System configuration variables
- Terminal formatting constants

### Title Bar Functions (Lines 37-102)
```bash
print_title_bar()           # Lines 37-57
print_senjou_title_bar()    # Lines 58-72
print_mayoi_title_bar()     # Lines 73-87
print_shinobu_title_bar()   # Lines 88-102
```
- **`print_title_bar()`**: Standard title bar display
- **`print_senjou_title_bar()`**: Purple-themed title (Senjougahara)
- **`print_mayoi_title_bar()`**: Green-themed title (Mayoi)
- **`print_shinobu_title_bar()`**: Golden-themed title (Shinobu)

### Print Utilities (Lines 103-153)
```bash
print_colored()    # Lines 103-108
print_success()    # Lines 109-113
print_error()      # Lines 114-118
center_text()      # Lines 119-153
```
- **`print_colored()`**: Colored text output utility
- **`print_success()`**: Success message formatting
- **`print_error()`**: Error message formatting
- **`center_text()`**: Text centering for UI alignment

### Menu Display (Lines 154-185)
```bash
show_menu()    # Lines 154-185
```
- **`show_menu()`**: Main menu interface display

---

## 🔧 Data Validation Functions (Lines 186-286)

### Date Validation (Lines 186-263)
```bash
validate_date()    # Lines 186-263
```
- **`validate_date()`**: Comprehensive date format validation
- Supports MM-DD-YYYY input format
- Validates leap years and month boundaries
- Handles date logic verification

### Date Conversion (Lines 264-286)
```bash
convert_date_format()    # Lines 264-286
```
- **`convert_date_format()`**: Converts between date formats
- MM-DD-YYYY to YYYY-MM-DD conversion
- Used for display and storage formatting

---

## 📊 Table Formatting Functions (Lines 287-661)

### Table Utilities (Lines 287-303)
```bash
center_table_line()    # Lines 287-303
```
- **`center_table_line()`**: Centers table lines for display

### Equipment Table Formatting (Lines 304-436)
```bash
format_equipment_table()    # Lines 304-436
```
- **`format_equipment_table()`**: Standard equipment table formatting
- ASCII border characters for compatibility
- Proper column alignment and spacing
- Header and data row formatting

### Character-Themed Table Formatting (Lines 437-661)
```bash
format_character_table()    # Lines 437-661
```
- **`format_character_table()`**: Character-themed table display
- Supports Senjougahara, Mayoi, and Shinobu themes
- Color-coded borders and headers
- Dynamic theme switching based on operation

---

## ✅ Task 1: System Initialization (Lines 662-678)

```bash
null_check()    # Lines 662-678
```
- **`null_check()`**: System initialization and data validation
- Equipment.txt file existence check
- Basic system readiness verification
- Initial data structure validation

---

## ➕ Task 2: Add Equipment (Lines 679-864)

```bash
add_equipment()    # Lines 679-864
```
- **Complete Add Functionality**:
  - Equipment ID validation (E0001-E9999 format)
  - Equipment type selection from predefined list
  - Model name input with validation
  - Serial number validation (AB123456789 format)
  - Status selection (Available, In Use, Under Maintenance, Retired)
  - Purchase date input with MM-DD-YYYY format
  - Warranty date input with validation
  - Duplicate prevention checks
  - Data persistence to Equipment.txt

---

## 🔍 Task 3: Search Equipment (Lines 865-941)

```bash
search_equipment()    # Lines 865-941
```
- **Complete Search Functionality**:
  - Multi-criteria search options
  - Search by Equipment ID
  - Search by Equipment Type
  - Search by Model Name
  - Search by Serial Number
  - Search by Status
  - Search by Purchase Date
  - Search by Warranty Date
  - Results display in formatted ASCII table

---

## ✏️ Task 4: Update Equipment (Lines 942-1155)

```bash
update_equipment()    # Lines 942-1155
```
- **Complete Update Functionality**:
  - Equipment lookup by Serial Number
  - Display current equipment information
  - Field-by-field update options
  - Maintains all validation rules
  - Equipment ID protection (non-editable)
  - Confirmation dialogs before changes
  - Data validation for all modified fields
  - File update with new information

---

## 🗑️ Task 5: Delete Equipment (Lines 1156-1244)

```bash
delete_equipment()    # Lines 1156-1244
```
- **Complete Delete Functionality**:
  - Equipment search by Serial Number
  - Current record display for verification
  - Double confirmation dialog
  - Safe removal from Equipment.txt
  - Temporary file handling for safe deletion
  - Error handling for file operations

---

## 📈 Task 6: Sorting Functions (Lines 1245-1466)

### Senjougahara Theme - Sort by Model (Lines 1245-1305)
```bash
sort_by_model()    # Lines 1245-1305
```
- **Purple-themed sorting by equipment model**
- Alphabetical ordering
- Senjougahara character theme
- Export to `Equipment_sorted_by_model.txt`

### Shinobu Theme - Sort by Status (Lines 1306-1386)
```bash
sort_by_status()    # Lines 1306-1386
```
- **Golden-themed sorting by equipment status**
- Status-based grouping
- Shinobu character theme
- Export to `Equipment_sorted_by_status.txt`

### Mayoi Theme - Sort by Type (Lines 1387-1466)
```bash
sort_by_type()    # Lines 1387-1466
```
- **Green-themed sorting by equipment type**
- Type-based organization
- Mayoi character theme
- Export to `Equipment_sorted_by_type.txt`

---

## 💖 Undertale Features (Lines 1467-1522)

```bash
show_undertale_thanks()    # Lines 1467-1522
```
- **Undertale-inspired thank you screen**
- Black background terminal setup
- White text with red heart symbols
- Animated text display
- Graceful exit sequence
- Terminal reset functionality

---

## 🎮 Main Program Loop (Lines 1523-1558)

```bash
Main execution loop    # Lines 1523-1558
```
- **Program Flow Control**:
  - Main menu display loop
  - User input handling
  - Task dispatch to appropriate functions
  - Menu option validation
  - Exit handling with Undertale thank you screen
  - Continuous operation until quit

---

## 🔍 Quick Reference

| Task | Function | Line Range | Description |
|------|----------|------------|-------------|
| **Initialization** | `null_check()` | 662-678 | System setup and validation |
| **Add Equipment** | `add_equipment()` | 679-864 | Complete equipment addition |
| **Search Equipment** | `search_equipment()` | 865-941 | Multi-criteria search |
| **Update Equipment** | `update_equipment()` | 942-1155 | Equipment modification |
| **Delete Equipment** | `delete_equipment()` | 1156-1244 | Safe equipment removal |
| **Sort by Model** | `sort_by_model()` | 1245-1305 | Senjougahara theme sorting |
| **Sort by Status** | `sort_by_status()` | 1306-1386 | Shinobu theme sorting |
| **Sort by Type** | `sort_by_type()` | 1387-1466 | Mayoi theme sorting |
| **Thank You Screen** | `show_undertale_thanks()` | 1467-1522 | Undertale exit screen |
| **Main Loop** | Main execution | 1523-1558 | Program flow control |

---

## 📝 Navigation Tips

- **To view a specific function**: `sed -n 'START,ENDp' tenna.sh`
- **To edit a specific task**: Use line numbers as reference points
- **Character themes**: Each sorting function has its own themed styling
- **Validation functions**: Located in the early sections for reusability
- **UI functions**: Grouped at the beginning for consistent styling

---

*This guide helps developers quickly locate and understand the structure of the Equipment Management System.*
