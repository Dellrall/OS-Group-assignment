# 🛠️ Tenna - Equipment Management System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Language-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![OS](https://img.shields.io/badge/OS-Linux-blue.svg)](https://www.linux.org/)

A comprehensive equipment management system built in Bash for Linux environments. Features robust data validation, ASCII table formatting, character-themed sorting, Undertale-inspired UI elements, and professional VHS demos.

![Tenna Demo](demo/tenna.gif)

---

## 🌟 Latest Features

- **🎭 Character Themes:** Monogatari-inspired sorting with Senjougahara (purple), Mayoi (green), and Shinobu (golden) themes
- **💖 Undertale Thank You Screen:** Beautiful exit screen with black background and red hearts
- **📹 Professional VHS Demos:** Complete demo suite with individual task recordings
- **🎨 ASCII Table Formatting:** Clean borders and perfect alignment for maximum compatibility
- **🔄 Enhanced CRUD Operations:** Improved user experience with better validation
- **📊 Smart Data Management:** Intelligent date handling and format conversion

---

## 🚀 Core Functionality

### Equipment Data Structure
Each equipment record contains:
- **Equipment ID:** Unique identifier (E0001-E9999 format)
- **Equipment Type:** Predefined categories (Computer, Monitor, etc.)
- **Model:** Equipment model/name
- **Serial Number:** Unique serial (AB123456789 format)
- **Status:** Current status (Available, In Use, Under Maintenance, Retired)
- **Purchase Date:** Date of acquisition (MM-DD-YYYY format)
- **Warranty Date:** Warranty expiration (MM-DD-YYYY format)

### Character-Themed Sorting
- **🟣 Senjougahara Theme (Model Sort):** Purple-themed sorting by equipment model
- **🟢 Mayoi Theme (Type Sort):** Green-themed sorting by equipment type  
- **🟡 Shinobu Theme (Status Sort):** Golden-themed sorting by equipment status

### Professional Demos
- **📹 VHS Recording Suite:** Complete set of terminal recordings for all tasks
- **🎬 Individual Task Demos:** Separate recordings for each operation
- **📚 Complete System Demo:** Full workflow demonstration
- **🎥 Multiple Formats:** MP4 and GIF outputs for different use cases

---

## 🏃 Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Dellrall/OS-Group-assignment.git
   cd OS-Group-assignment
   ```

2. **Make the script executable:**
   ```bash
   chmod +x tenna.sh
   ```

3. **Run the equipment management system:**
   ```bash
   ./tenna.sh
   ```

### Menu Options

```
========================
  Equipment Management
