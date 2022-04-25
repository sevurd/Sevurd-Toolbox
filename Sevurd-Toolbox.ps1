Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
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
New-Item -Path "C:\" -Name "Sevurd Toolbox" -ItemType "directory" -ErrorAction SilentlyContinue

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050,1000)
$Form.text                       = "Sevurd Toolbox"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#202020")
$Form.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
$Form.AutoScaleMode              = "Dpi"
$Form.AutoScaleDimensions        = '192, 192'
$Form.AutoSize                   = $True
$Form.AutoScroll                 = $True
$Form.ClientSize                 = '1050, 1000'
$Form.FormBorderStyle            = 'FixedSingle'

# GUI Icon
$iconBase64                      = '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'
$iconBytes                       = [Convert]::FromBase64String($iconBase64)
$stream                          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
$Form.Icon                       = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())


$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 940
$Panel1.width                    = 220
$Panel1.location                 = New-Object System.Drawing.Point(5,54)

$Panel5                          = New-Object system.Windows.Forms.Panel
$Panel5.height                   = 940
$Panel5.width                    = 220
$Panel5.location                 = New-Object System.Drawing.Point(240,54)

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 940
$Panel2.width                    = 220
$Panel2.location                 = New-Object System.Drawing.Point(475,54)

$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 381
$Panel3.width                    = 220
$Panel3.location                 = New-Object System.Drawing.Point(710,54)

$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 328
$Panel4.width                    = 340
$Panel4.location                 = New-Object System.Drawing.Point(945,54)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Installers"
$Label1.AutoSize                 = $true
$Label1.width                    = 230
$Label1.height                   = 25
$Label1.location                 = New-Object System.Drawing.Point(154,11)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Utilities"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(85,9)
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

