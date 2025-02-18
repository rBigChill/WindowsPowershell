PowerShell Profile

This repository contains my custom PowerShell profile configuration, including aliases, functions, and scripts to enhance my workflow.

Installation

1. Clone this repository to your system:
   ```powershell
   git clone https://github.com/rBigChill/powershell-profile.git
   ```
2. Backup your existing PowerShell profile:
   ```powershell
   Copy-Item -Path $PROFILE -Destination "$PROFILE.bak" -Force
   ```
3. Copy the profile script to the appropriate location:
   ```powershell
   Copy-Item -Path ./profile.ps1 -Destination $PROFILE -Force
   ```
4. Restart your PowerShell session for changes to take effect.

Usage

- Custom Aliases: Shortcuts for frequently used commands.
- Functions: Predefined scripts to automate tasks.
- Modules: Additional scripts to extend PowerShell functionality.

Customization

Feel free to modify `profile.ps1` to suit your needs. You can add more aliases, functions, and scripts to enhance your PowerShell experience.

Contributing

If you have improvements, feel free to fork this repository and submit a pull request!

License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

