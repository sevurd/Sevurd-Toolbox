Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

Write-Host "Creating shortcut on Desktop..."
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Sevurd Toolbox.lnk")
$Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$Shortcut.Arguments = "iwr -useb https://bit.ly/sevurd-toolbox | iex"
$Shortcut.Save()
Write-Host "Creating folder in C drive..."
New-Item -Path "C:\" -Name "Sevurd Toolbox" -ItemType "directory" -ErrorAction SilentlyContinue

$Form                         = New-Object system.Windows.Forms.Form
$Form.ClientSize              = New-Object System.Drawing.Point(1050,1000)
$Form.text                    = "Sevurd Toolbox"
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
$nvidia.text                     = "Nvidia Display Driver"
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
$Label3.text                     = "Optimization"
$Label3.AutoSize                 = $true
$Label3.width                    = 230
$Label3.height                   = 25
$Label3.location                 = New-Object System.Drawing.Point(249,11)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$win10tweaks                     = New-Object System.Windows.Forms.Button
$win10tweaks.text                = "Windows 10 Tweaks"
$win10tweaks.width               = 205
$win10tweaks.height              = 45
$win10tweaks.location            = New-Object System.Drawing.Point(3,29)
$win10tweaks.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',14)
$win10tweaks.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#FF0000")

$win11tweaks                     = New-Object System.Windows.Forms.Button
$win11tweaks.text                = "Windows 11 Tweaks"
$win11tweaks.width               = 205
$win11tweaks.height              = 45
$win11tweaks.location            = New-Object System.Drawing.Point(3,80)
$win11tweaks.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',14)
$win11tweaks.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#FF0000")

$removebloat                     = New-Object system.Windows.Forms.Button
$removebloat.text                = "Remove Bloatware"
$removebloat.width               = 205
$removebloat.height              = 45
$removebloat.location            = New-Object System.Drawing.Point(3,130)
$removebloat.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',14)
$removebloat.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#00FF00")

$cleanup                         = New-Object system.Windows.Forms.Button
$cleanup.text                    = "Cleanup Windows"
$cleanup.width                   = 205
$cleanup.height                  = 45
$cleanup.location                = New-Object System.Drawing.Point(3,180)
$cleanup.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',14)
$cleanup.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#00FFFF")