$ddu                             = New-Object system.Windows.Forms.Button
$ddu.text                        = "Display Driver Uninstaller"
$ddu.width                       = 212
$ddu.height                      = 30
$ddu.location                    = New-Object System.Drawing.Point(4,170)
$ddu.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$nvcleanstall                    = New-Object system.Windows.Forms.Button
$nvcleanstall.text               = "NVCleanstall"
$nvcleanstall.width              = 212
$nvcleanstall.height             = 30
$nvcleanstall.location           = New-Object System.Drawing.Point(4,205)
$nvcleanstall.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$nvidia                          = New-Object system.Windows.Forms.Button
$nvidia.text                     = "Nvidia Display Driver"
$nvidia.width                    = 212
$nvidia.height                   = 30
$nvidia.location                 = New-Object System.Drawing.Point(4,240)
$nvidia.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$msimode                         = New-Object system.Windows.Forms.Button
$msimode.text                    = "MSI Mode Utility"
$msimode.width                   = 212
$msimode.height                  = 30
$msimode.location                = New-Object System.Drawing.Point(4,275)
$msimode.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$sdio                            = New-Object system.Windows.Forms.Button
$sdio.text                       = "Snappy Driver Installer"
$sdio.width                      = 212
$sdio.height                     = 30
$sdio.location                   = New-Object System.Drawing.Point(4,310)
$sdio.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$autoruns                        = New-Object system.Windows.Forms.Button
$autoruns.text                   = "Autoruns"
$autoruns.width                  = 212
$autoruns.height                 = 30
$autoruns.location               = New-Object System.Drawing.Point(4,345)
$autoruns.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$rufus                           = New-Object system.Windows.Forms.Button
$rufus.text                      = "Rufus"
$rufus.width                     = 212
$rufus.height                    = 30
$rufus.location                  = New-Object System.Drawing.Point(4,380)
$rufus.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "Web Browsers"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(67,440)
$Label9.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$brave                           = New-Object system.Windows.Forms.Button
$brave.text                      = "Brave Browser"
$brave.width                     = 212
$brave.height                    = 30
$brave.location                  = New-Object System.Drawing.Point(4,460)
$brave.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$firefox                         = New-Object system.Windows.Forms.Button
$firefox.text                    = "Firefox"
$firefox.width                   = 212
$firefox.height                  = 30
$firefox.location                = New-Object System.Drawing.Point(4,495)
$firefox.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gchrome                         = New-Object system.Windows.Forms.Button
$gchrome.text                    = "Google Chrome"
$gchrome.width                   = 212
$gchrome.height                  = 30
$gchrome.location                = New-Object System.Drawing.Point(4,530)
$gchrome.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label8                          = New-Object system.Windows.Forms.Label
$Label8.text                     = "Game Launchers"
$Label8.AutoSize                 = $true
$Label8.width                    = 25
$Label8.height                   = 10
$Label8.location                 = New-Object System.Drawing.Point(60,590)
$Label8.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$steam                           = New-Object system.Windows.Forms.Button
$steam.text                      = "Steam"
$steam.width                     = 212
$steam.height                    = 30
$steam.location                  = New-Object System.Drawing.Point(4,610)
$steam.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ubisoft                         = New-Object system.Windows.Forms.Button
$ubisoft.text                    = "Ubisoft Connect"
$ubisoft.width                   = 212
$ubisoft.height                  = 30
$ubisoft.location                = New-Object System.Drawing.Point(4,645)
$ubisoft.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$origin                          = New-Object system.Windows.Forms.Button
$origin.text                     = "Origin"
$origin.width                    = 212
$origin.height                   = 30
$origin.location                 = New-Object System.Drawing.Point(4,680)
$origin.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$valorant                        = New-Object system.Windows.Forms.Button
$valorant.text                   = "Valorant"
$valorant.width                  = 212
$valorant.height                 = 30
$valorant.location               = New-Object System.Drawing.Point(4,715)
$valorant.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label7                          = New-Object system.Windows.Forms.Label
$Label7.text                     = "Others"
$Label7.AutoSize                 = $true
$Label7.width                    = 25
$Label7.height                   = 10
$Label7.location                 = New-Object System.Drawing.Point(90,775)
$Label7.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$discord                         = New-Object system.Windows.Forms.Button
$discord.text                    = "Discord"
$discord.width                   = 212
$discord.height                  = 30
$discord.location                = New-Object System.Drawing.Point(4,795)
$discord.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$spotify                         = New-Object system.Windows.Forms.Button
$spotify.text                    = "Spotify"
$spotify.width                   = 212
$spotify.height                  = 30
$spotify.location                = New-Object System.Drawing.Point(4,830)
$spotify.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$whatsapp                        = New-Object system.Windows.Forms.Button
$whatsapp.text                   = "WhatsApp"
$whatsapp.width                  = 212
$whatsapp.height                 = 30
$whatsapp.location               = New-Object System.Drawing.Point(4,865)
$whatsapp.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vlc                             = New-Object system.Windows.Forms.Button
$vlc.text                        = "VLC Player"
$vlc.width                       = 212
$vlc.height                      = 30
$vlc.location                    = New-Object System.Drawing.Point(4,900)
$vlc.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label31                         = New-Object system.Windows.Forms.Label
$Label31.text                    = "Coder's Hub"
$Label31.AutoSize                = $true
$Label31.width                   = 25
$Label31.height                  = 10
$Label31.location                = New-Object System.Drawing.Point(83,9)
$Label31.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$vscode                          = New-Object system.Windows.Forms.Button
$vscode.Text                     = "Visual Studio Code"
$vscode.Width                    = 212
$vscode.Height                   = 30
$vscode.Location                 = New-Object System.Drawing.Point(4,30)
$vscode.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vs                              = New-Object system.Windows.Forms.Button
$vs.Text                         = "Visual Studio"
$vs.Width                        = 212
$vs.Height                       = 30
$vs.Location                     = New-Object System.Drawing.Point(4,65)
$vs.Font                         = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$github                          = New-Object system.Windows.Forms.Button
$github.Text                     = "GitHub Desktop"
$github.Width                    = 212
$github.Height                   = 30
$github.Location                 = New-Object System.Drawing.Point(4,100)
$github.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$git                             = New-Object system.Windows.Forms.Button
$git.Text                        = "Git"
$git.Width                       = 212
$git.Height                      = 30
$git.Location                    = New-Object System.Drawing.Point(4,135)
$git.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$python                          = New-Object system.Windows.Forms.Button
$python.Text                     = "Python 3"
$python.Width                    = 212
$python.Height                   = 30
$python.Location                 = New-Object System.Drawing.Point(4,170)
$python.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$java                            = New-Object system.Windows.Forms.Button
$java.Text                       = "Java SE (JDK)"
$java.Width                      = 212
$java.Height                     = 30
$java.Location                   = New-Object System.Drawing.Point(4,205)
$java.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$powershell7                     = New-Object system.Windows.Forms.Button
$powershell7.Text                = "Powershell 7"
$powershell7.Width               = 212
$powershell7.Height              = 30
$powershell7.Location            = New-Object System.Drawing.Point(4,240)
$powershell7.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Optimization"
$Label3.AutoSize                 = $true
$Label3.width                    = 230
$Label3.height                   = 25
$Label3.location                 = New-Object System.Drawing.Point(481,11)
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

