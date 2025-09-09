# Equipment Management System - VHS Demo Collection

This folder contains comprehensive VHS tape configurations to showcase every feature and task of the Equipment Management System.

## 🎬 Demo Structure

```
demo/
├── task1_main_menu/           # Task 1: Main Menu Navigation
│   └── task1_main_menu.tape
├── task2_add_equipment/       # Task 2: Add Equipment Function
│   └── task2_add_equipment.tape
├── task3_search_equipment/    # Task 3: Search Equipment Function
│   └── task3_search_equipment.tape
├── task4_update_equipment/    # Task 4: Update Equipment Function
│   └── task4_update_equipment.tape
├── task5_delete_equipment/    # Task 5: Delete Equipment Function
│   └── task5_delete_equipment.tape
├── task6_sort_equipment/      # Task 6: Sort Equipment (Character Themes)
│   └── task6_sort_equipment.tape
├── complete_demo/             # Complete System Demonstration
│   └── tenna_complete_demo.tape
├── generate_all_demos.sh      # Generate all demos at once
├── test_single_demo.sh        # Test individual demos
└── README.md                  # This file
```

## 🎯 What Each Demo Showcases

### Task 1: Main Menu Navigation
- Beautiful Ononoki Yotsugi-themed interface
- Menu option highlighting and navigation
- Responsive design and centering

### Task 2: Add Equipment Function
- Input validation for all fields
- Equipment ID format validation (E0001)
- Serial number validation (AB123456789)
- Date validation and default values
- Equipment type validation
- Error handling demonstrations

### Task 3: Search Equipment Function
- Serial number search functionality
- Input validation and error handling
- Equipment details display
- Non-existent equipment handling

### Task 4: Update Equipment Function
- Equipment detail modification
- Selective field updates
- Data validation during updates
- Confirmation workflows

### Task 5: Delete Equipment Function
- Safe equipment deletion
- Confirmation prompts
- Error handling for invalid IDs
- Database integrity maintenance

### Task 6: Sort Equipment (Character Themes)
- **Senjougahara Theme** (Purple): Sort by Model
- **Mayoi Theme** (Green): Sort by Status
- **Shinobu Theme** (Golden): Sort by Type
- Export functionality
- Beautiful character-specific color schemes

### Complete Demo
- End-to-end workflow demonstration
- All major features in sequence
- Undertale-style thank you screen
- Professional presentation flow

## 🎥 How to Generate Demos

### Prerequisites
Install VHS (Video terminal recorder):
```bash
go install github.com/charmbracelet/vhs@latest
```

### Generate All Demos
```bash
./demo/generate_all_demos.sh
```

### Generate Single Demo
```bash
./demo/test_single_demo.sh task1_main_menu
./demo/test_single_demo.sh complete_demo
```

### Manual Generation
```bash
vhs < demo/task1_main_menu/task1_main_menu.tape
```

## 📊 Demo Features Highlighted

### Visual Elements
- **Color Themes**: Ononoki Yotsugi base theme with Monogatari character themes
- **Typography**: Clean, readable fonts with proper spacing
- **Animations**: Smooth transitions and user interactions
- **Responsive Design**: Adapts to different terminal sizes

### Technical Features
- **Input Validation**: Comprehensive error checking
- **Data Persistence**: Equipment.txt file management
- **Export Functions**: ASCII report generation
- **Error Handling**: User-friendly error messages
- **Navigation**: Intuitive menu system

### Character Themes
- **Senjougahara Hitagi**: Elegant purple theme for model sorting
- **Hachikuji Mayoi**: School spirit green theme for status sorting
- **Shinobu Oshino**: Golden elegance theme for type sorting

## 🎨 Demo Settings

All demos use consistent settings:
- **Resolution**: 1200x800
- **Theme**: Dracula
- **Font Size**: 16
- **Format**: Both MP4 and GIF outputs
- **Shell**: Bash

## 🚀 Usage Tips

1. **For Presentations**: Use the complete demo for overview, individual task demos for detailed explanations
2. **For Development**: Use single demo tests during feature development
3. **For Documentation**: Embed GIFs in README files and documentation
4. **For Training**: Step-by-step task demos for user training

## 📝 Customization

To customize demos:
1. Edit the `.tape` files in each folder
2. Adjust timing with `Sleep` commands
3. Modify visual settings (width, height, theme)
4. Add or remove interaction steps

## 🎁 Special Features

- **Undertale Thank You Screen**: Beautiful black background with red hearts
- **Character-Specific Themes**: Authentic Monogatari series color schemes
- **Professional Polish**: Smooth interactions and proper timing
- **Comprehensive Coverage**: Every single feature demonstrated

Created with ♥ by Lye Wei Lun, Lim Yung Juin, Swetha
