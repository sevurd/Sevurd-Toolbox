Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

Write-Host "Downloading script..."
Import-Module BitsTransfer
Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Sevurd-Toolbox.ps1?raw=true" -Destination 'C:\Windows\_Sevurd_Toolbox.ps1'
Write-Host "Creating shortcut on Desktop..."
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Sevurd Toolbox.lnk")
$Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$Shortcut.Arguments = "iwr -useb https://bit.ly/sevurd-toolbox | iex"
$Shortcut.Save()
Write-Host "Creating folder in C drive..."
New-Item -Path "C:\" -Name "Sevurd Toolbox" -ItemType "directory" -ErrorAction SilentlyContinue

# GUI Specs
Write-Host "Checking winget..."

# Check if winget is installed
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    'Winget Already Installed'
}  
else{
    # Installing winget from the Microsoft Store
	Write-Host "Winget not found, installing it now."
    $ResultText.text = "`r`n" +"`r`n" + "Installing Winget... Please Wait"
	Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
	Write-Host "Winget Installed"
    $ResultText.text = "`r`n" +"`r`n" + "Winget Installed - Ready for Next Task"
}


$Form                         = New-Object system.Windows.Forms.Form
$Form.ClientSize              = New-Object System.Drawing.Point(1050,1000)
$Form.text                    = "Windows Toolbox By Sevurd"
$Form.StartPosition           = "CenterScreen"
$Form.TopMost                 = $false
$Form.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#202020")
$Form.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.ClientSize              = '1050, 1000'
$Form.FormBorderStyle         = 'FixedSingle'

# GUI Icon
$iconBase64                      = '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'
$iconBytes                       = [Convert]::FromBase64String($iconBase64)
$stream                          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
$stream.Write($iconBytes, 0, $iconBytes.Length)
$Form.Icon                    = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

$Form.Width                   = $objImage.Width
$Form.Height                  = $objImage.Height

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 939
$Panel1.width                    = 219
$Panel1.location                 = New-Object System.Drawing.Point(6,54)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Installer"
$Label1.AutoSize                 = $true
$Label1.width                    = 230
$Label1.height                   = 25
$Label1.location                 = New-Object System.Drawing.Point(60,11)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Utilities"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(89,11)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$7zip                            = New-Object system.Windows.Forms.Button
$7zip.text                       = "7-Zip"
$7zip.width                      = 212
$7zip.height                     = 30
$7zip.location                   = New-Object System.Drawing.Point(4,30)
$7zip.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$visualc                         = New-Object system.Windows.Forms.Button
$visualc.text                    = "Visual C++"
$visualc.width                   = 212
$visualc.height                  = 30
$visualc.location                = New-Object System.Drawing.Point(4,65)
$visualc.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$directx                         = New-Object system.Windows.Forms.Button
$directx.text                    = "DirectX"
$directx.width                   = 212
$directx.height                  = 30
$directx.location                = New-Object System.Drawing.Point(4,100)
$directx.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$notepad                         = New-Object system.Windows.Forms.Button
$notepad.text                    = "Notepad++"
$notepad.width                   = 212
$notepad.height                  = 30
$notepad.location                = New-Object System.Drawing.Point(4,135)
$notepad.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$discord                         = New-Object system.Windows.Forms.Button
$discord.text                    = "Discord"
$discord.width                   = 212
$discord.height                  = 30
$discord.location                = New-Object System.Drawing.Point(4,170)
$discord.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$spotify                         = New-Object system.Windows.Forms.Button
$spotify.text                    = "Spotify"
$spotify.width                   = 212
$spotify.height                  = 30
$spotify.location                = New-Object System.Drawing.Point(4,205)
$spotify.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$whatsapp                        = New-Object system.Windows.Forms.Button
$whatsapp.text                   = "WhatsApp"
$whatsapp.width                  = 212
$whatsapp.height                 = 30
$whatsapp.location               = New-Object System.Drawing.Point(4,240)
$whatsapp.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$sdio                            = New-Object system.Windows.Forms.Button
$sdio.text                       = "Snappy Driver Installer"
$sdio.width                      = 212
$sdio.height                     = 30
$sdio.location                   = New-Object System.Drawing.Point(4,275)
$sdio.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$autoruns                        = New-Object system.Windows.Forms.Button
$autoruns.text                   = "Autoruns"
$autoruns.width                  = 212
$autoruns.height                 = 30
$autoruns.location               = New-Object System.Drawing.Point(4,310)
$autoruns.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$rufus                           = New-Object system.Windows.Forms.Button
$rufus.text                      = "Rufus"
$rufus.width                     = 212
$rufus.height                    = 30
$rufus.location                  = New-Object System.Drawing.Point(4,345)
$rufus.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "Web Browsers"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(67,400)
$Label9.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$brave                           = New-Object system.Windows.Forms.Button
$brave.text                      = "Brave Browser"
$brave.width                     = 212
$brave.height                    = 30
$brave.location                  = New-Object System.Drawing.Point(4,420)
$brave.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$firefox                         = New-Object system.Windows.Forms.Button
$firefox.text                    = "Firefox"
$firefox.width                   = 212
$firefox.height                  = 30
$firefox.location                = New-Object System.Drawing.Point(4,455)
$firefox.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gchrome                         = New-Object system.Windows.Forms.Button
$gchrome.text                    = "Google Chrome"
$gchrome.width                   = 212
$gchrome.height                  = 30
$gchrome.location                = New-Object System.Drawing.Point(3,490)
$gchrome.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label8                          = New-Object system.Windows.Forms.Label
$Label8.text                     = "Game Launchers"
$Label8.AutoSize                 = $true
$Label8.width                    = 25
$Label8.height                   = 10
$Label8.location                 = New-Object System.Drawing.Point(60,550)
$Label8.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$steam                           = New-Object system.Windows.Forms.Button
$steam.text                      = "Steam"
$steam.width                     = 212
$steam.height                    = 30
$steam.location                  = New-Object System.Drawing.Point(4,570)
$steam.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ubisoft                         = New-Object system.Windows.Forms.Button
$ubisoft.text                    = "Ubisoft Connect"
$ubisoft.width                   = 212
$ubisoft.height                  = 30
$ubisoft.location                = New-Object System.Drawing.Point(4,605)
$ubisoft.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$origin                          = New-Object system.Windows.Forms.Button
$origin.text                     = "Origin"
$origin.width                    = 212
$origin.height                   = 30
$origin.location                 = New-Object System.Drawing.Point(4,640)
$origin.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$valorant                        = New-Object system.Windows.Forms.Button
$valorant.text                   = "Valorant"
$valorant.width                  = 212
$valorant.height                 = 30
$valorant.location               = New-Object System.Drawing.Point(4,675)
$valorant.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label7                          = New-Object system.Windows.Forms.Label
$Label7.text                     = "Others"
$Label7.AutoSize                 = $true
$Label7.width                    = 25
$Label7.height                   = 10
$Label7.location                 = New-Object System.Drawing.Point(90,725)
$Label7.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ddu                             = New-Object system.Windows.Forms.Button
$ddu.text                        = "Display Driver Uninstaller"
$ddu.width                       = 212
$ddu.height                      = 30
$ddu.location                    = New-Object System.Drawing.Point(4,745)
$ddu.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$nvcleanstall                    = New-Object system.Windows.Forms.Button
$nvcleanstall.text               = "NVCleanstall"
$nvcleanstall.width              = 212
$nvcleanstall.height             = 30
$nvcleanstall.location           = New-Object System.Drawing.Point(4,780)
$nvcleanstall.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$nvidia                          = New-Object system.Windows.Forms.Button
$nvidia.text                     = "Download Nvidia Driver"
$nvidia.width                    = 212
$nvidia.height                   = 30
$nvidia.location                 = New-Object System.Drawing.Point(4,815)
$nvidia.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$msimode                         = New-Object system.Windows.Forms.Button
$msimode.text                    = "MSI Mode Utility"
$msimode.width                   = 212
$msimode.height                  = 30
$msimode.location                = New-Object System.Drawing.Point(4,850)
$msimode.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 938
$Panel2.width                    = 211
$Panel2.location                 = New-Object System.Drawing.Point(240,54)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "System Tweaks"
$Label3.AutoSize                 = $true
$Label3.width                    = 230
$Label3.height                   = 25
$Label3.location                 = New-Object System.Drawing.Point(349,11)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$essentialtweaks                 = New-Object system.Windows.Forms.Button
$essentialtweaks.text            = "Essential Tweaks"
$essentialtweaks.width           = 205
$essentialtweaks.height          = 75
$essentialtweaks.location        = New-Object System.Drawing.Point(3,24)
$essentialtweaks.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$cleanup                         = New-Object system.Windows.Forms.Button
$cleanup.text                    = "Cleanup Windows"
$cleanup.width                   = 205
$cleanup.height                  = 30
$cleanup.location                = New-Object System.Drawing.Point(3,104)
$cleanup.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$backgroundapps                  = New-Object system.Windows.Forms.Button
$backgroundapps.text             = "Disable Background Apps"
$backgroundapps.width            = 205
$backgroundapps.height           = 30
$backgroundapps.location         = New-Object System.Drawing.Point(3,453)
$backgroundapps.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$cortana                         = New-Object system.Windows.Forms.Button
$cortana.text                    = "Disable Cortana (Search)"
$cortana.width                   = 205
$cortana.height                  = 30
$cortana.location                = New-Object System.Drawing.Point(2,588)
$cortana.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$actioncenter                    = New-Object system.Windows.Forms.Button
$actioncenter.text               = "Disable Action Center"
$actioncenter.width              = 205
$actioncenter.height             = 30
$actioncenter.location           = New-Object System.Drawing.Point(3,176)
$actioncenter.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$darkmode                        = New-Object system.Windows.Forms.Button
$darkmode.text                   = "Dark Mode"
$darkmode.width                  = 205
$darkmode.height                 = 30
$darkmode.location               = New-Object System.Drawing.Point(4,315)
$darkmode.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$performancefx                   = New-Object system.Windows.Forms.Button
$performancefx.text              = "Performance Visual FX"
$performancefx.width             = 205
$performancefx.height            = 30
$performancefx.location          = New-Object System.Drawing.Point(3,419)
$performancefx.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$onedrive                        = New-Object system.Windows.Forms.Button
$onedrive.text                   = "Uninstall OneDrive"
$onedrive.width                  = 205
$onedrive.height                 = 30
$onedrive.location               = New-Object System.Drawing.Point(3,521)
$onedrive.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label15                         = New-Object system.Windows.Forms.Label
$Label15.text                    = "Windows Update"
$Label15.AutoSize                = $true
$Label15.width                   = 25
$Label15.height                  = 10
$Label15.location                = New-Object System.Drawing.Point(732,11)
$Label15.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 328
$Panel4.width                    = 340
$Panel4.location                 = New-Object System.Drawing.Point(699,54)

