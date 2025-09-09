# VHS Tape - Task 3: Search Equipment Demo
# Equipment Management System by Lye Wei Lun, Lim Yung Juin, Swetha

Output demo/task3_search_equipment/task3_search_equipment.gif
Output demo/task3_search_equipment/task3_search_equipment.mp4

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

Type "# Task 3: Search Equipment Demo"
Enter
Type "# Searching equipment by serial number"
Enter
Sleep 2s

Type "clear"
Enter
Sleep 500ms

# Start the program and go to Search Equipment
Type "./tenna.sh"
Enter
Sleep 3s

Type "S"
Sleep 2s

# Search for first equipment
Type "LG123456789"
Enter
Sleep 3s

# Search another
Type "y"
Sleep 1s

# Search for second equipment
Type "DL987654321"
Enter
Sleep 3s

# Search another
Type "y"
Sleep 1s

# Search for third equipment
Type "AS111222333"
Enter
Sleep 3s

# Try invalid serial number
Type "y"
Sleep 1s

Type "INVALID123"
Enter
Sleep 2s

# Try again with proper format but non-existent
Type "ZZ999999999"
Enter
Sleep 2s

# Quit searching
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
Type "# Search functionality demonstrated!"
Sleep 2s