$blockthespot                    = New-Object system.Windows.Forms.Button
$blockthespot.Text               = "Block Spotify Ads"
$blockthespot.Width              = 205
$blockthespot.Height             = 30
$blockthespot.Location           = New-Object System.Drawing.Point(3,825)
$blockthespot.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label30                         = New-Object system.Windows.Forms.Label
$Label30.text                    = "Controls"
$Label30.AutoSize                = $true
$Label30.width                   = 230
$Label30.height                  = 25
$Label30.location                = New-Object System.Drawing.Point(748,11)
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
$Label15.location                = New-Object System.Drawing.Point(976,11)
$Label15.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

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
$PictureBox1.location            = New-Object System.Drawing.Point(850,850)
$PictureBox1.imageLocation       = "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Sevurd-Toolbox-White.png?raw=true"
$PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$ResultText                      = New-Object System.Windows.Forms.TextBox  
$ResultText.width                = 382
$ResultText.height               = 150
$ResultText.location             = New-Object System.Drawing.Point(820,540)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ResultText.Multiline            = $true

$Label10                         = New-Object system.Windows.Forms.Label
$Label10.text                    = "-: Current Status :-"
$Label10.AutoSize                = $true
$Label10.width                   = 25
$Label10.height                  = 10
$Label10.location                = New-Object System.Drawing.Point(870,485)
$Label10.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Form.controls.AddRange(@($Label3,$Panel2,$PictureBox1,$Panel1,$Label30,$Label15,$Panel4,$Label1,$Panel3,$ResultText,$Label10,$Panel5))
$Panel1.controls.AddRange(@($Label2,$brave,$firefox,$7zip,$whatsapp,$nvidia,$notepad,$gchrome,$valorant,$origin,$ubisoft,$directx,$msimode,$visualc,$nvcleanstall,$rufus,$ddu,$sdio,$steam,$Label7,$Label8,$Label9,$putty,$autoruns,$spotify,$discord,$vlc))
$Panel2.controls.AddRange(@($Label5,$win10tweaks,$win11tweaks,$cleanup,$DDefender,$EDefender,$backgroundapps,$cortana,$actioncenter,$darkmode,$performancefx,$onedrive,$lightmode,$EActionCenter,$ECortana,$RBackgroundApps,$HTrayIcons,$removebloat,$WarningLabel,$appearancefx,$STrayIcons,$laptopnumlock,$yourphonefix,$blockthespot))
$Panel3.controls.AddRange(@($ncpa,$oldcontrolpanel,$oldsoundpanel,$oldsystempanel,$oldpower,$restorepower,$winservices,$devicemgr,$programs))
$Panel4.controls.AddRange(@($defaultwindowsupdate,$securitywindowsupdate,$windowsupdatefix,$disableupdates,$enableupdates,$Label12))
$Panel5.Controls.AddRange(@($Label31,$vscode,$vs,$github,$git,$python,$java,$powershell7))

# Check if chocolatey is installed
if (Test-Path C:\ProgramData\chocolatey\bin\choco.exe){
    'Chocolatey Already Installed'
}
else{
    # Installing chocolatey
	Write-Host "Chocolatey not found, installing it now."
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	Write-Host "Chocolatey Installed. Please close powershell and run the script again"
    $ResultText.text += "`r`n" + "`r`n" + "Successfully Installed Chocolatey" + "`r`n" + "`r`n" + "Please close powershell and run the script again."
}

