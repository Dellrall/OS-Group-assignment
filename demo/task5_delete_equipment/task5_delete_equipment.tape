# VHS Tape - Task 5: Delete Equipment Demo
# Equipment Management System by Lye Wei Lun, Lim Yung Juin, Swetha

Output demo/task5_delete_equipment/task5_delete_equipment.gif
Output demo/task5_delete_equipment/task5_delete_equipment.mp4

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

Type "# Task 5: Delete Equipment Demo"
Enter
Type "# Safely removing equipment from database"
Enter
Sleep 2s

Type "clear"
Enter
Sleep 500ms

# Start the program and go to Delete Equipment
Type "./tenna.sh"
Enter
Sleep 3s

Type "D"
Sleep 2s

# Try to delete non-existent equipment first
Type "E9999"
Enter
Sleep 2s

# Try invalid format
Type "INVALID"
Enter
Sleep 2s

# Delete actual equipment
Type "E0003"
Enter
Sleep 2s

# Confirm deletion
Type "y"
Sleep 2s

# Delete another equipment  
Type "y"
Sleep 1s

Type "E0002"
Enter
Sleep 2s

# Cancel this deletion
Type "q"
Sleep 2s

# Quit deleting
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
Type "# Equipment deletion demonstrated!"
Sleep 2s
