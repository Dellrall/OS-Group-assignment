# VHS Tape - Task 2: Add Equipment Demo
# Equipment Management System by Lye Wei Lun, Lim Yung Juin, Swetha

Output demo/task2_add_equipment/task2_add_equipment.gif
Output demo/task2_add_equipment/task2_add_equipment.mp4

Require echo

Set Shell "bash"
Set FontSize 16
Set Width 1200
Set Height 800
Set Theme "Dracula"

# Start the demo
Type "clear"
Enter
Sleep 1s

Type "# Task 2: Add Equipment Demo"
Enter
Type "# Adding various computer lab equipment"
Enter
Sleep 2s

Type "clear"
Enter
Sleep 500ms

# Start the program and go to Add Equipment
Type "./tenna.sh"
Enter
Sleep 3s

Type "A"
Sleep 2s

# Add first equipment - Keyboard
Type "E0001"
Enter
Sleep 500ms

Type "keyboard"
Enter
Sleep 500ms

Type "Logitech K120"
Enter
Sleep 500ms

Type "LG123456789"
Enter
Sleep 500ms

Type "Available"
Enter
Sleep 500ms

# Use default purchase date
Enter
Sleep 500ms

Type "12-31-2025"
Enter
Sleep 2s

# Add another equipment
Type "y"
Sleep 1s

# Add second equipment - Mouse
Type "E0002"
Enter
Sleep 500ms

Type "mouse"
Enter
Sleep 500ms

Type "Dell MS116"
Enter
Sleep 500ms

Type "DL987654321"
Enter
Sleep 500ms

Type "Unavailable"
Enter
Sleep 500ms

Type "01-15-2024"
Enter
Sleep 500ms

Type "01-15-2025"
Enter
Sleep 2s

# Add third equipment - Monitor
Type "y"
Sleep 1s

Type "E0003"
Enter
Sleep 500ms

Type "monitor"
Enter
Sleep 500ms

Type "ASUS VA24EHE"
Enter
Sleep 500ms

Type "AS111222333"
Enter
Sleep 500ms

Type "Available"
Enter
Sleep 500ms

Type "03-10-2024"
Enter
Sleep 500ms

Type "03-10-2026"
Enter
Sleep 2s

# Quit adding
Type "q"
Sleep 2s

# Exit program
Type "Q"
Sleep 2s
# Skip undertale screen
Type " "
Sleep 1s

Type "clear"
Enter
Type "# Equipment addition complete!"
Sleep 2s
