## Windows disk image

### Installation
tested with Windows 10
- Pro or Enterprise (to disable updates)
- no password (auto login)

### Post install
- [disable User Account Control](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-turn-off-User-Account-Control-in-Windows.html)
- [disable file security warning](https://www.technewstoday.com/open-file-security-warning/)
- copy run-job.bat to [shell:startup](https://support.microsoft.com/en-us/windows/add-an-app-to-run-automatically-at-startup-in-windows-10-150da165-dcd9-7230-517b-cf3c295d89dd)
- [disable updates](https://www.easeus.com/backup-recovery/how-to-stop-windows-10-from-automatically-update.html)

### Usage
When started, the *share* directory is accessible from the VM at ```\\10.0.2.4\qemu``` and the *job.bat* file is executed. If the VM shuts down, than the container exits and the state of the VM is reset.