========================
A. Add Equipment
S. Search Equipment  
U. Update Equipment
D. Delete Equipment
M. Sort by Model (Senjougahara)
T. Sort by Type (Mayoi)
P. Sort by Status (Shinobu)
Q. Quit
========================
```

---

## 📹 VHS Demos

Check out our professional terminal recordings demonstrating all features:

- **🎬 Complete Demo:** [demo/complete_demo/](demo/complete_demo/) - Full system walkthrough
- **📋 Main Menu:** [demo/task1_main_menu/](demo/task1_main_menu/) - Interface navigation
- **➕ Add Equipment:** [demo/task2_add_equipment/](demo/task2_add_equipment/) - Adding new equipment
- **🔍 Search Equipment:** [demo/task3_search_equipment/](demo/task3_search_equipment/) - Search functionality
- **✏️ Update Equipment:** [demo/task4_update_equipment/](demo/task4_update_equipment/) - Updating records
- **🗑️ Delete Equipment:** [demo/task5_delete_equipment/](demo/task5_delete_equipment/) - Deleting equipment
- **📊 Sort Equipment:** [demo/task6_sort_equipment/](demo/task6_sort_equipment/) - Character-themed sorting

### Generate Demo Videos
```bash
cd demo
./generate_all_demos.sh
```

---

<details>
<summary>📋 Detailed Functionality</summary>

### Adding Equipment (A)
- **Equipment ID:** Must follow E0001-E9999 format
- **Type Selection:** Choose from predefined categories
- **Model Input:** Free text for equipment model
- **Serial Number:** Must follow AB123456789 format
- **Status Selection:** Available, In Use, Under Maintenance, Retired
- **Purchase Date:** MM-DD-YYYY format with validation
- **Warranty Date:** MM-DD-YYYY format with validation

### Searching Equipment (S)
Search by any of the following criteria:
- Equipment ID
- Equipment Type
- Model Name
- Serial Number
- Status
- Purchase Date
- Warranty Date

Results display in formatted ASCII table with YYYY-MM-DD dates.

### Updating Equipment (U)
- Search for equipment by Serial Number
- Modify any field except Equipment ID
- Maintains data validation for all updates
- Confirmation dialog before saving changes

### Deleting Equipment (D)
- Search for equipment by Serial Number
- Display current record for verification
- Confirmation dialog before permanent deletion
- Safe removal from data file

### Character-Themed Sorting (M/T/P)
- **Senjougahara (Purple) - Sort by Model (M):** Alphabetical order by equipment model
- **Mayoi (Green) - Sort by Type (T):** Groups by equipment type
- **Shinobu (Golden) - Sort by Status (P):** Organizes by equipment status
- All sorts export to dedicated files with proper formatting and character themes

</details>

---

<details>
<summary>🗂️ File Structure</summary>

```
├── tenna.sh                 # Main equipment management script
├── Equipment.txt            # Equipment data storage file
├── README.md               # This documentation
├── LICENSE                 # MIT License
├── demo/                   # VHS demo recordings
│   ├── generate_all_demos.sh
│   ├── complete_demo/
│   ├── task1_main_menu/
│   ├── task2_add_equipment/
│   ├── task3_search_equipment/
│   ├── task4_update_equipment/
│   ├── task5_delete_equipment/
│   └── task6_sort_equipment/
└── test files/             # Test scripts (locally only)
```

</details>

---

<details>
<summary>🔧 Technical Implementation</summary>

### Data Validation Functions
- `validate_equipment_id()` - Validates Equipment ID format
- `validate_serial_number()` - Validates Serial Number format  
- `validate_date()` - Validates date format and logic
- `convert_date_format()` - Converts between date formats

### Core Functions
- `add_equipment()` - Handles equipment addition
- `search_equipment()` - Implements search functionality
- `update_equipment()` - Manages equipment updates
- `delete_equipment()` - Processes equipment deletion
- `sort_by_model()` - Senjougahara-themed model sorting
- `sort_by_status()` - Shinobu-themed status sorting  
- `sort_by_type()` - Mayoi-themed type sorting
- `format_equipment_table()` - ASCII table formatting
- `show_undertale_thanks()` - Undertale-style exit screen

### Character Theme System
- **Purple Theme (Senjougahara):** Used for model sorting with elegant purple borders
- **Green Theme (Mayoi):** Used for type sorting with vibrant green styling
- **Golden Theme (Shinobu):** Used for status sorting with golden accents

### User Interface
- ASCII table formatting for maximum compatibility
- Character-themed color schemes for different operations
- Undertale-inspired thank you screen with black background and red hearts
- Clear screen management and formatted output
- Confirmation dialogs for destructive operations

</details>

---

<details>
<summary>📊 Sample Data</summary>

The system comes with pre-populated sample data including:
- 8 equipment records across different types
- Various status states (Available, In Use, Under Maintenance)
- Different models and manufacturers
- Realistic purchase and warranty dates

Sample equipment types:
- Computer systems and laptops
- Monitors and displays  
- Keyboards and mice
- Network equipment
- Audio/visual equipment

</details>

---

<details>
<summary>🧪 Testing</summary>

### Validation Testing
- Equipment ID format enforcement
- Serial Number pattern validation
- Date format and logic verification
- Status and type option validation

### Functionality Testing  
- CRUD operations verification
- Search functionality across all fields
- Character-themed sort operations and export validation
- ASCII table formatting verification
- Data persistence and file handling

### Edge Cases
- Invalid input handling
- Empty file scenarios
- Duplicate prevention
- Date boundary conditions
- Unicode vs ASCII character compatibility

### Test Files Available
- `comprehensive_test.sh` - Complete system testing
- `test_ascii_table.sh` - Table formatting tests
- `test_undertale_thanks.sh` - Exit screen testing
- Various format and function tests

</details>

---

<details>
<summary>🔒 Data Integrity</summary>

### Backup & Recovery
- Data stored in human-readable format
- Easy backup with standard file operations
- No database dependencies
- Portable across Linux systems

### Validation Layers
- Input validation at entry point
- Format validation before storage
- Data consistency checks
- Error handling for file operations
- ASCII character compatibility for maximum portability

</details>

---

<details>
<summary>🛠️ Development Notes</summary>

### Assignment Alignment
- Script fully aligned with PDF assignment requirements
- Proper date formatting (MM-DD-YYYY input, YYYY-MM-DD display)
- Menu text corrections and typo fixes
- Exit function properly mapped to 'Q' option
- Confirmation dialogs matching specifications

### Improvements Made
- Character-themed sorting system with Monogatari inspiration
- Undertale-style thank you screen for personal touch
- Professional VHS demo suite for presentations
- Enhanced ASCII table formatting for compatibility
- Better error handling and user feedback
- Consistent validation across all operations

### Character Theme Integration
- Senjougahara (purple) for model sorting - elegant and organized
- Mayoi (green) for type sorting - vibrant and energetic
- Shinobu (golden) for status sorting - powerful and refined

</details>

---

## 📝 Assignment Completion

### Tasks Implemented
- ✅ **Task 1:** Basic file operations and menu system with character themes
- ✅ **Task 2:** Data validation and input handling with enhanced UX
- ✅ **Task 3:** Search and retrieval functionality with ASCII tables
- ✅ **Task 4:** Update and modification operations with validation
- ✅ **Task 5:** Delete operations with safety checks and confirmation
- ✅ **Task 6:** Character-themed sorting and export functionality

### Enhanced Features
- ✅ **Undertale Thank You Screen:** Black background with red hearts
- ✅ **Character Themes:** Monogatari-inspired sorting themes
- ✅ **VHS Demo Suite:** Professional terminal recordings
- ✅ **ASCII Table Formatting:** Maximum compatibility formatting
- ✅ **Enhanced UI/UX:** Improved user experience throughout

---

<details>
<summary>🚦 Future Enhancements</summary>

### Potential Improvements
- **Database Integration:** PostgreSQL or MySQL backend
- **Web Interface:** HTML/CSS frontend with CGI
- **Advanced Search:** Regular expression support
- **Reporting:** Statistical analysis and charts
- **Multi-user Support:** User authentication and permissions
- **More Character Themes:** Additional Monogatari character themes

### Performance Optimizations
- **Indexed Search:** Faster lookups for large datasets
- **Caching:** Frequently accessed data caching
- **Pagination:** Large dataset handling
- **Concurrent Access:** File locking mechanisms

</details>

---

## 📞 Support & Contact

For questions, issues, or contributions:
- **Repository:** [OS-Group-assignment](https://github.com/Dellrall/OS-Group-assignment)
- **Branch:** main
- **Issues:** Use GitHub Issues for bug reports
- **Pull Requests:** Welcome for improvements

---

## 📄 License

This project is part of an academic assignment. See LICENSE file for details.

---

## 🙏 Acknowledgments

- **Course:** Operating Systems
- **Assignment:** Bash Shell Scripting Project
- **Character Themes:** Inspired by Monogatari series
- **Exit Screen:** Inspired by Undertale
- **Tools Used:** Bash, Git, VS Code, VHS, Linux utilities
- **Testing:** Comprehensive validation and edge case testing

---

*Last Updated: December 2024 - Now with Character Themes and Professional Demos!*
