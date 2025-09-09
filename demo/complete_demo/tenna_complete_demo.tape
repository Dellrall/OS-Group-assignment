# VHS Tape - Complete Equipment Management System Demo
# Showcasing all features in one comprehensive recording
# By Lye Wei Lun, Lim Yung Juin, Swetha

Output demo/complete_demo/tenna_complete_demo.gif
Output demo/complete_demo/tenna_complete_demo.mp4

Require echo

Set Shell "bash"
Set FontSize 16
Set Width 1200
Set Height 800
Set Theme "Dracula"

# Introduction
Type "clear"
Enter
Sleep 1s

Type "# ================================================================"
Enter
Type "#           EQUIPMENT MANAGEMENT SYSTEM - COMPLETE DEMO"
Enter  
Type "#        Created by Lye Wei Lun, Lim Yung Juin, Swetha"
Enter
Type "# ================================================================"
Enter
Sleep 3s

Type "# Features:"
Enter
Type "# • Task 1: Beautiful main menu with Ononoki Yotsugi theme"
Enter
Type "# • Task 2: Add equipment with validation"
Enter
Type "# • Task 3: Search by serial number"
Enter
Type "# • Task 4: Update equipment details"
Enter
Type "# • Task 5: Delete equipment safely"
Enter
Type "# • Task 6: Sort with Monogatari character themes"
Enter
Type "# • Bonus: Undertale-style thank you screen"
Enter
Sleep 4s

Type "clear"
Enter
Sleep 1s

# Start complete demonstration
Type "./tenna.sh"
Enter
Sleep 3s

# ============= ADD EQUIPMENT =============
Type "A"
Sleep 2s

# Add keyboard
Type "E0001"
Enter
Sleep 300ms
Type "keyboard"
Enter
Sleep 300ms
Type "Logitech K120"
Enter
Sleep 300ms
Type "LG123456789"
Enter
Sleep 300ms
Type "Available"
Enter
Sleep 300ms
Enter  # Default date
Sleep 300ms
Type "12-31-2025"
Enter
Sleep 1s

# Add mouse
Type "y"
Sleep 500ms
Type "E0002"
Enter
Sleep 300ms
Type "mouse"
Enter
Sleep 300ms
Type "Dell MS116"
Enter
Sleep 300ms
Type "DL987654321"
Enter
Sleep 300ms
Type "Unavailable"
Enter
Sleep 300ms
Type "01-15-2024"
Enter
Sleep 300ms
Type "01-15-2025"
Enter
Sleep 1s

# Add monitor
Type "y"
Sleep 500ms
Type "E0003"
Enter
Sleep 300ms
Type "monitor"
Enter
Sleep 300ms
Type "ASUS VA24EHE"
Enter
Sleep 300ms
Type "AS111222333"
Enter
Sleep 300ms
Type "Available"
Enter
Sleep 300ms
Type "03-10-2024"
Enter
Sleep 300ms
Type "03-10-2026"
Enter
Sleep 1s

Type "q"
Sleep 2s

# ============= SEARCH EQUIPMENT =============
Type "S"
Sleep 2s
Type "LG123456789"
Enter
Sleep 2s
Type "q"
Sleep 2s

# ============= UPDATE EQUIPMENT =============
Type "U"
Sleep 2s
Type "E0002"
Enter
Sleep 2s
Enter  # Keep serial
Sleep 300ms
Enter  # Keep type
Sleep 300ms
Enter  # Keep model
Sleep 300ms
Type "Available"  # Change status
Enter
Sleep 300ms
Enter  # Keep purchase
Sleep 300ms
Enter  # Keep warranty
Sleep 1s
Type "y"  # Confirm
Sleep 2s
Type "q"
Sleep 2s

# ============= SORT DEMONSTRATIONS =============
# Sort by Model (Senjougahara Purple Theme)
Type "M"
Sleep 3s
Type "q"
Sleep 2s

# Sort by Status (Mayoi Green Theme)
Type "T"
Sleep 2s
Type "Available"
Enter
Sleep 3s
Type "q"
Sleep 2s

# Sort by Type (Shinobu Golden Theme)
Type "P"
Sleep 2s
Type "keyboard"
Enter
Sleep 3s
Type "q"
Sleep 2s

# ============= DELETE EQUIPMENT =============
Type "D"
Sleep 2s
Type "E0003"
Enter
Sleep 2s
Type "y"  # Confirm deletion
Sleep 2s
Type "q"
Sleep 2s

# ============= FINAL SEARCH TO SHOW CHANGES =============
Type "S"
Sleep 2s
Type "AS111222333"  # This should not be found
Enter
Sleep 2s
Type "q"
Sleep 2s

# ============= UNDERTALE EXIT SCREEN =============
Type "Q"
Sleep 3s
# Show the beautiful Undertale thank you screen
Type " "
Sleep 2s

Type "clear"
Enter
Type "# ================================================================"
Enter
Type "#              EQUIPMENT MANAGEMENT SYSTEM DEMO COMPLETE!"
Enter
Type "#                    Thank you for watching! ♥"
Enter
Type "# ================================================================"
Enter
Sleep 3s
