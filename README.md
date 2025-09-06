# 🔧 Equipment Management System - OS Group Assignment

## 📚 Overview

![tenna](https://github.com/user-attachments/assets/0c954388-d337-446a-9363-0058c4ea6174)

This project is a comprehensive **Equipment Management System** built using Bash shell scripting for Linux environments. The system provides a complete CRUD (Create, Read, Update, Delete) interface for managing equipment inventory with advanced features like data validation, date formatting, and multiple sorting options.

**Main Script:** `tenna.sh` - A menu-driven equipment management system

---

## ✨ Features

### 🔍 Core Functionality
- **Add Equipment** - Add new equipment with validation
- **Search Equipment** - Find equipment by various criteria  
- **Update Equipment** - Modify existing equipment records
- **Delete Equipment** - Remove equipment with confirmation
- **Sort & Export** - Sort by Model, Status, or Type with export options

### 🛡️ Data Validation
- **Equipment ID Format:** E0001-E9999 pattern validation
- **Serial Number Format:** AB123456789 pattern validation  
- **Date Validation:** MM-DD-YYYY input format with conversion to YYYY-MM-DD storage
- **Status Options:** Available, In Use, Under Maintenance, Retired
- **Type Categories:** Various equipment types (mouse, keyboard, monitor, etc.)

### 📅 Date Management
- **Input Format:** MM-DD-YYYY (user-friendly)
- **Display Format:** YYYY-MM-DD (standardized)
- **Automatic Conversion:** Between input and display formats
- **Date Validation:** Ensures valid dates and logical warranty periods

### 💾 Data Storage
- **File Format:** Colon-separated values in `Equipment.txt`
- **Structure:** `ID:Type:Model:Serial:Status:PurchaseDate:WarrantyDate`
- **Sample Data:** Pre-populated with 8 equipment records

---

## 🚀 Quick Start

### Prerequisites
- Linux environment with Bash shell
- Write permissions in the project directory

### Installation & Usage

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
M. Sort by Model
T. Sort by Status
P. Sort by Type
Q. Quit
========================
```

---

## 📋 Detailed Functionality

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

Results display in formatted table with YYYY-MM-DD dates.

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

### Sorting & Export (M/T/P)
- **Sort by Model (M):** Alphabetical order by equipment model
- **Sort by Status (T):** Groups by equipment status
- **Sort by Type (P):** Organizes by equipment type
- All sorts export to dedicated files with proper formatting

---

## 🗂️ File Structure

```
├── tenna.sh                 # Main equipment management script
├── Equipment.txt            # Equipment data storage file
├── README.md               # This documentation
├── .gitignore              # Git ignore rules
└── test files/             # Test scripts (locally only)
```

---

## 🔧 Technical Implementation

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
- `sort_by_model()` - Sorts and exports by model
- `sort_by_status()` - Sorts and exports by status  
- `sort_by_type()` - Sorts and exports by type

### User Interface
- Clear screen management with `clear` commands
- Formatted output using `printf` for table alignment
- Color-coded messages for better user experience
- Confirmation dialogs for destructive operations

---

## 📊 Sample Data

The system comes with pre-populated sample data including:
- 8 equipment records across different types
- Various status states (Available, In Use, Under Maintenance)
- Different models and manufacturers
- Realistic purchase and warranty dates

---

## 🧪 Testing

### Validation Testing
- Equipment ID format enforcement
- Serial Number pattern validation
- Date format and logic verification
- Status and type option validation

### Functionality Testing  
- CRUD operations verification
- Search functionality across all fields
- Sort operations and export validation
- Data persistence and file handling

### Edge Cases
- Invalid input handling
- Empty file scenarios
- Duplicate prevention
- Date boundary conditions

---

## 🔒 Data Integrity

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

---

## 🛠️ Development Notes

### Assignment Alignment
- Script fully aligned with PDF assignment requirements
- Proper date formatting (MM-DD-YYYY input, YYYY-MM-DD display)
- Menu text corrections and typo fixes
- Exit function properly mapped to 'Q' option
- Confirmation dialogs matching specifications

### Improvements Made
- Enhanced date formatting system
- Improved table alignment and readability
- Better error handling and user feedback
- Consistent validation across all operations
- Git ignore patterns for test files

---

## 📝 Assignment Completion

### Tasks Implemented
- ✅ **Task 1:** Basic file operations and menu system
- ✅ **Task 2:** Data validation and input handling  
- ✅ **Task 3:** Search and retrieval functionality
- ✅ **Task 4:** Update and modification operations
- ✅ **Task 5:** Delete operations with safety checks
- ✅ **Task 6:** Sorting and export functionality

### PDF Requirements Met
- ✅ Equipment ID format (E0001-E9999)
- ✅ Date handling (MM-DD-YYYY input, YYYY-MM-DD display)
- ✅ Menu structure and navigation
- ✅ Confirmation dialogs
- ✅ Data validation requirements
- ✅ File-based storage system

---

## 🚦 Future Enhancements

### Potential Improvements
- **Database Integration:** PostgreSQL or MySQL backend
- **Web Interface:** HTML/CSS frontend with CGI
- **Advanced Search:** Regular expression support
- **Reporting:** Statistical analysis and charts
- **Multi-user Support:** User authentication and permissions
- **Backup Automation:** Scheduled data backups

### Performance Optimizations
- **Indexed Search:** Faster lookups for large datasets
- **Caching:** Frequently accessed data caching
- **Pagination:** Large dataset handling
- **Concurrent Access:** File locking mechanisms

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
- **Tools Used:** Bash, Git, VS Code, Linux utilities
- **Testing:** Comprehensive validation and edge case testing

---

*Last Updated: September 6, 2025*