$defaultwindowsupdate            = New-Object system.Windows.Forms.Button
$defaultwindowsupdate.text       = "Default Settings"
$defaultwindowsupdate.width      = 300
$defaultwindowsupdate.height     = 30
$defaultwindowsupdate.location   = New-Object System.Drawing.Point(24,26)
$defaultwindowsupdate.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$securitywindowsupdate           = New-Object system.Windows.Forms.Button
$securitywindowsupdate.text      = "Security Updates Only"
$securitywindowsupdate.width     = 300
$securitywindowsupdate.height    = 30
$securitywindowsupdate.location  = New-Object System.Drawing.Point(24,142)
$securitywindowsupdate.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$Label16                         = New-Object system.Windows.Forms.Label
$Label16.text                    = "I recommend doing security updates only."
$Label16.AutoSize                = $true
$Label16.width                   = 25
$Label16.height                  = 10
$Label16.location                = New-Object System.Drawing.Point(62,65)
$Label16.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label17                         = New-Object system.Windows.Forms.Label
$Label17.text                    = "- Delays Features updates up to 3 years"
$Label17.AutoSize                = $true
$Label17.width                   = 25
$Label17.height                  = 10
$Label17.location                = New-Object System.Drawing.Point(63,84)
$Label17.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label18                         = New-Object system.Windows.Forms.Label
$Label18.text                    = "- Delays Security updates 4 days"
$Label18.AutoSize                = $true
$Label18.width                   = 25
$Label18.height                  = 10
$Label18.location                = New-Object System.Drawing.Point(63,105)
$Label18.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label19                         = New-Object system.Windows.Forms.Label
$Label19.text                    = "- Sets Maximum Active Time"
$Label19.AutoSize                = $true
$Label19.width                   = 25
$Label19.height                  = 10
$Label19.location                = New-Object System.Drawing.Point(63,126)
$Label19.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$PictureBox1                     = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width               = 343
$PictureBox1.height              = 136
$PictureBox1.location            = New-Object System.Drawing.Point(580,850)
$PictureBox1.imageLocation       = "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Sevurd-Toolbox-White.png?raw=true"
$PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$lightmode                       = New-Object system.Windows.Forms.Button
$lightmode.text                  = "Light Mode"
$lightmode.width                 = 205
$lightmode.height                = 30
$lightmode.location              = New-Object System.Drawing.Point(3,350)
$lightmode.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 381
$Panel3.width                    = 220
$Panel3.location                 = New-Object System.Drawing.Point(464,54)

$EActionCenter                   = New-Object system.Windows.Forms.Button
$EActionCenter.text              = "Enable Action Center"
$EActionCenter.width             = 205
$EActionCenter.height            = 30
$EActionCenter.location          = New-Object System.Drawing.Point(3,210)
$EActionCenter.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ECortana                        = New-Object system.Windows.Forms.Button
$ECortana.text                   = "Enable Cortana (Search)"
$ECortana.width                  = 205
$ECortana.height                 = 30
$ECortana.location               = New-Object System.Drawing.Point(3,622)
$ECortana.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$RBackgroundApps                 = New-Object system.Windows.Forms.Button
$RBackgroundApps.text            = "Allow Background Apps"
$RBackgroundApps.width           = 205
$RBackgroundApps.height          = 30
$RBackgroundApps.location        = New-Object System.Drawing.Point(3,487)
$RBackgroundApps.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$HTrayIcons                      = New-Object system.Windows.Forms.Button
$HTrayIcons.text                 = "Hide Tray Icons"
$HTrayIcons.width                = 205
$HTrayIcons.height               = 30
$HTrayIcons.location             = New-Object System.Drawing.Point(3,278)
$HTrayIcons.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$EClipboardHistory               = New-Object system.Windows.Forms.Button
$EClipboardHistory.text          = "Enable Clipboard History"
$EClipboardHistory.width         = 205
$EClipboardHistory.height        = 30
$EClipboardHistory.location      = New-Object System.Drawing.Point(3,688)
$EClipboardHistory.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ELocation                       = New-Object system.Windows.Forms.Button
$ELocation.text                  = "Enable Location Tracking"
$ELocation.width                 = 205
$ELocation.height                = 30
$ELocation.location              = New-Object System.Drawing.Point(2,655)
$ELocation.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$InstallOneDrive                 = New-Object system.Windows.Forms.Button
$InstallOneDrive.text            = "Install OneDrive"
$InstallOneDrive.width           = 205
$InstallOneDrive.height          = 30
$InstallOneDrive.location        = New-Object System.Drawing.Point(2,554)
$InstallOneDrive.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$yourphonefix                    = New-Object system.Windows.Forms.Button
$yourphonefix.text               = "Your Phone App Fix"
$yourphonefix.width              = 211
$yourphonefix.height             = 30
$yourphonefix.location           = New-Object System.Drawing.Point(5,332)
$yourphonefix.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$removebloat                     = New-Object system.Windows.Forms.Button
$removebloat.text                = "Remove MS Store Apps"
$removebloat.width               = 204
$removebloat.height              = 34
$removebloat.location            = New-Object System.Drawing.Point(3,800)
$removebloat.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$reinstallbloat                  = New-Object system.Windows.Forms.Button
$reinstallbloat.text             = "Reinstall MS Store Apps"
$reinstallbloat.width            = 205
$reinstallbloat.height           = 30
$reinstallbloat.location         = New-Object System.Drawing.Point(3,848)
$reinstallbloat.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$appearancefx                    = New-Object system.Windows.Forms.Button
$appearancefx.text               = "Appearance Visual FX"
$appearancefx.width              = 205
$appearancefx.height             = 30
$appearancefx.location           = New-Object System.Drawing.Point(4,385)
$appearancefx.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$STrayIcons                      = New-Object system.Windows.Forms.Button
$STrayIcons.text                 = "Show Tray Icons"
$STrayIcons.width                = 205
$STrayIcons.height               = 30
$STrayIcons.location             = New-Object System.Drawing.Point(2,244)
$STrayIcons.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$windowsupdatefix                = New-Object system.Windows.Forms.Button
$windowsupdatefix.text           = "Windows Update Reset"
$windowsupdatefix.width          = 300
$windowsupdatefix.height         = 30
$windowsupdatefix.location       = New-Object System.Drawing.Point(25,216)
$windowsupdatefix.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$ResultText                      = New-Object system.Windows.Forms.TextBox
$ResultText.multiline            = $true
$ResultText.width                = 382
$ResultText.height               = 130
$ResultText.location             = New-Object System.Drawing.Point(576,491)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label10                         = New-Object system.Windows.Forms.Label
$Label10.text                    = "Current Status:"
$Label10.AutoSize                = $true
$Label10.width                   = 25
$Label10.height                  = 10
$Label10.location                = New-Object System.Drawing.Point(658,448)
$Label10.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$EHibernation                    = New-Object system.Windows.Forms.Button
$EHibernation.text               = "Enable Hibernation"
$EHibernation.width              = 205
$EHibernation.height             = 30
$EHibernation.location           = New-Object System.Drawing.Point(3,721)
$EHibernation.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$dualboottime                    = New-Object system.Windows.Forms.Button
$dualboottime.text               = "Set Time to UTC (Dual Boot)"
$dualboottime.width              = 205
$dualboottime.height             = 30
$dualboottime.location           = New-Object System.Drawing.Point(3,754)
$dualboottime.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label11                         = New-Object system.Windows.Forms.Label
$Label11.text                    = "Videos to Fix Windows"
$Label11.AutoSize                = $true
$Label11.width                   = 25
$Label11.height                  = 10
$Label11.location                = New-Object System.Drawing.Point(687,659)
$Label11.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$urlfixwinstartup                = New-Object system.Windows.Forms.Button
$urlfixwinstartup.text           = "Repair Windows Startup"
$urlfixwinstartup.width          = 232
$urlfixwinstartup.height         = 30
$urlfixwinstartup.location       = New-Object System.Drawing.Point(646,702)
$urlfixwinstartup.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$urlremovevirus                  = New-Object system.Windows.Forms.Button
$urlremovevirus.text             = "Clean Viruses"
$urlremovevirus.width            = 232
$urlremovevirus.height           = 30
$urlremovevirus.location         = New-Object System.Drawing.Point(646,745)
$urlremovevirus.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$urlcreateiso                    = New-Object system.Windows.Forms.Button
$urlcreateiso.text               = "Create Custom ISO"
$urlcreateiso.width              = 232
$urlcreateiso.height             = 30
$urlcreateiso.location           = New-Object System.Drawing.Point(646,790)
$urlcreateiso.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ncpa                            = New-Object system.Windows.Forms.Button
$ncpa.text                       = "Network Connections"
$ncpa.width                      = 211
$ncpa.height                     = 30
$ncpa.location                   = New-Object System.Drawing.Point(4,126)
$ncpa.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldcontrolpanel                 = New-Object system.Windows.Forms.Button
$oldcontrolpanel.text            = "Win7 Control Panel"
$oldcontrolpanel.width           = 211
$oldcontrolpanel.height          = 30
$oldcontrolpanel.location        = New-Object System.Drawing.Point(4,193)
$oldcontrolpanel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsoundpanel                   = New-Object system.Windows.Forms.Button
$oldsoundpanel.text              = "Win7 Sound Panel"
$oldsoundpanel.width             = 211
$oldsoundpanel.height            = 30
$oldsoundpanel.location          = New-Object System.Drawing.Point(5,262)
$oldsoundpanel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsystempanel                  = New-Object system.Windows.Forms.Button
$oldsystempanel.text             = "Win7 System Panel"
$oldsystempanel.width            = 211
$oldsystempanel.height           = 30
$oldsystempanel.location         = New-Object System.Drawing.Point(5,298)
$oldsystempanel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$NFS                             = New-Object system.Windows.Forms.Button
$NFS.text                        = "Enable NFS"
$NFS.width                       = 211
$NFS.height                      = 30
$NFS.location                    = New-Object System.Drawing.Point(4,57)
$NFS.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$laptopnumlock                   = New-Object system.Windows.Forms.Button
$laptopnumlock.text              = "Laptop Numlock Fix"
$laptopnumlock.width             = 211
$laptopnumlock.height            = 30
$laptopnumlock.location          = New-Object System.Drawing.Point(4,92)
$laptopnumlock.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$disableupdates                  = New-Object system.Windows.Forms.Button
$disableupdates.text             = "Disable Update Services"
$disableupdates.width            = 300
$disableupdates.height           = 30
$disableupdates.location         = New-Object System.Drawing.Point(23,292)
$disableupdates.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$enableupdates                   = New-Object system.Windows.Forms.Button
$enableupdates.text              = "Enable Update Services"
$enableupdates.width             = 300
$enableupdates.height            = 30
$enableupdates.location          = New-Object System.Drawing.Point(25,179)
$enableupdates.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$Label12                         = New-Object system.Windows.Forms.Label
$Label12.text                    = "NOT RECOMMENDED!!!"
$Label12.AutoSize                = $true
$Label12.width                   = 25
$Label12.height                  = 10
$Label12.location                = New-Object System.Drawing.Point(98,275)
$Label12.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Virtualization                  = New-Object system.Windows.Forms.Button
$Virtualization.text             = "Enable HyperV + WSL"
$Virtualization.width            = 211
$Virtualization.height           = 30
$Virtualization.location         = New-Object System.Drawing.Point(4,23)
$Virtualization.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldpower                        = New-Object system.Windows.Forms.Button
$oldpower.text                   = "Win7 Power Panel"
$oldpower.width                  = 211
$oldpower.height                 = 30
$oldpower.location               = New-Object System.Drawing.Point(4,227)
$oldpower.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$restorepower                    = New-Object system.Windows.Forms.Button
$restorepower.text               = "Restore Power Options"
$restorepower.width              = 211
$restorepower.height             = 30
$restorepower.location           = New-Object System.Drawing.Point(4,159)
$restorepower.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Form.controls.AddRange(@($Panel1,$Panel2,$Label3,$Label15,$Panel4,$PictureBox1,$Label1,$Panel3,$ResultText,$Label10,$Label11,$urlfixwinstartup,$urlremovevirus,$urlcreateiso))
$Panel1.controls.AddRange(@($brave,$firefox,$7zip,$whatsapp,$nvidia,$notepad,$gchrome,$valorant,$origin,$ubisoft,$directx,$msimode,$visualc,$nvcleanstall,$Label2,$rufus,$ddu,$sdio,$steam,$Label7,$Label8,$Label9,$advancedipscanner,$putty,$autoruns,$translucenttb,$spotify,$discord,$autohotkey))
$Panel2.controls.AddRange(@($essentialtweaks,$cleanup,$backgroundapps,$cortana,$actioncenter,$darkmode,$performancefx,$onedrive,$lightmode,$EActionCenter,$ECortana,$RBackgroundApps,$HTrayIcons,$EClipboardHistory,$ELocation,$InstallOneDrive,$removebloat,$reinstallbloat,$WarningLabel,$Label5,$appearancefx,$STrayIcons,$EHibernation,$dualboottime))
$Panel4.controls.AddRange(@($defaultwindowsupdate,$securitywindowsupdate,$Label16,$Label17,$Label18,$Label19,$windowsupdatefix,$disableupdates,$enableupdates,$Label12))
$Panel3.controls.AddRange(@($yourphonefix,$ncpa,$oldcontrolpanel,$oldsoundpanel,$oldsystempanel,$NFS,$laptopnumlock,$Virtualization,$oldpower,$restorepower))