$onedrive                        = New-Object system.Windows.Forms.Button
$onedrive.text                   = "Uninstall OneDrive"
$onedrive.width                  = 205
$onedrive.height                 = 30
$onedrive.location               = New-Object System.Drawing.Point(3,230)
$onedrive.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$DDefender                       = New-Object system.Windows.Forms.Button
$DDefender.text                  = "Disable Defender"
$DDefender.width                 = 205
$DDefender.height                = 30
$DDefender.location              = New-Object System.Drawing.Point(3,265)
$DDefender.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$EDefender                       = New-Object system.Windows.Forms.Button
$EDefender.text                  = "Enable Defender"
$EDefender.width                 = 205
$EDefender.height                = 30
$EDefender.location              = New-Object System.Drawing.Point(3,300)
$EDefender.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$actioncenter                    = New-Object system.Windows.Forms.Button
$actioncenter.text               = "Disable Action Center"
$actioncenter.width              = 205
$actioncenter.height             = 30
$actioncenter.location           = New-Object System.Drawing.Point(3,335)
$actioncenter.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$EActionCenter                   = New-Object system.Windows.Forms.Button
$EActionCenter.text              = "Enable Action Center"
$EActionCenter.width             = 205
$EActionCenter.height            = 30
$EActionCenter.location          = New-Object System.Drawing.Point(3,370)
$EActionCenter.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$STrayIcons                      = New-Object System.Windows.Forms.Button
$STrayIcons.text                 = "Show Tray Icons"
$STrayIcons.width                = 205
$STrayIcons.height               = 30
$STrayIcons.location             = New-Object System.Drawing.Point(3,405)
$STrayIcons.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$HTrayIcons                      = New-Object system.Windows.Forms.Button
$HTrayIcons.text                 = "Hide Tray Icons"
$HTrayIcons.width                = 205
$HTrayIcons.height               = 30
$HTrayIcons.location             = New-Object System.Drawing.Point(3,440)
$HTrayIcons.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$darkmode                        = New-Object system.Windows.Forms.Button
$darkmode.text                   = "Dark Mode"
$darkmode.width                  = 205
$darkmode.height                 = 30
$darkmode.location               = New-Object System.Drawing.Point(3,475)
$darkmode.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$lightmode                       = New-Object system.Windows.Forms.Button
$lightmode.text                  = "Light Mode"
$lightmode.width                 = 205
$lightmode.height                = 30
$lightmode.location              = New-Object System.Drawing.Point(3,510)
$lightmode.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$appearancefx                    = New-Object system.Windows.Forms.Button
$appearancefx.text               = "Appearance Visual FX"
$appearancefx.width              = 205
$appearancefx.height             = 30
$appearancefx.location           = New-Object System.Drawing.Point(3,545)
$appearancefx.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$performancefx                   = New-Object system.Windows.Forms.Button
$performancefx.text              = "Performance Visual FX"
$performancefx.width             = 205
$performancefx.height            = 30
$performancefx.location          = New-Object System.Drawing.Point(3,580)
$performancefx.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$backgroundapps                  = New-Object system.Windows.Forms.Button
$backgroundapps.text             = "Disable Background Apps"
$backgroundapps.width            = 205
$backgroundapps.height           = 30
$backgroundapps.location         = New-Object System.Drawing.Point(3,615)
$backgroundapps.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$RBackgroundApps                 = New-Object system.Windows.Forms.Button
$RBackgroundApps.text            = "Allow Background Apps"
$RBackgroundApps.width           = 205
$RBackgroundApps.height          = 30
$RBackgroundApps.location        = New-Object System.Drawing.Point(3,650)
$RBackgroundApps.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$cortana                         = New-Object system.Windows.Forms.Button
$cortana.text                    = "Disable Cortana (Search)"
$cortana.width                   = 205
$cortana.height                  = 30
$cortana.location                = New-Object System.Drawing.Point(3,685)
$cortana.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ECortana                        = New-Object system.Windows.Forms.Button
$ECortana.text                   = "Enable Cortana (Search)"
$ECortana.width                  = 205
$ECortana.height                 = 30
$ECortana.location               = New-Object System.Drawing.Point(3,720)
$ECortana.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$laptopnumlock                   = New-Object system.Windows.Forms.Button
$laptopnumlock.text              = "Laptop Numlock Fix"
$laptopnumlock.width             = 205
$laptopnumlock.height            = 30
$laptopnumlock.location          = New-Object System.Drawing.Point(3,755)
$laptopnumlock.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$yourphonefix                    = New-Object system.Windows.Forms.Button
$yourphonefix.text               = "Your Phone App Fix"
$yourphonefix.width              = 205
$yourphonefix.height             = 30
$yourphonefix.location           = New-Object System.Drawing.Point(3,790)
$yourphonefix.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label30                         = New-Object system.Windows.Forms.Label
$Label30.text                    = "Controls"
$Label30.AutoSize                = $true
$Label30.width                   = 230
$Label30.height                  = 25
$Label30.location                = New-Object System.Drawing.Point(500,11)
$Label30.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$programs                        = New-Object system.Windows.Forms.Button
$programs.text                   = "Programs and Features"
$programs.width                  = 205
$programs.height                 = 30
$programs.location               = New-Object System.Drawing.Point(4,30)
$programs.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$devicemgr                       = New-Object system.Windows.Forms.Button
$devicemgr.text                  = "Device Manager"
$devicemgr.width                 = 205
$devicemgr.height                = 30
$devicemgr.location              = New-Object System.Drawing.Point(4,65)
$devicemgr.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$restorepower                    = New-Object system.Windows.Forms.Button
$restorepower.text               = "Restore Power Options"
$restorepower.width              = 205
$restorepower.height             = 30
$restorepower.location           = New-Object System.Drawing.Point(4,100)
$restorepower.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ncpa                            = New-Object system.Windows.Forms.Button
$ncpa.text                       = "Network Connections"
$ncpa.width                      = 205
$ncpa.height                     = 30
$ncpa.location                   = New-Object System.Drawing.Point(4,135)
$ncpa.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldcontrolpanel                 = New-Object system.Windows.Forms.Button
$oldcontrolpanel.text            = "Control Panel"
$oldcontrolpanel.width           = 205
$oldcontrolpanel.height          = 30
$oldcontrolpanel.location        = New-Object System.Drawing.Point(4,170)
$oldcontrolpanel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsoundpanel                   = New-Object system.Windows.Forms.Button
$oldsoundpanel.text              = "Sound"
$oldsoundpanel.width             = 205
$oldsoundpanel.height            = 30
$oldsoundpanel.location          = New-Object System.Drawing.Point(4,205)
$oldsoundpanel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsystempanel                  = New-Object system.Windows.Forms.Button
$oldsystempanel.text             = "System Properties"
$oldsystempanel.width            = 205
$oldsystempanel.height           = 30
$oldsystempanel.location         = New-Object System.Drawing.Point(4,240)
$oldsystempanel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldpower                        = New-Object system.Windows.Forms.Button
$oldpower.text                   = "Power Options"
$oldpower.width                  = 205
$oldpower.height                 = 30
$oldpower.location               = New-Object System.Drawing.Point(4,275)
$oldpower.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$winservices                     = New-Object system.Windows.Forms.Button
$winservices.Text                = "Services"
$winservices.Width               = 205
$winservices.Height              = 30
$winservices.Location            = New-Object System.Drawing.Point(4,310)
$winservices.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

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
$defaultwindowsupdate.width      = 250
$defaultwindowsupdate.height     = 40
$defaultwindowsupdate.location   = New-Object System.Drawing.Point(36,28)
$defaultwindowsupdate.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$securitywindowsupdate           = New-Object system.Windows.Forms.Button
$securitywindowsupdate.text      = "Security Updates Only"
$securitywindowsupdate.width     = 250
$securitywindowsupdate.height    = 40
$securitywindowsupdate.location  = New-Object System.Drawing.Point(36,75)
$securitywindowsupdate.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$enableupdates                   = New-Object system.Windows.Forms.Button
$enableupdates.text              = "Enable Update Services"
$enableupdates.width             = 250
$enableupdates.height            = 40
$enableupdates.location          = New-Object System.Drawing.Point(36,120)
$enableupdates.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$windowsupdatefix                = New-Object system.Windows.Forms.Button
$windowsupdatefix.text           = "Windows Update Reset"
$windowsupdatefix.width          = 250
$windowsupdatefix.height         = 40
$windowsupdatefix.location       = New-Object System.Drawing.Point(36,165)
$windowsupdatefix.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$Label12                         = New-Object system.Windows.Forms.Label
$Label12.text                    = "NOT RECOMMENDED!!!"
$Label12.AutoSize                = $true
$Label12.width                   = 25
$Label12.height                  = 10
$Label12.location                = New-Object System.Drawing.Point(78,230)
$Label12.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$disableupdates                  = New-Object system.Windows.Forms.Button
$disableupdates.text             = "Disable Update Services"
$disableupdates.width            = 250
$disableupdates.height           = 40
$disableupdates.location         = New-Object System.Drawing.Point(36,255)
$disableupdates.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$PictureBox1                     = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width               = 343
$PictureBox1.height              = 136
$PictureBox1.location            = New-Object System.Drawing.Point(580,850)
$PictureBox1.imageLocation       = "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Sevurd-Toolbox-White.png?raw=true"
$PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 381
$Panel3.width                    = 220
$Panel3.location                 = New-Object System.Drawing.Point(464,54)

