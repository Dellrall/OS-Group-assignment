# VHS Tape - Task 1: Main Menu and Navigation Demo
# Equipment Management System by Lye Wei Lun, Lim Yung Juin, Swetha

Output demo/task1_main_menu/task1_main_menu.gif
Output demo/task1_main_menu/task1_main_menu.mp4

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

Type "# Task 1: Main Menu and Navigation Demo"
Enter
Type "# Equipment Management System"
Enter
Sleep 2s

Type "clear"
Enter
Sleep 500ms

# Show the main menu
Type "./tenna.sh"
Enter
Sleep 3s

# Navigate through menu options (highlight each option)
Type "# Let's explore each menu option"
Sleep 2s

# Show option A
Type "A"
Sleep 2s
Type "q"
Sleep 1s

# Back to main menu
Sleep 2s
Type "# Option S - Search Equipment"
Sleep 1s
Type "S"
Sleep 2s
Type "q"
Sleep 1s

# Back to main menu  
Sleep 2s
Type "# Option U - Update Equipment"
Sleep 1s
Type "U"
Sleep 2s
Type "q"
Sleep 1s

# Back to main menu
Sleep 2s
Type "# Option D - Delete Equipment" 
Sleep 1s
Type "D"
Sleep 2s
Type "q"
Sleep 1s

# Back to main menu
Sleep 2s
Type "# Option M - Sort by Model"
Sleep 1s
Type "M"
Sleep 2s
Ctrl+C

Sleep 1s
Type "# Main menu navigation complete!"
Sleep 2s

Type "clear"
Enter
Sleep 1s
