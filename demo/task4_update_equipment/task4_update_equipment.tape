# VHS Tape - Task 4: Update Equipment Demo
# Equipment Management System by Lye Wei Lun, Lim Yung Juin, Swetha

Output demo/task4_update_equipment/task4_update_equipment.gif
Output demo/task4_update_equipment/task4_update_equipment.mp4

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

Type "# Task 4: Update Equipment Demo"
Enter
Type "# Updating equipment details"
Enter
Sleep 2s

Type "clear"
Enter
Sleep 500ms

# Start the program and go to Update Equipment
Type "./tenna.sh"
Enter
Sleep 3s

Type "U"
Sleep 2s

# Update first equipment
Type "E0001"
Enter
Sleep 2s

# Show current details, then update
# Keep serial number (empty)
Enter
Sleep 500ms

# Change type
Type "keyboard"
Enter
Sleep 500ms

# Update model
Type "Logitech K380"
Enter
Sleep 500ms

# Keep status (empty)
Enter
Sleep 500ms

# Keep purchase date (empty)
Enter
Sleep 500ms

# Update warranty date
Type "2026-12-31"
Enter
Sleep 2s

# Confirm update
Type "y"
Sleep 2s

# Update another equipment
Type "y"
Sleep 1s

# Update second equipment status
Type "E0002"
Enter
Sleep 2s

# Keep everything same except status
Enter
Sleep 500ms
Enter
Sleep 500ms
Enter
Sleep 500ms

# Change status to Available
Type "Available"
Enter
Sleep 500ms

# Keep dates
Enter
Sleep 500ms
Enter
Sleep 2s

# Confirm update
Type "y"
Sleep 2s

# Quit updating
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
Type "# Equipment update complete!"
Sleep 2s