$ResultText                      = New-Object System.Windows.Forms.TextBox  
$ResultText.width                = 382
$ResultText.height               = 250
$ResultText.location             = New-Object System.Drawing.Point(576,491)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ResultText.Multiline            = $true

$Label10                         = New-Object system.Windows.Forms.Label
$Label10.text                    = "Current Status:"
$Label10.AutoSize                = $true
$Label10.width                   = 25
$Label10.height                  = 10
$Label10.location                = New-Object System.Drawing.Point(658,448)
$Label10.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Form.controls.AddRange(@($Panel1,$Panel2,$Label3,$Label30,$Label15,$Panel4,$PictureBox1,$Label1,$Panel3,$ResultText,$Label10))
$Panel1.controls.AddRange(@($brave,$firefox,$7zip,$whatsapp,$nvidia,$notepad,$gchrome,$valorant,$origin,$ubisoft,$directx,$msimode,$visualc,$nvcleanstall,$Label2,$rufus,$ddu,$sdio,$steam,$Label7,$Label8,$Label9,$advancedipscanner,$putty,$autoruns,$translucenttb,$spotify,$discord,$autohotkey))
$Panel2.controls.AddRange(@($win10tweaks,$win11tweaks,$cleanup,$DDefender,$EDefender,$backgroundapps,$cortana,$actioncenter,$darkmode,$performancefx,$onedrive,$lightmode,$EActionCenter,$ECortana,$RBackgroundApps,$HTrayIcons,$removebloat,$WarningLabel,$Label5,$appearancefx,$STrayIcons,$laptopnumlock,$yourphonefix))
$Panel3.controls.AddRange(@($ncpa,$oldcontrolpanel,$oldsoundpanel,$oldsystempanel,$oldpower,$restorepower,$winservices,$devicemgr,$programs))
$Panel4.controls.AddRange(@($defaultwindowsupdate,$securitywindowsupdate,$windowsupdatefix,$disableupdates,$enableupdates,$Label12))

# GUI Specs
Write-Host "Checking if chocolatey installed..."
#$ResultText.text = "`r`n" + "Checking if chocolatey installed..."

# Check if chocolatey is installed
if (Test-Path C:\ProgramData\chocolatey\bin\choco.exe){
    'Chocolatey Already Installed'
}
else{
    # Installing chocolatey
	Write-Host "Chocolatey not found, installing it now."
    	#$ResultText.text += "`r`n" + "`r`n" + "Chocolatey not found"
    	#$ResultText.text += "`r`n" + "`r`n" + "Installing Chocolatey... Please Wait"
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	Write-Host "Chocolatey Installed. Please close powershell and run the script again"
    	$ResultText.text += "`r`n" + "`r`n" + "Successfully Installed Chocolatey" + "`r`n" + "`r`n" + "Please close powershell and run the script again."
}