$vlc.Add_Click({
    Write-Host "Installing VLC Player"
    $ResultText.text = "`r`n" +"`r`n" + "Installing VLC Player... Please Wait" 
    choco install vlc -y -f | Out-Host
    if($?) { Write-Host "Installed VLC Player" }
    $ResultText.text = "`r`n" + "Finished Installing VLC Player" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$firefox.Add_Click({
    Write-Host "Installing Firefox"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Firefox... Please Wait" 
    choco install firefox --params "/TaskbarShortcut /DesktopShortcut /NoMaintenanceService" -y -f | Out-Host
    if($?) { Write-Host "Installed Firefox" }
    $ResultText.text = "`r`n" + "Finished Installing Firefox" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$brave.Add_Click({
    Write-Host "Installing Brave Browser"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Brave... Please Wait" 
    choco install brave -y -f | Out-Host
    if($?) { Write-Host "Installed Brave Browser" }
    $ResultText.text = "`r`n" + "Finished Installing Brave" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$gchrome.Add_Click({
    Write-Host "Installing Google Chrome"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Google Chrome... Please Wait" 
    choco install googlechrome -y -f | Out-Host
    if($?) { Write-Host "Installed Google Chrome" }
    $ResultText.text = "`r`n" + "Finished Installing Google Chrome" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$sdio.Add_Click({
    Write-Host "Installing Snappy Driver Installer Origin"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Snappy Driver Installer Origin... Please Wait" 
    choco install sdio -y -f | Out-Host
    if($?) { Write-Host "Installed Snappy Driver Installer Origin" }
    $ResultText.text = "`r`n" + "Finished Installing Snappy Driver Installer Origin" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$discord.Add_Click({
    Write-Host "Installing Discord"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Discord... Please Wait" 
    choco install discord.install -y -f | Out-Host
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
    choco install nvidia-display-driver --params "'/DCH'" -y | Out-Host
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
    choco install notepadplusplus.install -y -f | Out-Host
    New-Item -Path "$env:USERPROFILE\AppData\Roaming\" -Name "Notepad++" -ItemType "directory" -ErrorAction SilentlyContinue
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://github.com/sevurd/Sevurd-Toolbox/blob/main/Notepad%2B%2B/config.xml?raw=true" -Destination "$env:USERPROFILE\AppData\Roaming\Notepad++\config.xml"
    Write-Host "Installed Notepad++"
    $ResultText.text = "`r`n" + "Finished Installing NotePad++" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$ubisoft.Add_Click({
    Write-Host "Installing Ubisift Connect"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Ubisift Connect... Please Wait" 
    choco install ubisoft-connect -y -f | Out-Host
    if($?) { Write-Host "Installed Ubisift Connect" }
    $ResultText.text = "`r`n" + "Finished Installing Ubisift Connect" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$origin.Add_Click({
    Write-Host "Installing Origin"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Origin... Please Wait" 
    choco install origin -y -f --params "/DesktopIcon" | Out-Host
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
    choco install 7zip.install -y -f | Out-Host
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
    choco install directx -y -f | Out-Host
    if($?) { Write-Host "Installed DirectX" }
    $ResultText.text = "`r`n" + "Finished Installing DirectX" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$rufus.Add_Click({
    Write-Host "Installing Rufus"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Rufus... Please Wait" 
    choco install rufus -y -f | Out-Host
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
    choco install autoruns -y -f | Out-Host
    Write-Host "Installed Autoruns"
    $ResultText.text = "`r`n" + "Finished Installing Autoruns" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$whatsapp.Add_Click({
    Write-Host "Installing WhatsApp"
    $ResultText.text = "`r`n" +"`r`n" + "Installing WhatsApp... Please Wait" 
    choco install whatsapp -y -f | Out-Host
    Write-Host "Installed Whatsapp "
    $ResultText.text = "`r`n" + "Finished Installing WhatsApp" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$steam.Add_Click({
    Write-Host "Installing Steam"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Steam... Please Wait" 
    choco install steam-client -y -f | Out-Host
    Write-Host "Installed Steam"
    $ResultText.text = "`r`n" + "Finished Installing Steam" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$vscode.Add_Click({
    Write-Host "Installing Visual Studio Code"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Visual Studio Code... Please Wait"
    choco install vscode.install -y -f | Out-Host
    Write-Host "Installed Visual Studio Code"
    $ResultText.text = "`r`n" + "Finished Installing Visual Studio Code" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$vs.Add_Click({
    Write-Host "Installing Visual Studio"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Visual Studio... Please Wait"
    choco install visualstudio-installer -y -f | Out-Null
    choco install chocolatey-visualstudio.extension -y -f | Out-Null
    choco install visualstudio2022community -y -f | Out-Host
    Write-Host "Installed Visual Studio"
    $ResultText.text = "`r`n" + "Finished Installing Visual Studio" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$github.Add_Click({
    Write-Host "Installing GitHub Desktop"
    $ResultText.text = "`r`n" +"`r`n" + "Installing GitHub Desktop... Please Wait"
    choco install github-desktop -y -f | Out-Host
    Write-Host "Installed GitHub Desktop"
    $ResultText.text = "`r`n" + "Finished Installing GitHub Desktop" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$git.Add_Click({
    Write-Host "Installing Git"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Git... Please Wait"
    choco install git.install --params "/GitAndUnixToolsOnPath /NoGitLfs /NoCredentialManager /WindowsTerminalProfile /SChannel /NoAutoCrlf /Editor:VisualStudioCode" -y -f | Out-Host
    Write-Host "Installed Git"
    $ResultText.text = "`r`n" + "Finished Installing Git" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$python.Add_Click({
    Write-Host "Installing Python"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Python... Please Wait"
    choco install python3 -y -f | Out-Host
    Write-Host "Installed Python"
    $ResultText.text = "`r`n" + "Finished Installing Python" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$java.Add_Click({
    Write-Host "Installing JDK"
    $ResultText.text = "`r`n" +"`r`n" + "Installing JDK... Please Wait"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.msi" -Destination 'C:\Sevurd Toolbox\jdk-18_windows-x64_bin.msi'
    & 'C:\Sevurd Toolbox\jdk-18_windows-x64_bin.msi' /quiet
    if($?) { Write-Host "Installed JDK" }
    $ResultText.text = "`r`n" + "Finished Installing JDK" + "`r`n" + "`r`n" + "Ready for Next Task"
    $machinePATH = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine')
    [System.Environment]::SetEnvironmentVariable("PATH", $machinePATH + ";C:\Program Files\Java\jdk-18.0.1\bin", "Machine")
})

$powershell7.Add_Click({
    Write-Host "Installing Powershell"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Powershell... Please Wait"
    choco install powershell-core --install-arguments='"ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=0 ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=0 REGISTER_MANIFEST=1 ENABLE_PSREMOTING=1"' --packageparameters '"/CleanUpPath"' -y -f 
    Write-Host "Installed Powershell"
    $ResultText.text = "`r`n" + "Finished Installing Powershell" + "`r`n" + "`r`n" + "Ready for Next Task"
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
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    Write-Host "Disabling Delivery Optimization..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 0
    Write-Host "Tweaking BCD Settings"
    bcdedit /set bootmenupolicy standard | Out-Null
    bcdedit /set disabledynamictick yes | Out-Null
    bcdedit /set useplatformtick yes | Out-Null

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
    Write-Host "Disabling Sync Host Service"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\OneSyncSvc" -Name "Start" -Type DWord -Value 4
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
    Write-Host "Disabling Bing Search"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
    Write-Host "Show tray icons..."
    #$ResultText.text += "`r`n" +"Show tray icons..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
    Write-Host "Choose which folders appear on start"
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderDocuments" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderDocuments_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderDownloads" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderDownloads_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderFileExplorer" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderFileExplorer_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderMusic" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderMusic_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderNetwork" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderNetwork_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderPersonalFolder" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderPersonalFolder_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderPictures" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderPictures_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderSettings" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderSettings_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderVideos" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderVideos_ProviderSet" -Type DWord -Value 1


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

    # Group svchost.exe processes
    $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force

    Write-Host "Disable News and Interests"
    $ResultText.text += "`r`n" +"Disabling Extra Junk"
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0
    


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
    Set-Content config STR start=auto
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
    Write-Host "Disable windows widgets"
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Type Dword -Value 0
 
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

    # Privacy Settings
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
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force -ErrorAction SilentlyContinue
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1


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
    "MapsBroker"                                   # Downloaded Maps Manager
    "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
    "RemoteAccess"                                 # Routing and Remote Access
    "RemoteRegistry"                               # Remote Registry
    "SharedAccess"                                 # Internet Connection Sharing (ICS)
    "TrkWks"                                       # Distributed Link Tracking Client
    "WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
    "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
    "ndu"                                          # Windows Network Data Usage Monitor
    "WerSvc"                                       # Disables windows error reporting
    "Spooler"                                      # Disables your printer
    "Fax"                                          # Disables fax
    "fhsvc"                                        # Disables fax histroy
    "stisvc"                                       # Disables Windows Image Acquisition (WIA)
    "AJRouter"                                     # Disables (needed for AllJoyn Router Service)
    "MSDTC"                                        # Disables Distributed Transaction Coordinator
    "WpcMonSvc"                                    # Disables Parental Controls
    "PhoneSvc"                                     # Disables Phone Service(Manages the telephony state on the device)
    "PrintNotify"                                  # Disables Windows printer notifications and extentions
    "PcaSvc"                                       # Disables Program Compatibility Assistant Service
    "WPDBusEnum"                                   # Disables Portable Device Enumerator Service
    "seclogon"                                     # Disables  Secondary Logon(disables other credentials only password will work)
    "lmhosts"                                      # Disables TCP/IP NetBIOS Helper
    "wisvc"                                        # Disables Windows Insider program(Windows Insider will not work)
    "FontCache"                                    # Disables Windows font cache
    "RetailDemo"                                   # Disables RetailDemo whic is often used when showing your device
    "ALG"                                          # Disables Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
    "SCardSvr"                                     # Disables Windows smart card
    "EntAppSvc"                                    # Disables enterprise application management.
    "Browser"                                      # Disables computer browser
    "iphlpsvc"                                     # Disables ipv6 but most websites don't use ipv6 they use ipv4                             
    "SEMgrSvc"                                     # Disables Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
    "PNRPsvc"                                      # Disables peer Name Resolution Protocol ( some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
    "p2psvc"                                       # Disbales Peer Name Resolution Protocol(nables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)
    "p2pimsvc"                                     # Disables Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly.Discord will still work)
    "PerfHost"                                     # Disables  remote users and 64-bit processes to query performance .
    "RtkBtManServ"                                 # Disables Realtek Bluetooth Device Manager Service
    "QWAVE"                                        # Disables Quality Windows Audio Video Experience (audio and video might sound worse)
    "gupdate"                                      # Disables google update
    "gupdatem"                                     # Disable another google update
    "HvHost"                                       # Disables Hyper-V Host service
    "vmickvpexchange"
    "vmicguestinterface"
    "vmicshutdown"
    "vmicheartbeat"
    "vmicvmsession"
    "vmicrdv"
    "vmictimesync" 
    )

    foreach ($service in $services) {
        # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

        Write-Host "Setting $service StartupType to Manual"
        Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
    }

    # Sevice tweaks to Disabled

    $services = @(
    "BthAvctpSvc"				                # Disables AVCTP service (if you use  Bluetooth Audio Device or Wireless Headphones. then don't disable this)
    "DPS"					                    # Diagonistic Policy Service
    "dmwappushservice"				            # WAP Push Message Routing Service (see known issues)
    "edgeupdate"                                # Disables one of edge update service  
    "MicrosoftEdgeElevationService"             # Disables one of edge  service 
    "edgeupdatem"                               # disbales another one of update service (disables edgeupdatem)
    "GoogleChromeElevationService"              
    "lfsvc"					                    # Geolocation Service
    "RpcLocator"                                # Remote Procedure Call Locator
    "WpnService"                                # Disables WpnService (Push Notifications may not work )
    "XblAuthManager"                            # Xbox Live Auth Manager
    "XblGameSave"                               # Xbox Live Game Save Service
    "XboxNetApiSvc"                             # Xbox Live Networking Service
    "XboxGipSvc"                                # Disables Xbox Accessory Management Service
    "WSearch"                                   # Windows Search
    "RasAuto"                                   
    "RasMan"
    "SessionEnv"
    "TermService"
    "RmSvc"

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

    $ResultText.text += "`r`n" +"Disabling Unnecessary Things"
    # Disabling Telemetry
    Write-Host "Disabling Telemetry..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    # Disabling Wi-Fi Sense
    Write-Host "Disabling Wi-Fi Sense..."
    If (!(Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
    # Disabling Application suggestions
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
    #Disabling Activity History
    Write-Host "Disabling Activity History..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    # Keep Location Tracking commented out if you want the ability to locate your device
    #Disabling Location Tracking
    Write-Host "Disabling Location Tracking..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    # Disabling Automatic Maps Updates
    Write-Host "Disabling Automatic Maps Updates..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    # Disabling Feedback
    Write-Host "Disabling Feedback..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    # Disabling Tailored Experiences
    Write-Host "Disabling Tailored Experiences..."
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    # Disabling Advertising ID
    Write-Host "Disabling Advertising ID..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    # Disabling Error Reporting
    Write-Host "Disabling Error Reporting..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-Host "Restricting Windows Update P2P only to local network..."
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    Write-Host "Disabling Delivery Optimization..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 0


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
    Write-Host "Disabling Sync Host Service"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\OneSyncSvc" -Name "Start" -Type DWord -Value 4
    Write-Host "Disabling Hibernation..."
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 0
    # Showing task manager details
    Write-Host "Showing task manager details..."
    $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
    Do {
        Start-Sleep -Milliseconds 100
        $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
    } Until ($preferences)
    Stop-Process $taskmgr
    $preferences.Preferences[28] = 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
    # Showing file operations details
    Write-Host "Showing file operations details..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

    # Applying Visualization Tweaks

    $ResultText.text += "`r`n" +"Applying Visualization Tweaks"
    Write-Host "Hiding Task View button..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
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
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    Write-Host "Hiding 3D Objects icon from This PC..."
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue

    # Group svchost.exe processes
    $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force

    Write-Host "Removing AutoLogger file and restricting directory..."
    $autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
    If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
        Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
    }
    icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null

    Write-Host "Showing known file extensions..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

    Write-Host "Restore old context menu..."
    New-Item -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Type String -Value ''

    
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
    Set-Content config STR start=auto
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
    Write-Host "Disable windows widgets"
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Type Dword -Value 0

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

    # Privacy Settings
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
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force -ErrorAction SilentlyContinue
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

    
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
    "MapsBroker"                                   # Downloaded Maps Manager
    "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
    "RemoteAccess"                                 # Routing and Remote Access
    "RemoteRegistry"                               # Remote Registry
    "SharedAccess"                                 # Internet Connection Sharing (ICS)
    "TrkWks"                                       # Distributed Link Tracking Client
    "WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
    "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
    "ndu"                                          # Windows Network Data Usage Monitor
    "WerSvc"                                       # Disables windows error reporting
    "Spooler"                                      # Disables your printer
    "Fax"                                          # Disables fax
    "fhsvc"                                        # Disables fax histroy
    "stisvc"                                       # Disables Windows Image Acquisition (WIA)
    "AJRouter"                                     # Disables (needed for AllJoyn Router Service)
    "MSDTC"                                        # Disables Distributed Transaction Coordinator
    "WpcMonSvc"                                    # Disables Parental Controls
    "PhoneSvc"                                     # Disables Phone Service(Manages the telephony state on the device)
    "PrintNotify"                                  # Disables Windows printer notifications and extentions
    "PcaSvc"                                       # Disables Program Compatibility Assistant Service
    "RmSvc"                                        # Disable Radio Management Service
    "WPDBusEnum"                                   # Disables Portable Device Enumerator Service
    "seclogon"                                     # Disables Secondary Logon(disables other credentials only password will work)
    "lmhosts"                                      # Disables TCP/IP NetBIOS Helper
    "wisvc"                                        # Disables Windows Insider program(Windows Insider will not work)
    "FontCache"                                    # Disables Windows font cache
    "RetailDemo"                                   # Disables RetailDemo whic is often used when showing your device
    "ALG"                                          # Disables Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
    "SCardSvr"                                     # Disables Windows smart card
    "EntAppSvc"                                    # Disables enterprise application management.
    "Browser"                                      # Disables computer browser
    "iphlpsvc"                                     # Disables ipv6 but most websites don't use ipv6 they use ipv4                             
    "SEMgrSvc"                                     # Disables Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
    "PNRPsvc"                                      # Disables peer Name Resolution Protocol ( some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
    "p2psvc"                                       # Disbales Peer Name Resolution Protocol(nables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)
    "p2pimsvc"                                     # Disables Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly.Discord will still work)
    "PerfHost"                                     # Disables remote users and 64-bit processes to query performance .
    "RtkBtManServ"                                 # Disables Realtek Bluetooth Device Manager Service
    "QWAVE"                                        # Disables Quality Windows Audio Video Experience (audio and video might sound worse)
    "gupdate"                                      # Disables google update
    "gupdatem"                                     # Disable another google update
    "HvHost"                                       # Disables Hyper-V Host service
    "vmickvpexchange"                              
    "vmicguestinterface"
    "vmicshutdown"
    "vmicheartbeat"
    "vmicvmsession"
    "vmicrdv"
    "vmictimesync" 
    )

    foreach ($service in $services) {
        # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

        Write-Host "Setting $service StartupType to Manual"
        Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
    }

    # Sevice tweaks to Disabled

    $services = @(
    "BthAvctpSvc"				    # Disables AVCTP service (if you use  Bluetooth Audio Device or Wireless Headphones. then don't disable this)
    "DPS"
    "dmwappushservice"
    "edgeupdate"                                    # Disables one of edge update service  
    "MicrosoftEdgeElevationService"                 # Disables one of edge  service 
    "edgeupdatem"                                  # disbales another one of update service (disables edgeupdatem)
    "GoogleChromeElevationService"
    "lfsvc"
    "RpcLocator"
    "WpnService"                                    #Disables WpnService (Push Notifications may not work )
    "XblAuthManager"                               # Xbox Live Auth Manager
    "XblGameSave"                                  # Xbox Live Game Save Service
    "XboxNetApiSvc"                                # Xbox Live Networking Service
    "XboxGipSvc"                                   #Disables Xbox Accessory Management Service
    "WSearch"                                      # Windows Search
    "RasAuto"
    "RasMan"
    "SessionEnv"
    "TermService"
    "RmSvc"

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
    Write-Host "Disabled Defender...Please Restart"
    $ResultText.text = "`r`n" + "`r`n" + "Disabled Defender" + "`r`n" + "`r`n" + "Restart to take effect"
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
    Write-Host "Enabled Defender...Please Restart"
    $ResultText.text = "`r`n" + "`r`n" + "Enabled Defender" + "`r`n" + "`r`n" + "Restart to take effect"
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
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach-Object {
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
    $ResultText.text = "`r`n" +"`r`n" + "Set Update Settings to Security Updates Only"
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
    $ResultText.text = "`r`n" + "`r`n" + "Disabled Action Center and Notifications" + "`r`n" + "`r`n" + "Restart to take effect"
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
    Write-Host "Adjusted visual effects for performance...Restart to take effect"
    $ResultText.text = "`r`n" +"`r`n" + "Adjusted VFX for performance" + "`r`n" + "`r`n" + "Restart to take effect"
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
    Write-Host "Visual effects are set for appearance (Defaults)...Restart to take effect"
    $ResultText.text = "`r`n" +"`r`n" + "Visual effects are set for appearance (Defaults)" + "`r`n" + "`r`n" + "Restart to take effect"
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
    Write-Host "Disabled and Uninstalled OneDrive"
    $ResultText.text = "`r`n" +"`r`n" + "Disabled and Uninstalled OneDrive"
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
	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach-Object {
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
	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach-Object {
		Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
		Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
	}
    Write-Host "You may need to Reboot and right-click Your Phone app and select repair"
    $ResultText.text = "`r`n" +"`r`n" + "You may need to Reboot and right-click Your Phone app and select repair"
})

$blockthespot.Add_Click({
    Write-Host "Installing script"
    $ResultText.text = "`r`n" +"`r`n" + "Installing script"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1') } -UninstallSpotifyStoreEdition -RemoveAdPlaceholder"
    Write-Host "Blocked Spotify Ads"
    $ResultText.text = "`r`n" +"`r`n" + "Blocked Spotify Ads"
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
