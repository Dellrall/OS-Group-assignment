#!/bin/bash

# VHS Demo Generator for Equipment Management System
# Run all demos and generate MP4/GIF files
# By Lye Wei Lun, Lim Yung Juin, Swetha

echo "🎬 Equipment Management System - VHS Demo Generator"
echo "=================================================="

# Check if vhs is installed
if ! command -v vhs &> /dev/null; then
    echo "❌ VHS not found! Please install it first:"
    echo "   go install github.com/charmbracelet/vhs@latest"
    exit 1
fi

echo "✅ VHS found! Starting demo generation..."
echo ""

# Array of demo configurations
demos=(
    "demo/task1_main_menu/task1_main_menu.tape"
    "demo/task2_add_equipment/task2_add_equipment.tape"
    "demo/task3_search_equipment/task3_search_equipment.tape"
    "demo/task4_update_equipment/task4_update_equipment.tape"
    "demo/task5_delete_equipment/task5_delete_equipment.tape"
    "demo/task6_sort_equipment/task6_sort_equipment.tape"
    "demo/complete_demo/tenna_complete_demo.tape"
)

# Demo descriptions
descriptions=(
    "Task 1: Main Menu Navigation"
    "Task 2: Add Equipment Function"
    "Task 3: Search Equipment Function"
    "Task 4: Update Equipment Function"
    "Task 5: Delete Equipment Function"
    "Task 6: Sort Equipment (Character Themes)"
    "Complete System Demonstration"
)

# Generate demos
total=${#demos[@]}
current=1

for i in "${!demos[@]}"; do
    demo_file="${demos[$i]}"
    description="${descriptions[$i]}"
    
    echo "📹 [$current/$total] Generating: $description"
    echo "   File: $demo_file"
    
    if [ -f "$demo_file" ]; then
        echo "   🎥 Running VHS..."
        vhs < "$demo_file"
        
        if [ $? -eq 0 ]; then
            echo "   ✅ Success!"
        else
            echo "   ❌ Error generating demo"
        fi
    else
        echo "   ❌ Tape file not found: $demo_file"
    fi
    
    echo ""
    ((current++))
done

echo "🎉 Demo generation complete!"
echo ""
echo "📁 Generated files:"
find demo -name "*.mp4" -o -name "*.gif" | sort

echo ""
echo "🎯 Demo Structure:"
echo "├── demo/"
echo "│   ├── task1_main_menu/       - Main menu navigation"
echo "│   ├── task2_add_equipment/   - Adding equipment with validation"
echo "│   ├── task3_search_equipment/ - Search by serial number"
echo "│   ├── task4_update_equipment/ - Update equipment details"
echo "│   ├── task5_delete_equipment/ - Safe equipment deletion"
echo "│   ├── task6_sort_equipment/  - Character-themed sorting"
echo "│   └── complete_demo/         - Full system demonstration"
echo ""
echo "🎨 Features showcased:"
echo "• Ononoki Yotsugi color theme (main UI)"
echo "• Monogatari character themes (Senjougahara, Mayoi, Shinobu)"
echo "• Input validation and error handling"
echo "• Responsive table formatting"
echo "• Undertale-style thank you screen"
echo "• Export functionality"
echo ""
echo "Ready for presentation! ✨"