$firefox.Add_Click({
    Write-Host "Installing Firefox"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Firefox... Please Wait" 
    choco install firefox --params "/TaskbarShortcut /DesktopShortcut /NoMaintenanceService" -y -f --ignore-checksums | Out-Host
    if($?) { Write-Host "Installed Firefox" }
    $ResultText.text = "`r`n" + "Finished Installing Firefox" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$brave.Add_Click({
    Write-Host "Installing Brave Browser"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Brave... Please Wait" 
    choco install brave -y -f --ignore-checksums | Out-Host
    if($?) { Write-Host "Installed Brave Browser" }
    $ResultText.text = "`r`n" + "Finished Installing Brave" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$gchrome.Add_Click({
    Write-Host "Installing Google Chrome"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Google Chrome... Please Wait" 
    choco install googlechrome -y -f --ignore-checksums | Out-Host
    if($?) { Write-Host "Installed Google Chrome" }
    $ResultText.text = "`r`n" + "Finished Installing Google Chrome" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$sdio.Add_Click({
    Write-Host "Installing Snappy Driver Installer Origin"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Snappy Driver Installer Origin... Please Wait" 
    choco install sdio -y -f --ignore-checksums | Out-Host
    if($?) { Write-Host "Installed Snappy Driver Installer Origin" }
    $ResultText.text = "`r`n" + "Finished Installing Snappy Driver Installer Origin" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$discord.Add_Click({
    Write-Host "Installing Discord"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Discord... Please Wait" 
    choco install discord.install -y -f --ignore-checksums | Out-Host
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Discord"
    #New-Item -Path "$env:USERPROFILE\AppData\Roaming\" -Name "discord" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/discord/settings.json?raw=true" -Destination "$env:USERPROFILE\AppData\Roaming\discord\settings.json"
    if($?) { Write-Host "Installed Discord" }
    $ResultText.text = "`r`n" + "Finished Installing Discord" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$nvidia.Add_Click({
    Write-Host "Installing Nvidia Driver"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Nvidia Driver..." 
    choco install nvidia-display-driver --params "'/DCH'" -y --ignore-checksums | Out-Host
    Write-Host "Installed Nvidia Driver"
    $ResultText.text = "`r`n" +"`r`n" + "Finished Installing Nvidia Driver..." +"`r`n" + "Please restart computer."
})

$msimode.Add_Click({
    Write-Host "Installing MSI Mode Utility"
    $ResultText.text = "`r`n" +"`r`n" + "Installing MSI Mode Utility" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/MSI%20Mode.zip?raw=true" -Destination "C:\Sevurd Toolbox\MSI Mode.zip"
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
    choco install notepadplusplus.install -y -f --ignore-checksums | Out-Host
    New-Item -Path "$env:USERPROFILE\AppData\Roaming\" -Name "Notepad++" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Notepad%2B%2B/config.xml?raw=true" -Destination "$env:USERPROFILE\AppData\Roaming\Notepad++\config.xml"
    Write-Host "Installed Notepad++"
    $ResultText.text = "`r`n" + "Finished Installing NotePad++" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$ubisoft.Add_Click({
    Write-Host "Installing Ubisift Connect"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Ubisift Connect... Please Wait" 
    choco install ubisoft-connect -y -f --ignore-checksums | Out-Host
    if($?) { Write-Host "Installed Ubisift Connect" }
    $ResultText.text = "`r`n" + "Finished Installing Ubisift Connect" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$origin.Add_Click({
    Write-Host "Installing Origin"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Origin... Please Wait" 
    choco install origin -y -f --params "/DesktopIcon" --ignore-checksums | Out-Host
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
    choco install 7zip.install -y -f --ignore-checksums | Out-Host
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/7-ZIP.reg?raw=true" -Destination 'C:\Sevurd Toolbox\7-ZIP.reg'
    regedit /s "C:\Sevurd Toolbox\7-ZIP.reg"
    if($?) { Write-Host "Installed 7-Zip Compression Tool" }
    $ResultText.text = "`r`n" + "Finished Installing 7-Zip Compression Tool" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$nvcleanstall.Add_Click({
    Write-Host "Installing NVCleanstall"
    $ResultText.text = "`r`n" +"`r`n" + "Installing NVCleanstall... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/NVCleanstall_1.13.0.exe?raw=true" -Destination 'C:\Sevurd Toolbox\NVCleanstall_1.13.0.exe'
    & 'C:\Sevurd Toolbox\NVCleanstall_1.13.0.exe'
    if($?) { Write-Host "Installed NVCleanstall" }
    $ResultText.text = "`r`n" + "Finished Installing NVCleanstall" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$ddu.Add_Click({
    Write-Host "Installing Display Driver Uninstaller"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Display Driver Uninstaller... Please Wait"
    choco install ddu -y -f --ignore-checksums | Out-Host
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Display Driver Uninstaller.lnk")
    $Shortcut.TargetPath = "C:\ProgramData\chocolatey\bin\Display Driver Uninstaller.exe"
    $Shortcut.Save()
    Write-Host "Installed Display Driver Uninstaller"
    $ResultText.text = "`r`n" + "Finished Installing Display Driver Uninstaller" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$visualc.Add_Click({
    Write-Host "Installing Visual C++"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Visual C++... Please Wait" 
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://kutt.it/vcppredist" -Destination 'C:\Sevurd Toolbox\VisualCppRedist.zip'
    Expand-Archive -Path 'C:\Sevurd Toolbox\VisualCppRedist.zip' -DestinationPath 'C:\Sevurd Toolbox'
    & 'C:\Sevurd Toolbox\VisualCppRedist_AIO_x86_x64.exe' /ai | Out-Host
    if($?) { Write-Host "Installed Visual C++" }
    $ResultText.text = "`r`n" + "Finished Installing Visual C++" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$directx.Add_Click({
    Write-Host "Installing DirectX"
    $ResultText.text = "`r`n" +"`r`n" + "Installing DirectX... Please Wait" 
    choco install directx -y -f --ignore-checksums | Out-Host
    if($?) { Write-Host "Installed DirectX" }
    $ResultText.text = "`r`n" + "Finished Installing DirectX" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$rufus.Add_Click({
    Write-Host "Installing Rufus"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Rufus... Please Wait" 
    choco install rufus -y -f --ignore-checksums | Out-Host
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Rufus.lnk")
    $Shortcut.TargetPath = "C:\ProgramData\chocolatey\bin\rufus.exe"
    $Shortcut.Save()
    Write-Host "Installed Rufus"
    $ResultText.text = "`r`n" + "Finished Installing Rufus" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$spotify.Add_Click({
    Write-Host "Installing Spotify"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Spotify... Please Wait" 
    choco install spotify -y -f --ignore-checksums | Out-Host
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Spotify"
    New-Item -Path "$env:USERPROFILE\AppData\Roaming\" -Name "Spotify" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Spotify/prefs?raw=true" -Destination "$env:USERPROFILE\AppData\Roaming\Spotify\prefs"
    if($?) { Write-Host "Installed Spotify" }
    $ResultText.text = "`r`n" + "Finished Installing Spotify" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$autoruns.Add_Click({
    Write-Host "Installing Autoruns"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Autoruns... Please Wait" 
    choco install autoruns -y -f --ignore-checksums | Out-Host
    Write-Host "Installed Autoruns"
    $ResultText.text = "`r`n" + "Finished Installing Autoruns" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$whatsapp.Add_Click({
    Write-Host "Installing WhatsApp"
    $ResultText.text = "`r`n" +"`r`n" + "Installing WhatsApp... Please Wait" 
    choco install whatsapp -y -f --ignore-checksums | Out-Host
    Write-Host "Installed Whatsapp "
    $ResultText.text = "`r`n" + "Finished Installing WhatsApp" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$steam.Add_Click({
    Write-Host "Installing Steam"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Steam... Please Wait" 
    choco install steam-client -y -f --ignore-checksums | Out-Host
    Write-Host "Installed Steam"
    $ResultText.text = "`r`n" + "Finished Installing Steam" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$win10tweaks.Add_Click({
    Write-Host "Creating Restore Point incase something bad happens"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Essential Tools... Please Wait" 
    Enable-ComputerRestore -Drive "C:\"
    Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

    Write-Host "Transfering Essential Files..."
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_BitsumHighestPerformance.pow?raw=true" -Destination 'C:\Windows\_BitsumHighestPerformance.pow'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_NvidiaBaseProfile.nip?raw=true" -Destination 'C:\Windows\_NvidiaBaseProfile.nip'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_NvidiaProfileInspector.exe?raw=true" -Destination 'C:\Windows\_NvidiaProfileInspector.exe'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_SetTimerResolutionService.exe?raw=true" -Destination 'C:\Windows\_SetTimerResolutionService.exe'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/PowerRun.exe?raw=true" -Destination 'C:\Windows\PowerRun.exe'

    <#
    Write-Host "Running O&O Shutup with Recommended Settings"
    $ResultText.text += "`r`n" +"Running O&O Shutup with Recommended Settings"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/sevurd/Sevurd-Toolbox/main/files/ooshutup10.cfg?raw=true" -Destination ooshutup10.cfg
    Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup10.cfg /quiet
    #>

    $ResultText.text += "`r`n" +"Disabling Unnecessary Things"
    Write-Host "Disabling Telemetry..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    Write-Host "Disabling Wi-Fi Sense..."
    #$ResultText.text += "`r`n" +"Disabling Wi-Fi Sense..."
    If (!(Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
    Write-Host "Disabling Application suggestions..."
    #$ResultText.text += "`r`n" +"Disabling Application suggestions..."
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
    #$ResultText.text += "`r`n" +"Disabling Activity History..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    # Keep Location Tracking commented out if you want the ability to locate your device
    Write-Host "Disabling Location Tracking..."
    #$ResultText.text += "`r`n" +"Disabling Location Tracking..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    Write-Host "Disabling Automatic Maps Updates..."
    #$ResultText.text += "`r`n" +"Disabling Automatic Maps Updates..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    Write-Host "Disabling Feedback..."
    #$ResultText.text += "`r`n" +"Disabling Feedback..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-Host "Disabling Tailored Experiences..."
    #$ResultText.text += "`r`n" +"Disabling Tailored Experiences..."
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    Write-Host "Disabling Advertising ID..."
    #$ResultText.text += "`r`n" +"Disabling Advertising ID..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    Write-Host "Disabling Error Reporting..."
    #$ResultText.text += "`r`n" +"Disabling Error Reporting..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-Host "Restricting Windows Update P2P only to local network..."
    #$ResultText.text += "`r`n" +"Restricting Windows Update P2P Only to Local Network..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    Write-Host "Enabling F8 boot menu options..."
    #$ResultText.text += "`r`n" +"Enabling F8 boot menu options"
    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
    # Disabling Services
    #$ResultText.text += "`r`n" +"Disabling unnecessary things..."
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
    $ResultText.text += "`r`n" +"Applying Visualization Tweaks"
    Write-Host "Hiding Task View button..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    Write-Host "Hiding People icon..."
    #$ResultText.text += "`r`n" +"Hiding People icon..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
    Write-Host "Hiding Cortana icon..."
    #$ResultText.text += "`r`n" +"Hiding Cortana..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
    Write-Host "Set searchbox to icon..."
    #$ResultText.text += "`r`n" +"Set searchbox to icon..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
    Write-Host "Show tray icons..."
    #$ResultText.text += "`r`n" +"Show tray icons..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
    Write-Host "Enabling NumLock after startup..."
    #$ResultText.text += "`r`n" +"Enabling NumLock after startup..."
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
    #$ResultText.text += "`r`n" +"Changing default Explorer view to This PC..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    Write-Host "Hiding 3D Objects icon from This PC..."
    #$ResultText.text += "`r`n" +"Hiding 3D Objects icon from This PC..."
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

    
    $ResultText.text += "`r`n" +"Tweaking System for Best Performance"

    
    Write-Host "Disable Hibernate"
    powercfg -h off
    Write-Host "Import Power Plan"
    powercfg -import "C:\Windows\_BitsumHighestPerformance.pow" 77777777-7777-7777-7777-777777777777
    powercfg -SETACTIVE "77777777-7777-7777-7777-777777777777"
    powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 
    powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a
    Write-Host "Import Nvidia Settings"
    _nvidiaProfileInspector.exe "C:\Windows\_NvidiaBaseProfile.nip" -silent
    Write-Host "Installing Timer Resolution Service"
    _SetTimerResolutionService.exe -install
    sc config STR start=auto
    net start STR
    Write-Host "Rebuild Performance Counter"
    lodctr /r
    lodctr /r

    $ResultText.text += "`r`n" +"Applying Registry Tweaks"


    # Chrome
    Write-Host "Tweaking Chrome..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "HardwareAccelerationModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BackgroundModeEnabled" -Type DWord -Value 0

    # Edge
    Write-Host "Tweaking Edge..."
    Disable-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineCore" | Out-Null
    Disable-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineUA" | Out-Null
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
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/Gamebar%20Presence%20Writer.reg?raw=true" -Destination 'C:\Sevurd Toolbox\Gamebar Presence Writer.reg'
    PowerRun regedit /S "C:\Sevurd Toolbox\Gamebar Presence Writer.reg"

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

    # Privacy
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationLastUsed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic" -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0

    # Disable automatic maintenance
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Type DWord -Value 1

    # Disable use my sign in info after restart
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableAutomaticRestartSignOn" -Type DWord -Value 1

    # Disable automatically update maps
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

    # Alt tab open windows only
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Type DWord -Value 3

    # Service tweaks to Manual 
    $ResultText.text += "`r`n" +"Tweaking Services"

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

    $ResultText.text = "`r`n" + "Essential Tweaks Done" + "`r`n" + "`r`n" + "Please Reboot"
    Write-Host "Essential Tweaks Completed - Please Reboot"
    
    
    
    $msgBoxInput =  [System.Windows.Forms.MessageBox]::Show('Essential Tweaks Done. Click OK to Restart. Press Cancel to Reboot Manually.','Sevurd Toolbox','OKCancel')
    switch  ($msgBoxInput) {
	    'OK' {
            
            C:\Windows\System32\shutdown.exe /r /t 0

        }
	    'Cancel' {
			
		    /Exit
		
	    }
    }
})

$win11tweaks.Add_Click({
    Write-Host "Creating Restore Point incase something bad happens"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Essential Tools... Please Wait" 
    Enable-ComputerRestore -Drive "C:\"
    Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

    Write-Host "Transfering Essential Files..."
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_BitsumHighestPerformance.pow?raw=true" -Destination 'C:\Windows\_BitsumHighestPerformance.pow'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_NvidiaBaseProfile.nip?raw=true" -Destination 'C:\Windows\_NvidiaBaseProfile.nip'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_NvidiaProfileInspector.exe?raw=true" -Destination 'C:\Windows\_NvidiaProfileInspector.exe'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/_SetTimerResolutionService.exe?raw=true" -Destination 'C:\Windows\_SetTimerResolutionService.exe'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/PowerRun.exe?raw=true" -Destination 'C:\Windows\PowerRun.exe'

    Write-Host "Running O&O Shutup with Recommended Settings"
    $ResultText.text += "`r`n" +"Running O&O Shutup with Recommended Settings"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/sevurd/Sevurd-Toolbox/main/files/ooshutup11.cfg?raw=true" -Destination ooshutup10.cfg
    Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup10.cfg /quiet

    $ResultText.text += "`r`n" +"Disabling Unnecessary Things"
    Write-Host "Disabling Telemetry..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    Write-Host "Disabling Wi-Fi Sense..."
    #$ResultText.text += "`r`n" +"Disabling Wi-Fi Sense..."
    If (!(Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
    Write-Host "Disabling Application suggestions..."
    #$ResultText.text += "`r`n" +"Disabling Application suggestions..."
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
    #$ResultText.text += "`r`n" +"Disabling Activity History..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    # Keep Location Tracking commented out if you want the ability to locate your device
    Write-Host "Disabling Location Tracking..."
    #$ResultText.text += "`r`n" +"Disabling Location Tracking..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    Write-Host "Disabling Automatic Maps Updates..."
    #$ResultText.text += "`r`n" +"Disabling Automatic Maps Updates..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    Write-Host "Disabling Feedback..."
    #$ResultText.text += "`r`n" +"Disabling Feedback..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-Host "Disabling Tailored Experiences..."
    #$ResultText.text += "`r`n" +"Disabling Tailored Experiences..."
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    Write-Host "Disabling Advertising ID..."
    #$ResultText.text += "`r`n" +"Disabling Advertising ID..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    Write-Host "Disabling Error Reporting..."
    #$ResultText.text += "`r`n" +"Disabling Error Reporting..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-Host "Restricting Windows Update P2P only to local network..."
    #$ResultText.text += "`r`n" +"Restricting Windows Update P2P Only to Local Network..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    Write-Host "Enabling F8 boot menu options..."
    #$ResultText.text += "`r`n" +"Enabling F8 boot menu options"
    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
    # Disabling Services
    #$ResultText.text += "`r`n" +"Disabling unnecessary things..."
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
    $ResultText.text += "`r`n" +"Applying Visualization Tweaks"
    Write-Host "Hiding Task View button..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    Write-Host "Set searchbox to icon..."
    #$ResultText.text += "`r`n" +"Set searchbox to icon..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
    Write-Host "Show tray icons..."
    #$ResultText.text += "`r`n" +"Show tray icons..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
    Write-Host "Enabling NumLock after startup..."
    #$ResultText.text += "`r`n" +"Enabling NumLock after startup..."
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
    #$ResultText.text += "`r`n" +"Changing default Explorer view to This PC..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    Write-Host "Hiding 3D Objects icon from This PC..."
    #$ResultText.text += "`r`n" +"Hiding 3D Objects icon from This PC..."
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue

	# Network Tweaks
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20

    # Group svchost.exe processes
    $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force

    #Write-Host "Installing Windows Media Player..."
	#Enable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null

    Write-Host "Removing AutoLogger file and restricting directory..."
    $autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
    If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
        Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
    }
    icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null

    Write-Host "Showing known file extensions..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

    
    $ResultText.text += "`r`n" +"Tweaking System for Best Performance"

    
    Write-Host "Disable Hibernate"
    powercfg -h off
    Write-Host "Import Power Plan"
    powercfg -import "C:\Windows\_BitsumHighestPerformance.pow" 77777777-7777-7777-7777-777777777777
    powercfg -SETACTIVE "77777777-7777-7777-7777-777777777777"
    powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 
    powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a
    Write-Host "Import Nvidia Settings"
    _nvidiaProfileInspector.exe "C:\Windows\_NvidiaBaseProfile.nip" -silent
    Write-Host "Installing Timer Resolution Service"
    _SetTimerResolutionService.exe -install
    #sc config STR start=auto
    net start STR
    Write-Host "Rebuild Performance Counter"
    lodctr /r
    lodctr /r

    $ResultText.text += "`r`n" +"Applying Registry Tweaks"


    # Chrome
    Write-Host "Tweaking Chrome..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "HardwareAccelerationModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BackgroundModeEnabled" -Type DWord -Value 0

    # Edge
    Write-Host "Tweaking Edge..."
    Disable-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineCore" | Out-Null
    Disable-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineUA" | Out-Null
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
    New-Item -Path "HKCU:\Control Panel\Desktop\PerMonitorSettings\AUOD1ED0_22_07E3_A9^BA177C8FC0A6F9DFF117ED6F7C4E6DD7" -Force
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\PerMonitorSettings\AUOD1ED0_22_07E3_A9^BA177C8FC0A6F9DFF117ED6F7C4E6DD7" -Name "DpiValue" -Type DWord -Value 4294967295
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "AppliedDPI" -Type DWord -Value 96
    Write-Host "Disable Transparency..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 0
    Write-Host "Increase wallpaper quality..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Type DWord -Value 100

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
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/Gamebar%20Presence%20Writer.reg?raw=true" -Destination 'C:\Sevurd Toolbox\Gamebar Presence Writer.reg'
    PowerRun regedit /S "C:\Sevurd Toolbox\Gamebar Presence Writer.reg"

    # Search
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SafeSearchMode" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Type DWord -Value 0

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

    # Service tweaks to Manual 
    $ResultText.text += "`r`n" +"Tweaking Services"

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

    $ResultText.text = "`r`n" + "Essential Tweaks Done" + "`r`n" + "`r`n" + "Please Reboot"
    Write-Host "Essential Tweaks Completed - Please Reboot"
    
    
    
    $msgBoxInput =  [System.Windows.Forms.MessageBox]::Show('Essential Tweaks Done. Click OK to Restart. Press Cancel to Reboot Manually.','Sevurd Toolbox','OKCancel')
    switch  ($msgBoxInput) {
	    'OK' {
            
            C:\Windows\System32\shutdown.exe /r /t 0

        }
	    'Cancel' {
			
		    /Exit
		
	    }
    }
})

$cleanup.Add_Click({
    Write-Host "Cleaning up windows"
    $ResultText.text = "`r`n" + "`r`n" + "Cleaning up windows...Please wait"
    Remove-Item -Path $env:TEMP\* -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path $env:windir\Temp\* -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path $env:windir\Prefetch\* -Recurse -ErrorAction SilentlyContinue
    cleanmgr /d C | Out-Null
    Write-Host "Cleaned up windows"
    $ResultText.text = "`r`n" + "Cleaned up windows" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$DDefender.Add_Click({
    Write-Host "Disabling Defender"
    $ResultText.text = "`r`n" + "`r`n" + "Disabling Defender"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/PowerRun.exe?raw=true" -Destination 'C:\Windows\PowerRun.exe'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/Disable%20Defender.reg?raw=true" -Destination 'C:\Sevurd Toolbox\Disable Defender.reg'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/Disable%20SmartScreen.reg?raw=true" -Destination 'C:\Sevurd Toolbox\Disable SmartScreen.reg'
    PowerRun regedit /S "C:\Sevurd Toolbox\Disable Defender.reg"
    PowerRun regedit /S "C:\Sevurd Toolbox\Disable SmartScreen.reg"
    Write-Host "Disabled Defender"
    $ResultText.text = "`r`n" + "`r`n" + "Disabled Defender"
})

$EDefender.Add_Click({
    Write-Host "Enabling Defender"
    $ResultText.text = "`r`n" + "`r`n" + "Enabling Defender"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/PowerRun.exe?raw=true" -Destination 'C:\Windows\PowerRun.exe'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/Enable%20Defender.reg?raw=true" -Destination 'C:\Sevurd Toolbox\Enable Defender.reg'
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/files/Enable%20SmartSceen.reg?raw=true" -Destination 'C:\Sevurd Toolbox\Enable SmartScreen.reg'
    PowerRun regedit /S "C:\Sevurd Toolbox\Enable Defender.reg"
    PowerRun regedit /S "C:\Sevurd Toolbox\Enable SmartScreen.reg"
    Write-Host "Enabled Defender"
    $ResultText.text = "`r`n" + "`r`n" + "Enabled Defender"
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
    #$ResultText.text = "`r`n" + "Disabling driver offering through Windows Update"
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
    #$ResultText.text += "`r`n" + "`r`n" + "Disabling Windows Update automatic restart"
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Applied Security Updates Only"
    $ResultText.text  = "`r`n" +"`r`n" + "Delayed Features Updates upto 3 years"
    $ResultText.text += "`r`n" +"`r`n" + "Delayed Security Updates upto 4 days"
    $ResultText.text += "`r`n" +"`r`n" + "Disabled Driver Update through Windows Update"
    $ResultText.text += "`r`n" +"`r`n" + "Done" + "`r`n" + "`r`n" + "You will recieve only security updates from now."
})

$actioncenter.Add_Click({
    Write-Host "Disabling Action Center and Notifications..."
    $ResultText.text = "`r`n" +"`r`n" + "Disabling Action Center and Notifications"
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
    $ResultText.text = "`r`n" + "`r`n" + "Disabled Action Center and Notifications" +"`r`n" + "`r`n" + "Restart to take effect"
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
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0
    New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Force
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
    Write-Host "Enabled Dark Mode"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Dark Mode"
})

$lightmode.Add_Click({
    Write-Host "Switching Back to Light Mode"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 1
    New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Force
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1
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


$RBackgroundApps.Add_Click({
	Write-Host "Allowing Background Apps..."
	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
		Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
		Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
	}
	Write-Host "Done - Reverted to Stock Settings"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Background Apps"
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

$programs.Add_Click({
    cmd /c appwiz.cpl
})

$devicemgr.Add_Click({
    cmd /c devmgmt.msc
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

$winservices.Add_Click({
    cmd /c services.msc
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