$firefox.Add_Click({
    Write-Host "Installing Firefox"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Firefox... Please Wait" 
    winget install -e Mozilla.Firefox | Out-Host
    if($?) { Write-Host "Installed Firefox" }
    $ResultText.text = "`r`n" + "Finished Installing Firefox" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$brave.Add_Click({
    Write-Host "Installing Brave Browser"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Brave... Please Wait" 
    winget install -e BraveSoftware.BraveBrowser | Out-Host
    if($?) { Write-Host "Installed Brave Browser" }
    $ResultText.text = "`r`n" + "Finished Installing Brave" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$gchrome.Add_Click({
    Write-Host "Installing Google Chrome"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Google Chrome... Please Wait" 
    winget install -e Google.Chrome | Out-Host
    if($?) { Write-Host "Installed Google Chrome" }
    $ResultText.text = "`r`n" + "Finished Installing Google Chrome" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$sdio.Add_Click({
    Write-Host "Installing Snappy Driver Installer Origin"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Snappy Driver Installer Origin... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.12.2.742.zip" -Destination "C:\Sevurd Toolbox\SDIO.zip"
    Expand-Archive -Path 'C:\Sevurd Toolbox\SDIO.zip' -DestinationPath "C:\Program Files (x86)"
    Start-Process -FilePath "C:\Program Files (x86)\SDIO_1.12.2.742\SDIO_x64_R742.exe" -WorkingDirectory "C:\Program Files (x86)\SDIO_1.12.2.742" | Out-Host
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Snappy Driver Installer.lnk")
    $Shortcut.TargetPath = "C:\Program Files (x86)\SDIO_1.12.2.742\SDIO_x64_R742.exe"
    $Shortcut.Save()
    if($?) { Write-Host "Installed Snappy Driver Installer Origin" }
    $ResultText.text = "`r`n" + "Finished Installing Snappy Driver Installer Origin" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$discord.Add_Click({
    Write-Host "Installing Discord"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Discord... Please Wait" 
    winget install -e Discord.Discord | Out-Host
    New-Item -Path "$env:USERPROFILE\AppData\Roaming\" -Name "discord" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/discord/settings.json?raw=true" -Destination "$env:USERPROFILE\AppData\Roaming\discord\settings.json"
    if($?) { Write-Host "Installed Discord" }
    $ResultText.text = "`r`n" + "Finished Installing Discord" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$nvidia.Add_Click({
    Write-Host "Download Nvidia Driver"
    $ResultText.text = "`r`n" +"`r`n" + "Download Nvidia Driver..." 
    Start-Process "https://www.nvidia.com/Download/Find.aspx"
})

$msimode.Add_Click({
    Write-Host "Installing MSI Mode Utility"
    $ResultText.text = "`r`n" +"`r`n" + "Installing MSI Mode Utility" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/MSI%20Mode.zip?raw=true" -Destination "C:\Sevurd Toolbox\MSI Mode.zip"
    Expand-Archive -Path 'C:\Sevurd Toolbox\MSI Mode.zip' -DestinationPath 'C:\Program Files (x86)'
    & 'C:\Program Files (x86)\MSI Mode\MSI_util_v3.exe'
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\MSI Mode.lnk")
    $Shortcut.TargetPath = "C:\Program Files (x86)\MSI Mode\MSI_util_v3.exe"
    $Shortcut.Save()
    if($?) { Write-Host "Installed MSI Mode Utility" }
    $ResultText.text = "`r`n" + "Finished Installing MSI Mode Utility" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$notepad.Add_Click({
    Write-Host "Installing Notepad++"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Notepad++... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.3.3/npp.8.3.3.Installer.x64.exe" -Destination 'C:\Sevurd Toolbox\notepad++.exe'
    & 'C:\Sevurd Toolbox\notepad++.exe' /S
    New-Item -Path "$env:USERPROFILE\AppData\Roaming\" -Name "Notepad++" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Notepad%2B%2B/config.xml?raw=true" -Destination "$env:USERPROFILE\AppData\Roaming\Notepad++\config.xml"
    Write-Host "Installed Notepad++"
    $ResultText.text = "`r`n" + "Finished Installing NotePad++" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$ubisoft.Add_Click({
    Write-Host "Installing Ubisift Connect"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Ubisift Connect... Please Wait" 
    winget install -e Ubisoft.Connect | Out-Host
    if($?) { Write-Host "Installed Ubisift Connect" }
    $ResultText.text = "`r`n" + "Finished Installing Ubisift Connect" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$origin.Add_Click({
    Write-Host "Installing Origin"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Origin... Please Wait" 
    winget install -e ElectronicArts.EADesktop | Out-Host
    if($?) { Write-Host "Installed Origin" }
    $ResultText.text = "`r`n" + "Finished Installing Origin" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$valorant.Add_Click({
    Write-Host "Installing Valorant"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Valorant... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://valorant.secure.dyn.riotcdn.net/channels/public/x/installer/current/live.live.na.exe" -Destination 'C:\Sevurd Toolbox\Valorant.exe'
    & 'C:\Sevurd Toolbox\Valorant.exe'
    Write-Host "Installed Valorant"
    $ResultText.text = "`r`n" + "Finished Installing Valorant" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$7zip.Add_Click({
    Write-Host "Installing 7-Zip Compression Tool"
    $ResultText.text = "`r`n" +"`r`n" + "Installing 7-Zip Compression Tool... Please Wait" 
    winget install -e 7zip.7zip | Out-Host
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/7-ZIP.reg?raw=true" -Destination 'C:\Sevurd Toolbox\7-ZIP.reg'
    regedit /s "C:\Sevurd Toolbox\7-ZIP.reg"
    if($?) { Write-Host "Installed 7-Zip Compression Tool" }
    $ResultText.text = "`r`n" + "Finished Installing 7-Zip Compression Tool" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$nvcleanstall.Add_Click({
    Write-Host "Installing NVCleanstall"
    $ResultText.text = "`r`n" +"`r`n" + "Installing NVCleanstall... Please Wait" 
    winget install -e TechPowerUp.NVCleanstall | Out-Host
    if($?) { Write-Host "Installed NVCleanstall" }
    $ResultText.text = "`r`n" + "Finished Installing NVCleanstall" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$ddu.Add_Click({
    Write-Host "Installing Display Driver Uninstaller"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Display Driver Uninstaller... Please Wait"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/DDU.zip?raw=true" -Destination 'C:\Sevurd Toolbox\DDU.zip'
    Expand-Archive -path 'C:\Sevurd Toolbox\DDU.zip' -DestinationPath 'C:\Program Files (x86)'
    & 'C:\Program Files (x86)\Display Driver Uninstaller\Display Driver Uninstaller.exe'
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Display Driver Uninstaller.lnk")
    $Shortcut.TargetPath = "C:\Program Files (x86)\Display Driver Uninstaller\Display Driver Uninstaller.exe"
    $Shortcut.Save()
    Write-Host "Installed Display Driver Uninstaller"
    $ResultText.text = "`r`n" + "Finished Installing Display Driver Uninstaller" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$urlremovevirus.Add_Click({
    Start-Process "https://youtu.be/CHtZ9-9ch2w"
})

$urlfixwinstartup.Add_Click({
    Start-Process "https://youtu.be/sOihh4ZNOf4"
})

$urlcreateiso.Add_Click({
    Start-Process "https://youtu.be/R6XPff38iSc"
})

$visualc.Add_Click({
    Write-Host "Installing Visual C++"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Visual C++... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://kutt.it/vcppredist" -Destination 'C:\Sevurd Toolbox\VisualCppRedist.zip'
    Expand-Archive -path 'C:\Sevurd Toolbox\VisualCppRedist.zip' -DestinationPath 'C:\Sevurd Toolbox'
    & 'C:\Sevurd Toolbox\VisualCppRedist_AIO_x86_x64.exe' /ai | Out-Host
    if($?) { Write-Host "Installed Visual C++" }
    $ResultText.text = "`r`n" + "Finished Installing Visual C++" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$directx.Add_Click({
    Write-Host "Installing DirectX"
    $ResultText.text = "`r`n" +"`r`n" + "Installing DirectX... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe" -Destination 'C:\Sevurd Toolbox\dxwebsetup.exe'
    & 'C:\Sevurd Toolbox\dxwebsetup.exe'
    $ResultText.text = "`r`n" + "Finished Installing DirectX" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$rufus.Add_Click({
    Write-Host "Installing Rufus"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Rufus... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/pbatard/rufus/releases/download/v3.18/rufus-3.18.exe" -Destination 'C:\Sevurd Toolbox\rufus-3.18.exe'
    Write-Host "Installed Rufus"
    $ResultText.text = "`r`n" + "Finished Installing Rufus" + "`r`n" + "`r`n" + "Ready for Next Task"
    & 'C:\Sevurd Toolbox\rufus-3.18.exe' | Out-Null
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Rufus.lnk")
    $Shortcut.TargetPath = "C:\Sevurd Toolbox\rufus-3.18.exe"
    $Shortcut.Save()
})

$spotify.Add_Click({
    Write-Host "Installing Spotify"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Spotify... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://download.scdn.co/SpotifyFullSetup.exe" -Destination 'C:\Sevurd Toolbox\SpotifyFullSetup.exe'
    & 'C:\Sevurd Toolbox\SpotifyFullSetup.exe' /Silent
    New-Item -Path "$env:USERPROFILE\AppData\Roaming\" -Name "Spotify" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Spotify/prefs?raw=true" -Destination "$env:USERPROFILE\AppData\Roaming\Spotify\prefs"
    Write-Host "Installed Spotify"
    $ResultText.text = "`r`n" + "Finished Installing Spotify" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$autoruns.Add_Click({
    Write-Host "Installing Autoruns"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Autoruns... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Autoruns.zip?raw=true" -Destination 'C:\Sevurd Toolbox\Autoruns.zip'
    Expand-Archive -path 'C:\Sevurd Toolbox\Autoruns.zip' -DestinationPath 'C:\Program Files'
    & 'C:\Program Files\Autoruns\Autoruns64.exe'
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Autoruns.lnk")
    $Shortcut.TargetPath = "C:\Program Files\Autoruns\Autoruns64.exe"
    $Shortcut.Save()
    Write-Host "Installed Autoruns"
    $ResultText.text = "`r`n" + "Finished Installing Autoruns" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$whatsapp.Add_Click({
    Write-Host "Installing WhatsApp"
    $ResultText.text = "`r`n" +"`r`n" + "Installing WhatsApp... Please Wait" 
    winget install -e WhatsApp.WhatsApp | Out-Host
    Write-Host "Installed Whatsapp "
    $ResultText.text = "`r`n" + "Finished Installing WhatsApp" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$steam.Add_Click({
    Write-Host "Installing Steam"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Steam... Please Wait" 
    winget install -e Valve.Steam | Out-Host
    Write-Host "Installed Steam"
    $ResultText.text = "`r`n" + "Finished Installing Steam" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$essentialtweaks.Add_Click({
    Write-Host "Creating Restore Point incase something bad happens"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Essential Tools... Please Wait" 
    Enable-ComputerRestore -Drive "C:\"
    Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

    Write-Host "Transfering Essential Files..."
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/_BitsumHighestPerformance.pow?raw=true" -Destination 'C:\Windows\_BitsumHighestPerformance.pow'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/_Cleanup.cmd?raw=true" -Destination 'C:\Windows\_Cleanup.cmd'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/_NvidiaBaseProfile.nip?raw=true" -Destination 'C:\Windows\_NvidiaBaseProfile.nip'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/_NvidiaProfileInspector.exe?raw=true" -Destination 'C:\Windows\_NvidiaProfileInspector.exe'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/_SetTimerResolutionService.exe?raw=true" -Destination 'C:\Windows\_SetTimerResolutionService.exe'

    Write-Host "Running O&O Shutup with Recommended Settings"
    $ResultText.text += "`r`n" +"Running O&O Shutup with Recommended Settings"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/sevurd/Sevurd-Toolbox/main/ooshutup10.cfg?raw=true" -Destination ooshutup10.cfg
    Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup10.cfg /quiet

    Write-Host "Disabling Telemetry..."
    $ResultText.text += "`r`n" +"Disabling Telemetry..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    Write-Host "Disabling Wi-Fi Sense..."
    If (!(Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
    Write-Host "Disabling Application suggestions..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    Write-Host "Disabling Activity History..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    # Keep Location Tracking commented out if you want the ability to locate your device
    Write-Host "Disabling Location Tracking..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    Write-Host "Disabling automatic Maps updates..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    Write-Host "Disabling Feedback..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-Host "Disabling Tailored Experiences..."
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    Write-Host "Disabling Advertising ID..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    Write-Host "Disabling Error reporting..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-Host "Restricting Windows Update P2P only to local network..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    Write-Host "Enabling F8 boot menu options..."
    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
    # Disabling Services
    Write-Host "Stopping and disabling Diagnostics Tracking Service..."
    Stop-Service "DiagTrack" -WarningAction SilentlyContinue
    Set-Service "DiagTrack" -StartupType Disabled
    Write-Host "Stopping and disabling Home Groups services..."
    Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
    Set-Service "HomeGroupListener" -StartupType Disabled
    Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
    Set-Service "HomeGroupProvider" -StartupType Disabled
    Write-Host "Disabling Remote Assistance..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
    Write-Host "Disabling Storage Sense..."
    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Stopping and disabling Superfetch service..."
    Stop-Service "SysMain" -WarningAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled
    Write-Host "Disabling Origin Services..."
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Origin Client Service" -Force
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Origin Web Helper Service" -Force
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Origin Client Service" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Origin Web Helper Service" -Name "Start" -Type DWord -Value 4
    Write-Host "Disabling Hibernation..."
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 0
    Write-Host "Showing task manager details..."
    $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
    Do {
        Start-Sleep -Milliseconds 100
        $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
    } Until ($preferences)
    Stop-Process $taskmgr
    $preferences.Preferences[28] = 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
    Write-Host "Showing file operations details..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
    Write-Host "Hiding Task View button..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    Write-Host "Hiding People icon..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
    Write-Host "Show tray icons..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
    Write-Host "Enabling NumLock after startup..."
    If (!(Test-Path "HKU:")) {
        New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
    }
    Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
    Add-Type -AssemblyName System.Windows.Forms
    If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('{NUMLOCK}')
    }

    Write-Host "Changing default Explorer view to This PC..."
    $ResultText.text += "`r`n" +"Quality of Life Tweaks"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    Write-Host "Hiding 3D Objects icon from This PC..."
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue

	# Network Tweaks
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20

    # Group svchost.exe processes
    $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force

    #Write-Host "Installing Windows Media Player..."
	#Enable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null

    Write-Host "Disable News and Interests"
    $ResultText.text += "`r`n" +"Disabling Extra Junk"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0
    # Remove "News and Interest" from taskbar
    Set-ItemProperty -Path  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2

    # remove "Meet Now" button from taskbar

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null
    }

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1

    Write-Host "Removing AutoLogger file and restricting directory..."
    $autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
    If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
        Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
    }
    icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null

    Write-Host "Showing known file extensions..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

    

    
    Write-Host "Disable Hibernate"
    powercfg -h off
    Write-Host "Import Power Plan"
    powercfg -import "C:\Windows\_BitsumHighestPerformance.pow" 77777777-7777-7777-7777-777777777777
    powercfg -SETACTIVE "77777777-7777-7777-7777-777777777777"
    powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 
    powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a
    Write-Host "Import Nvidia Settings"
    _nvidiaProfileInspector.exe "C:\Windows\_NvidiaBaseProfile.nip"
    Write-Host "Installing Timer Resolution Service"
    _SetTimerResolutionService.exe -install
    sc config STR start=auto
    net start STR
    Write-Host "Rebuild Performance Counter"
    lodctr /r
    lodctr /r


    # Chrome
    Write-Host "Tweaking Chrome..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "HardwareAccelerationModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BackgroundModeEnabled" -Type DWord -Value 0

    # Edge
    Write-Host "Tweaking Edge..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HardwareAccelerationModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "BackgroundModeEnabled" -Type DWord -Value 0

    # Store
    Write-Host "Disabling AutoUpdate in MS Store..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "AutoDownload" -Type DWord -Value 2

    # Start Menu
    Write-Host "Always hide most used list in start menu..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "ShowOrHideMostUsedApps" -Type DWord -Value 2
    Write-Host "Hide recently added apps..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
    Write-Host "Hide recently opened items in start, jump lists and file explorer..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 0

    # Explorer
    Write-Host "Hide frequent folders in quick access..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
    Write-Host "Disable Search histroy..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDeviceSearchHistoryEnabled" -Type DWord -Value 0
    Write-Host "Disable menu show delay..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value "0"
    Write-Host "Disable shortcut text..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "link" -Type Binary -Value 00,00,00,00
    Write-Host "Cleaning up File Explorer..."
    # Remove Desktop From This PC
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Force
    # Remove Documents From This PC
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Force
    # Remove Downloads From This PC
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Force
    # Remove Music From This PC
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Force
    # Remove Pictures From This PC
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Force
    # Remove Videos From This PC
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Force


    # Personalization
    Write-Host "Setting DPI to 100..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Type DWord -Value 96
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Win8DpiScaling" -Type DWord -Value 0
    Write-Host "Disable fix scaling for apps..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "EnablePerProcessSystemDPI" -Type DWord -Value 0
    New-Item -Path "HKCU:\Control Panel\Desktop\PerMonitorSettings\AUOD1ED0_22_07E3_A9^BA177C8FC0A6F9DFF117ED6F7C4E6DD7" -Force
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\PerMonitorSettings\AUOD1ED0_22_07E3_A9^BA177C8FC0A6F9DFF117ED6F7C4E6DD7" -Name "DpiValue" -Type DWord -Value 4294967295
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "AppliedDPI" -Type DWord -Value 96
    Write-Host "Disable Transparency..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 0
    Write-Host "Increase wallpaper quality..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Type DWord -Value 100
    Write-Host "Set search icon..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1

    # Sound
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Type DWord -Value 3
    
    # Mouse
    Write-Host "Turn off enhance pointer precision..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Type String -Value "0"

    # Autoruns
    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Force
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Force
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "ctfmon" -Type String -Value "C:\\Windows\\System32\\ctfmon.exe"
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree" -Force

    # Power Settings
    Write-Host "Disable Sleep..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowSleepOption" -Type DWord -Value 0
    Write-Host "Disable power throttling..."
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Force
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Type DWord -Value 1

    # Network throttling & system responsiveness
    Write-Host "Tweaking System..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Type DWord -Value 4294967295
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Type DWord -Value 0

    # Game scheduling
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Affinity" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Background Only" -Type String -Value "False"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Clock Rate" -Type DWord -Value 10000
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Type DWord -Value 8
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Type DWord -Value 6
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Type String -Value "High"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "SFIO Priority" -Type String -Value "High"

    # Turn on hardware accelerated gpu scheduling
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Type DWord -Value 2

    # Battery options optimize for video quality
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\VideoSettings" -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\VideoSettings" -Name "VideoQualityOnBattery" -Type DWord -Value 1

    # Adjust for best performance of programs
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Type DWord -Value 38

    # Game bar and game mode
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Name "UseNexusForGameBarEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Type DWord -Value 1

    # Search
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SafeSearchMode" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Type DWord -Value 0

    # Disable magnifier settings
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\ScreenMagnifier" -Name "FollowCaret" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\ScreenMagnifier" -Name "FollowNarrator" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\ScreenMagnifier" -Name "FollowMouse" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\ScreenMagnifier" -Name "FollowFocus" -Type DWord -Value 0

    # Disable narrator settings
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator" -Name "IntonationPause" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator" -Name "ReadHints" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator" -Name "ErrorNotificationType" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator" -Name "EchoChars" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator" -Name "EchoWords" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator\NarratorHome" -Name "MinimizeType" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator\NarratorHome" -Name "AutoStart" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator\NoRoam" -Name "EchoToggleKeys" -Type DWord -Value 0

    # EASE OF ACCESS
    # Disable narrator
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator\NoRoam" -Name "DuckAudio" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator\NoRoam" -Name "WinEnterLaunchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator\NoRoam" -Name "ScriptingEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator\NoRoam" -Name "OnlineServicesEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator" -Name "NarratorCursorHighlight" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Narrator" -Name "CoupleNarratorCursorKeyboard" -Type DWord -Value 0

    # Disable ease of access settings 
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Ease of Access" -Name "selfvoice" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Ease of Access" -Name "selfscan" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Sound on Activation" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Warning Sounds" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\HighContrast" -Name "Flags" -Type String -Value "4194"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Type String -Value "2"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatRate" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatDelay" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "Flags" -Type String -Value "130"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "MaximumSpeed" -Type String -Value "39"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "TimeToMaximumSpeed" -Type String -Value "3000"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "2"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Type String -Value "34"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "Flags" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "FSTextEffect" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "TextEffect" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "WindowsEffect" -Type String -Value "0"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "ATapp" -Type String -Value ""
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "LaunchAT" -Type DWord -Value 0

    # Disable automatic maintenance
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Type DWord -Value 1

    # Disable use my sign in info after restart
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableAutomaticRestartSignOn" -Type DWord -Value 1

    # Disable automatically update maps
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

    # Alt tab open windows only
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Type DWord -Value 3

    <#
    # Transfer user files
    New-Item -Path "C:\Users\*\AppData\Roaming\" -Name "discord" -ItemType "directory" -ErrorAction SilentlyContinue
    New-Item -Path "C:\Users\*\AppData\Roaming\" -Name "Notepad++" -ItemType "directory" -ErrorAction SilentlyContinue
    New-Item -Path "C:\Users\*\AppData\Roaming\" -Name "Spotify" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/sevurd/Sevurd-Toolbox/main/discord/settings.json" -Destination 'C:\Users\*\AppData\Roaming\discord\settings.json'
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/sevurd/Sevurd-Toolbox/main/Notepad%2B%2B/config.xml" -Destination 'C:\Users\*\AppData\Roaming\Notepad++\config.xml'
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/sevurd/Sevurd-Toolbox/main/Spotify/prefs" -Destination 'C:\Users\*\AppData\Roaming\Spotify\prefs'
    #>

    # Service tweaks to Manual 

    $services = @(
    "diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
    #"DiagTrack"                                    # Diagnostics Tracking Service
    #"DPS"
    #"dmwappushservice"                             # WAP Push Message Routing Service (see known issues)
    #"lfsvc"                                        # Geolocation Service
    "MapsBroker"                                   # Downloaded Maps Manager
    "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
    "RemoteAccess"                                 # Routing and Remote Access
    "RemoteRegistry"                               # Remote Registry
    "SharedAccess"                                 # Internet Connection Sharing (ICS)
    "TrkWks"                                       # Distributed Link Tracking Client
    "WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
    #"WlanSvc"                                      # WLAN AutoConfig
    "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
    #"wscsvc"                                       # Windows Security Center Service
    "ndu"                                          # Windows Network Data Usage Monitor
    "WerSvc"                                       #disables windows error reporting
    "Spooler"                                      #Disables your printer
    "Fax"                                          #Disables fax
    "fhsvc"                                        #Disables fax histroy
    "stisvc"                                       #Disables Windows Image Acquisition (WIA)
    "AJRouter"                                     #Disables (needed for AllJoyn Router Service)
    "MSDTC"                                        # Disables Distributed Transaction Coordinator
    "WpcMonSvc"                                    #Disables Parental Controls
    "PhoneSvc"                                     #Disables Phone Service(Manages the telephony state on the device)
    "PrintNotify"                                  #Disables Windows printer notifications and extentions
    "PcaSvc"                                       #Disables Program Compatibility Assistant Service
    "RmSvc"
    "WPDBusEnum"                                   #Disables Portable Device Enumerator Service
    #"LicenseManager"                               #Disable LicenseManager(Windows store may not work properly)
    "seclogon"                                     #Disables  Secondary Logon(disables other credentials only password will work)
    #"SysMain"                                      #Disables sysmain
    "lmhosts"                                      #Disables TCP/IP NetBIOS Helper
    "wisvc"                                        #Disables Windows Insider program(Windows Insider will not work)
    "FontCache"                                    #Disables Windows font cache
    "RetailDemo"                                   #Disables RetailDemo whic is often used when showing your device
    "ALG"                                          # Disables Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
    #"BFE"                                         #Disables Base Filtering Engine (BFE) (is a service that manages firewall and Internet Protocol security)
    #"BrokerInfrastructure"                         #Disables Windows infrastructure service that controls which background tasks can run on the system.
    "SCardSvr"                                      #Disables Windows smart card
    "EntAppSvc"                                     #Disables enterprise application management.
    "BthAvctpSvc"                                   #Disables AVCTP service (if you use  Bluetooth Audio Device or Wireless Headphones. then don't disable this)
    #"FrameServer"                                   #Disables Windows Camera Frame Server(this allows multiple clients to access video frames from camera devices.)
    "Browser"                                       #Disables computer browser
    "BthAvctpSvc"                                   #AVCTP service (This is Audio Video Control Transport Protocol service.)
    #"BDESVC"                                        #Disables bitlocker
    "iphlpsvc"                                      #Disables ipv6 but most websites don't use ipv6 they use ipv4                             
    "SEMgrSvc"                                      #Disables Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
    #"PNRPsvc"                                      # Disables peer Name Resolution Protocol ( some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
    #"p2psvc"                                       # Disbales Peer Name Resolution Protocol(nables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)
    #"p2pimsvc"                                     # Disables Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly.Discord will still work)
    "PerfHost"                                      #Disables  remote users and 64-bit processes to query performance .
    "BcastDVRUserService_48486de"                   #Disables GameDVR and Broadcast   is used for Game Recordings and Live Broadcasts
    #"CaptureService_48486de"                        #Disables ptional screen capture functionality for applications that call the Windows.Graphics.Capture API.  
    #"cbdhsvc_48486de"                               #Disables   cbdhsvc_48486de (clipboard service it disables)
    #"BluetoothUserService_48486de"                  #disbales BluetoothUserService_48486de (The Bluetooth user service supports proper functionality of Bluetooth features relevant to each user session.)
    #"StorSvc"                                       #Disables StorSvc (usb external hard drive will not be reconised by windows)
    "RtkBtManServ"                                  #Disables Realtek Bluetooth Device Manager Service
    "QWAVE"                                         #Disables Quality Windows Audio Video Experience (audio and video might sound worse)
    #Hp services
    "gupdate"                                      #Disables google update
    "gupdatem"                                     #Disable another google update
    "HPAppHelperCap"
    "HPDiagsCap"
    "HPNetworkCap"
    "HPSysInfoCap"
    "HpTouchpointAnalyticsService"
    #hyper-v services
    "HvHost"                          
    "vmickvpexchange"
    "vmicguestinterface"
    "vmicshutdown"
    "vmicheartbeat"
    "vmicvmsession"
    "vmicrdv"
    "vmictimesync" 
    # Services which cannot be disabled
    #"WdNisSvc"
)

foreach ($service in $services) {
    # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

    Write-Host "Setting $service StartupType to Manual"
    Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
}

    # Sevice tweaks to Disabled

    $services = @(
    "DPS"
    "dmwappushservice"
    "edgeupdate"                                    # Disables one of edge update service  
    "MicrosoftEdgeElevationService"                 # Disables one of edge  service 
    "edgeupdatem"                                  # disbales another one of update service (disables edgeupdatem)
    "GoogleChromeElevationService"
    "lfsvc"
    "WpnService"                                    #Disables WpnService (Push Notifications may not work )
    "XblAuthManager"                               # Xbox Live Auth Manager
    "XblGameSave"                                  # Xbox Live Game Save Service
    "XboxNetApiSvc"                                # Xbox Live Networking Service
    "XboxGipSvc"                                   #Disables Xbox Accessory Management Service
    "WSearch"                                      # Windows Search

)

foreach ($service in $services) {
    # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

    Write-Host "Setting $service StartupType to Disabled"
    Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
}

    Write-Host "Essential Tweaks Completed - Please Reboot"
    $ResultText.text = "`r`n" + "Essential Tweaks Done" + "`r`n" + "`r`n" + "Ready for Next Task"
    
    Add-Type -AssemblyName System.Windows.Forms
    $msgBoxInput =  [System.Windows.Forms.MessageBox]::Show('Click OK to restart the pc.','Restart','OK')
    switch  ($msgBoxInput) {
        'OK' {

        C:\Windows\System32\shutdown.exe /r /t 0

        }
    }
})

$cleanup.Add_Click({
    Write-Host "Cleaning up windows"
    $ResultText.text = "`r`n" + "`r`n" + "Cleaning up windows...Please wait"
    Remove-Item -Path $env:TEMP\* -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path $env:windir\Temp\* -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path $env:windir\Prefetch\* -Recurse -ErrorAction SilentlyContinue
    cleanmgr /sageset:1 | Out-Null
    cleanmgr /sagerun:1 | Out-Null
    Write-Host "Cleaned up windows"
    $ResultText.text = "`r`n" + "Cleaned up windows" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$dualboottime.Add_Click({
    Write-Host "Setting BIOS time to UTC..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
    $ResultText.text = "`r`n" + "Time set to UTC for consistent time in Dual Boot Systems" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$laptopnumlock.Add_Click({
    Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 0
    Add-Type -AssemblyName System.Windows.Forms
    If (([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('{NUMLOCK}')
    }
})

$windowssearch.Add_Click({
    Write-Host "Disabling Bing Search in Start Menu..."
    $ResultText.text = "`r`n" +"`r`n" + "Disabling Search, Cortana, Start menu search... Please Wait"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
    <#
    Write-Host "Disabling Cortana"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    #>
    Write-Host "Hiding Search Box / Button..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

    Write-Host "Removing Start Menu Tiles"

    Set-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -Value '<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  <LayoutOptions StartTileGroupCellWidth="6" />'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  <DefaultLayoutOverride>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    <StartLayoutCollection>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      <defaultlayout:StartLayout GroupCellWidth="6" />'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    </StartLayoutCollection>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  </DefaultLayoutOverride>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    <CustomTaskbarLayoutCollection>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      <defaultlayout:TaskbarLayout>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '        <taskbar:TaskbarPinList>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '          <taskbar:UWA AppUserModelID="Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" />'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '          <taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '        </taskbar:TaskbarPinList>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      </defaultlayout:TaskbarLayout>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    </CustomTaskbarLayoutCollection>'
    Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '</LayoutModificationTemplate>'

    $START_MENU_LAYOUT = @"
    <LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
        <LayoutOptions StartTileGroupCellWidth="6" />
        <DefaultLayoutOverride>
            <StartLayoutCollection>
                <defaultlayout:StartLayout GroupCellWidth="6" />
            </StartLayoutCollection>
        </DefaultLayoutOverride>
    </LayoutModificationTemplate>
"@

    $layoutFile="C:\Windows\StartMenuLayout.xml"

    #Delete layout file if it already exists
    If(Test-Path $layoutFile)
    {
        Remove-Item $layoutFile
    }

    #Creates the blank layout file
    $START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII

    $regAliases = @("HKLM", "HKCU")

    #Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer"
        IF(!(Test-Path -Path $keyPath)) {
            New-Item -Path $basePath -Name "Explorer"
        }
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
        Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
    }

    #Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
    Stop-Process -name explorer
    Start-Sleep -s 5
    $wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
    Start-Sleep -s 5

    #Enable the ability to pin items again by disabling "LockedStartLayout"
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer"
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0

    Write-Host "Search and Start Menu Tweaks Complete"
    $ResultText.text = "`r`n" +"`r`n" + "Search and Start Menu Tweaks Complete"
    }
})

$backgroundapps.Add_Click({
    Write-Host "Disabling Background application access..."
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
        Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
        Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
    }
    Write-Host "Disabled Background application access"
    $ResultText.text = "`r`n" +"`r`n" + "Disabled Background application access"
})

$cortana.Add_Click({
    Write-Host "Disabling Cortana..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
    Write-Host "Disabled Cortana"
    $ResultText.text = "`r`n" +"`r`n" + "Disabled Cortana"
})

$Bloatware = @(
    #Unnecessary Windows 10 AppX Apps
    "Microsoft.3DBuilder"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.AppConnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.MinecraftUWP"
    "Microsoft.GamingServices"
    # "Microsoft.WindowsReadingList"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.Sway"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.OneDriveSync"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "MicrosoftTeams"
    "Microsoft.Todos"
    "Microsoft.Wallet"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCamera"
    "Microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.XboxApp"
    "Microsoft.ConnectivityStore"
    "Microsoft.CommsPhone"
    "Microsoft.ScreenSketch"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
	"Microsoft.XboxGamingOverlay"
    "Microsoft.XboxGameCallableUI"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MixedReality.Portal"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.YourPhone"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "MicrosoftWindows.Client.WebExperience"
	"Disney.37853FC22B2CE"
    "SpotifyAB.SpotifyMusic"
	"Microsoft.549981C3F5F10"
	
	

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Duolingo-LearnLanguagesforFree*"
    "*PandoraMediaInc*"
    "*CandyCrush*"
    "*BubbleWitch3Saga*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"
    "*Royal Revolt*"
    "*Sway*"
    "*Speed Test*"
    "*Dolby*"
    "*Viber*"
    "*ACGMediaPlayer*"
    "*Netflix*"
    "*OneCalendar*"
    "*LinkedInforWindows*"
    "*HiddenCityMysteryofShadows*"
    "*Hulu*"
    "*HiddenCity*"
    "*AdobePhotoshopExpress*"
    "*HotspotShieldFreeVPN*"

    #Optional: Typically not removed but you can if you need to for some reason
    "*Microsoft.Advertising.Xaml*"
    "*Microsoft.MSPaint*"
    "*Microsoft.MicrosoftStickyNotes*"
    #"*Microsoft.Windows.Photos*"
    #"*Microsoft.WindowsCalculator*"
    #"*Microsoft.WindowsStore*"
)

$removebloat.Add_Click({
    Write-Host "Removing Bloatware"

    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
        Write-Host "Trying to remove $Bloat."
        $ResultText.text = "`r`n" +"`r`n" + "Trying to remove $Bloat."
    }

    Write-Host "Finished Removing Bloatware Apps"
    $ResultText.text = "`r`n" +"`r`n" + "Finished Removing Bloatware Apps"
})

$reinstallbloat.Add_Click({
    Write-Host "Reinstalling Bloatware"

    foreach ($app in $Bloatware) {
        Write-Output "Trying to add $app"
        $ResultText.text = "`r`n" +"`r`n" + "Trying to add $app"
        Add-AppxPackage -DisableDevelopmentMode -Register "$($(Get-AppxPackage -AllUsers $app).InstallLocation)\AppXManifest.xml"
    }

    Write-Host "Finished Reinstalling Bloatware Apps"
    $ResultText.text = "`r`n" +"`r`n" + "Finished Reinstalling Bloatware Apps"
})

$defaultwindowsupdate.Add_Click({
    Write-Host "Enabling driver offering through Windows Update..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -ErrorAction SilentlyContinue
    Write-Host "Enabling Windows Update automatic restart..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue
    Write-Host "Enabled driver offering through Windows Update"
    $ResultText.text = "`r`n" +"`r`n" + "Set Windows Updates to Stock Settings"
})

$securitywindowsupdate.Add_Click({
    Write-Host "Disabling driver offering through Windows Update..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabling Windows Update automatic restart..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Disabled driver offering through Windows Update"
    $ResultText.text = "`r`n" +"`r`n" + "Set Windows Update to Sane Settings"
})

$actioncenter.Add_Click({
    Write-Host "Disabling Action Center and Notifications..."
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Name "Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" -Name "Enabled" -Type DWord -Value 0
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess" -Name "Enabled" -Type DWord -Value 0
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp" -Name "Enabled" -Type DWord -Value 0
    Write-Host "Disabled Action Center and Notifications"
    $ResultText.text = "`r`n" +"`r`n" + "Disabled Action Center and Notifications" +"`r`n" + "Restart to take effect"
})

$performancefx.Add_Click({
    Write-Host "Adjusting visual effects for performance..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
    Write-Host "Adjusted visual effects for performance"
    $ResultText.text = "`r`n" +"`r`n" + "Adjusted VFX for performance"
})

$appearancefx.Add_Click({
	Write-Output "Adjusting visual effects for appearance..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 0
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](158,30,7,128,18,0,0,0))
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
    $ResultText.text = "`r`n" +"`r`n" + "Visual effects are set for appearance (Defaults)"
})

$onedrive.Add_Click({
    Write-Host "Disabling OneDrive..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
    Write-Host "Uninstalling OneDrive..."
    Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    If (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
    Start-Sleep -s 2
    Stop-Process -Name "explorer" -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
    If (!(Test-Path "HKCR:")) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Disabled OneDrive"
    $ResultText.text = "`r`n" +"`r`n" + "Deleted and Disabled OneDrive"
})

$darkmode.Add_Click({
    Write-Host "Enabling Dark Mode"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
    Write-Host "Enabled Dark Mode"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Dark Mode"
})

$lightmode.Add_Click({
    Write-Host "Switching Back to Light Mode"
    Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme
    Write-Host "Switched Back to Light Mode"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Light Mode"
})

$EActionCenter.Add_Click({
    Write-Host "Enabling Action Center and Notifications..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Name "Enabled" -Type DWord -Value 0
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" -Name "Enabled" -Type DWord -Value 0
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess" -Name "Enabled" -Type DWord -Value 0
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp" -Name "Enabled" -Type DWord -Value 0
	Write-Host "Done - Reverted to Stock Settings"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Action Center and Notifications" +"`r`n" + "Restart to take effect"
})

$ECortana.Add_Click({
    Write-Host "Enabling Cortana..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -ErrorAction SilentlyContinue
	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
		New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 0
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -ErrorAction SilentlyContinue
	Write-Host "Restoring Windows Search..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value "1"
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -ErrorAction SilentlyContinue
	Write-Host "Restore and Starting Windows Search Service..."
    Set-Service "WSearch" -StartupType Automatic
    Start-Service "WSearch" -WarningAction SilentlyContinue
    Write-Host "Restore Windows Search Icon..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
	Write-Host "Done - Reverted to Stock Settings"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Cortana and Restored Search"
})

$HTrayIcons.Add_Click({

	Write-Host "Hiding tray icons..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 1
	Write-Host "Done - Hid Tray Icons"
    $ResultText.text = "`r`n" +"`r`n" + "Tray icons are now factory defaults"
})


$STrayIcons.Add_Click({

	Write-Host "Showing tray icons..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
	Write-Host "Done - Now showing all tray icons"
    $ResultText.text = "`r`n" +"`r`n" + "Tray Icons now set to show all"
})

$EClipboardHistory.Add_Click({
	Write-Host "Restoring Clipboard History..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Clipboard" -Name "EnableClipboardHistory" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "AllowClipboardHistory" -ErrorAction SilentlyContinue
	Write-Host "Done - Reverted to Stock Settings"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Clipboard History"
})

$ELocation.Add_Click({
	Write-Host "Enabling Location Provider..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableWindowsLocationProvider" -ErrorAction SilentlyContinue
	Write-Host "Enabling Location Scripting..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -ErrorAction SilentlyContinue
	Write-Host "Enabling Location..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "Value" -Type String -Value "Allow"
	Write-Host "Allow access to Location..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Allow"
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value "1"
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation_UserInControlOfTheseApps" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation_ForceAllowTheseApps" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation_ForceDenyTheseApps" -ErrorAction SilentlyContinue
	Write-Host "Done - Reverted to Stock Settings"
    $ResultText.text = "`r`n" +"`r`n" + "Location Tracking now on... Reboot to check."
})

$RBackgroundApps.Add_Click({
	Write-Host "Allowing Background Apps..."
	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
		Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
		Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
	}
	Write-Host "Done - Reverted to Stock Settings"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Background Apps"
})

$EHibernation.Add_Click({
    Write-Host "Enabling Hibernation"
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 1
    Write-Host "Done - Reverted to Stock Settings"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Hibernation"
})

$InstallOneDrive.Add_Click({
    Write-Host "Installing Onedrive. Please Wait..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -ErrorAction SilentlyContinue
    %systemroot%\SysWOW64\OneDriveSetup.exe
    $ResultText.text = "`r`n" +"`r`n" + "Finished Reinstalling OneDrive"
})

$DisableNumLock.Add_Click({
    Write-Host "Disable NumLock after startup..."
    Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 0
    Add-Type -AssemblyName System.Windows.Forms
    If (([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('{NUMLOCK}')
    }
    $ResultText.text = "`r`n" +"`r`n" + "NUMLOCK Disabled"
})

$yourphonefix.Add_Click({
    Write-Host "Reinstalling Your Phone App"
    Add-AppxPackage -DisableDevelopmentMode -Register "$($(Get-AppXPackage -AllUsers "Microsoft.YourPhone").InstallLocation)\AppXManifest.xml"
    Write-Host "Enable needed data collection for Your Phone..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableMmx" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableCdp" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Messaging" -Name "AllowMessageSync" -Type DWord -Value 1
    Write-Host "Allowing Background Apps..."
	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
		Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
		Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
	}
    Write-Host "You may need to Reboot and right-click Your Phone app and select repair"
    $ResultText.text = "`r`n" +"`r`n" + "You may need to Reboot and right-click Your Phone app and select repair"
})

$ncpa.Add_Click({
    cmd /c ncpa.cpl
})
$oldsoundpanel.Add_Click({
    cmd /c mmsys.cpl
})
$oldcontrolpanel.Add_Click({
    cmd /c control
})
$oldsystempanel.Add_Click({
    cmd /c sysdm.cpl
})
$oldpower.Add_Click({
    cmd /c powercfg.cpl
})
$restorepower.Add_Click({
    powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    Write-Host "Restored all power plans: Balanced, High Performance, and Power Saver"
    $ResultText.text = "`r`n" +"`r`n" + "Restored all power plans: Balanced, High Performance, and Power Saver"
})
$NFS.Add_Click({
    Enable-WindowsOptionalFeature -Online -FeatureName "ServicesForNFS-ClientOnly" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "ClientForNFS-Infrastructure" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "NFS-Administration" -All
    nfsadmin client stop
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUID" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGID" -Type DWord -Value 0
    nfsadmin client start
    nfsadmin client localhost config fileaccess=755 SecFlavors=+sys -krb5 -krb5i
    Write-Host "NFS is now setup for user based NFS mounts"
    $ResultText.text = "`r`n" +"`r`n" + "NFS is now setup for user based NFS mounts"
})

$Virtualization.Add_Click({
    Enable-WindowsOptionalFeature -Online -FeatureName "HypervisorPlatform" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Tools-All" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-PowerShell" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Hypervisor" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Services" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-Clients" -All
    cmd /c bcdedit /set hypervisorschedulertype classic
    Write-Host "HyperV is now installed and configured. Please Reboot before using."
    $ResultText.text = "`r`n" +"`r`n" + "HyperV is now installed and configured. Please Reboot before using."
})

$windowsupdatefix.Add_Click({
    Write-Host "1. Stopping Windows Update Services..." 
    Stop-Service -Name BITS 
    Stop-Service -Name wuauserv 
    Stop-Service -Name appidsvc 
    Stop-Service -Name cryptsvc 
    
    Write-Host "2. Remove QMGR Data file..." 
    Remove-Item "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue 
    
    Write-Host "3. Renaming the Software Distribution and CatRoot Folder..." 
    Rename-Item $env:systemroot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue 
    Rename-Item $env:systemroot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue 
    
    Write-Host "4. Removing old Windows Update log..." 
    Remove-Item $env:systemroot\WindowsUpdate.log -ErrorAction SilentlyContinue 
    
    Write-Host "5. Resetting the Windows Update Services to defualt settings..." 
    "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    
    Set-Location $env:systemroot\system32 
    
    Write-Host "6. Registering some DLLs..." 
    regsvr32.exe /s atl.dll 
    regsvr32.exe /s urlmon.dll 
    regsvr32.exe /s mshtml.dll 
    regsvr32.exe /s shdocvw.dll 
    regsvr32.exe /s browseui.dll 
    regsvr32.exe /s jscript.dll 
    regsvr32.exe /s vbscript.dll 
    regsvr32.exe /s scrrun.dll 
    regsvr32.exe /s msxml.dll 
    regsvr32.exe /s msxml3.dll 
    regsvr32.exe /s msxml6.dll 
    regsvr32.exe /s actxprxy.dll 
    regsvr32.exe /s softpub.dll 
    regsvr32.exe /s wintrust.dll 
    regsvr32.exe /s dssenh.dll 
    regsvr32.exe /s rsaenh.dll 
    regsvr32.exe /s gpkcsp.dll 
    regsvr32.exe /s sccbase.dll 
    regsvr32.exe /s slbcsp.dll 
    regsvr32.exe /s cryptdlg.dll 
    regsvr32.exe /s oleaut32.dll 
    regsvr32.exe /s ole32.dll 
    regsvr32.exe /s shell32.dll 
    regsvr32.exe /s initpki.dll 
    regsvr32.exe /s wuapi.dll 
    regsvr32.exe /s wuaueng.dll 
    regsvr32.exe /s wuaueng1.dll 
    regsvr32.exe /s wucltui.dll 
    regsvr32.exe /s wups.dll 
    regsvr32.exe /s wups2.dll 
    regsvr32.exe /s wuweb.dll 
    regsvr32.exe /s qmgr.dll 
    regsvr32.exe /s qmgrprxy.dll 
    regsvr32.exe /s wucltux.dll 
    regsvr32.exe /s muweb.dll 
    regsvr32.exe /s wuwebv.dll 
    
    Write-Host "7) Removing WSUS client settings..." 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f 
    
    Write-Host "8) Resetting the WinSock..." 
    netsh winsock reset 
    netsh winhttp reset proxy 
    
    Write-Host "9) Delete all BITS jobs..." 
    Get-BitsTransfer | Remove-BitsTransfer 
    
    Write-Host "10) Attempting to install the Windows Update Agent..." 
    if($arch -eq 64){ 
        wusa Windows8-RT-KB2937636-x64 /quiet 
    } 
    else{ 
        wusa Windows8-RT-KB2937636-x86 /quiet 
    } 
    
    Write-Host "11) Starting Windows Update Services..." 
    Start-Service -Name BITS 
    Start-Service -Name wuauserv 
    Start-Service -Name appidsvc 
    Start-Service -Name cryptsvc 
    
    Write-Host "12) Forcing discovery..." 
    wuauclt /resetauthorization /detectnow 
    
    Write-Host "Process complete. Please reboot your computer."
    $ResultText.text = "`r`n" +"`r`n" + "Process complete. Please reboot your computer."

})

$disableupdates.Add_Click({

    # Source: https://github.com/rgl/windows-vagrant/blob/master/disable-windows-updates.ps1
    Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host
    Write-Host "ERROR: $_"
    Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
    Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
    Write-Host
    Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    Start-Sleep -Seconds (60*60)
    Exit 1
}

# disable automatic updates.
# XXX this does not seem to work anymore.
# see How to configure automatic updates by using Group Policy or registry settings
#     at https://support.microsoft.com/en-us/help/328010
function New-Directory($path) {
    $p, $components = $path -split '[\\/]'
    $components | ForEach-Object {
        $p = "$p\$_"
        if (!(Test-Path $p)) {
            New-Item -ItemType Directory $p | Out-Null
        }
    }
    $null
}
$auPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
New-Directory $auPath 
# set NoAutoUpdate.
# 0: Automatic Updates is enabled (default).
# 1: Automatic Updates is disabled.
New-ItemProperty `
    -Path $auPath `
    -Name NoAutoUpdate `
    -Value 1 `
    -PropertyType DWORD `
    -Force `
    | Out-Null
# set AUOptions.
# 1: Keep my computer up to date has been disabled in Automatic Updates.
# 2: Notify of download and installation.
# 3: Automatically download and notify of installation.
# 4: Automatically download and scheduled installation.
New-ItemProperty `
    -Path $auPath `
    -Name AUOptions `
    -Value 1 `
    -PropertyType DWORD `
    -Force `
    | Out-Null

# disable Windows Update Delivery Optimization.
# NB this applies to Windows 10.
# 0: Disabled
# 1: PCs on my local network
# 3: PCs on my local network, and PCs on the Internet
$deliveryOptimizationPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config'
if (Test-Path $deliveryOptimizationPath) {
    New-ItemProperty `
        -Path $deliveryOptimizationPath `
        -Name DODownloadMode `
        -Value 0 `
        -PropertyType DWORD `
        -Force `
        | Out-Null
}
# Service tweaks for Windows Update

$services = @(
    "BITS"
    "wuauserv"
)

foreach ($service in $services) {
    # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

    Write-Host "Setting $service StartupType to Disabled"
    Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
}
})

$enableupdates.Add_Click({

    # Source: https://github.com/rgl/windows-vagrant/blob/master/disable-windows-updates.ps1
    Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host
    Write-Host "ERROR: $_"
    Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
    Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
    Write-Host
    Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    Start-Sleep -Seconds (60*60)
    Exit 1
}

# disable automatic updates.
# XXX this does not seem to work anymore.
# see How to configure automatic updates by using Group Policy or registry settings
#     at https://support.microsoft.com/en-us/help/328010
function New-Directory($path) {
    $p, $components = $path -split '[\\/]'
    $components | ForEach-Object {
        $p = "$p\$_"
        if (!(Test-Path $p)) {
            New-Item -ItemType Directory $p | Out-Null
        }
    }
    $null
}
$auPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
New-Directory $auPath 
# set NoAutoUpdate.
# 0: Automatic Updates is enabled (default).
# 1: Automatic Updates is disabled.
New-ItemProperty `
    -Path $auPath `
    -Name NoAutoUpdate `
    -Value 0 `
    -PropertyType DWORD `
    -Force `
    | Out-Null
# set AUOptions.
# 1: Keep my computer up to date has been disabled in Automatic Updates.
# 2: Notify of download and installation.
# 3: Automatically download and notify of installation.
# 4: Automatically download and scheduled installation.
New-ItemProperty `
    -Path $auPath `
    -Name AUOptions `
    -Value 3 `
    -PropertyType DWORD `
    -Force `
    | Out-Null

# disable Windows Update Delivery Optimization.
# NB this applies to Windows 10.
# 0: Disabled
# 1: PCs on my local network
# 3: PCs on my local network, and PCs on the Internet
$deliveryOptimizationPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config'
if (Test-Path $deliveryOptimizationPath) {
    New-ItemProperty `
        -Path $deliveryOptimizationPath `
        -Name DODownloadMode `
        -Value 0 `
        -PropertyType DWORD `
        -Force `
        | Out-Null
}
# Service tweaks for Windows Update

$services = @(
    "BITS"
    "wuauserv"
)

foreach ($service in $services) {
    # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

    Write-Host "Setting $service StartupType to Automatic"
    Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Automatic
}
})

[void]$Form.ShowDialog()
