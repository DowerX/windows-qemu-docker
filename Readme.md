# Windows Qemu Docker

## Description
This project makes it possible to automate tasks on Windows, so you can use the results on Linux afterwards (eg. installing vs_buildtools for later use with [Wine](https://www.winehq.org/)).

## Required disk image
*(tested with Windows 10 Pro ISO)*
- Pro or Enterprise (to [disable updates](https://www.easeus.com/backup-recovery/how-to-stop-windows-10-from-automatically-update.html))
- no password (auto login)
- [disable User Account Control](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-turn-off-User-Account-Control-in-Windows.html)
- [disable file security warning](https://www.technewstoday.com/open-file-security-warning/)
- copy *run-job.bat* to [shell:startup](https://support.microsoft.com/en-us/windows/add-an-app-to-run-automatically-at-startup-in-windows-10-150da165-dcd9-7230-517b-cf3c295d89dd)

## Usage
When started, the *share* directory is accessible from the VM at ```\\10.0.2.4\qemu``` and the *job.bat* file is executed. If the VM shuts down, then the container exits and the state of the VM is reset. \
You can access the VM's desktop with VNC on port 5900 or you can use the qemu monitor prompt with telnet on port 5801.

## TODO
- setup a firewall for the VM
- automate Windows installation, post install setup
- replace the SMB network share with a disk image mount (faster copy)