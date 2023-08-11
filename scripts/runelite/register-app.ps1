if ($global -and (-not $is_admin)) {
    Write-Host "ERROR writing to registry for global installation requires admin rights" -ForegroundColor DarkRed
    exit 1
}

$reg_root = if ($global) { [Microsoft.Win32.Registry]::LocalMachine } else { [Microsoft.Win32.Registry]::CurrentUser }
$reg_path = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher'
$reg = $reg_root.CreateSubKey($reg_path)

$reg.SetValue("DisplayIcon", "$dir\\RuneLite.exe", [Microsoft.Win32.RegistryValueKind]::String)
$reg.SetValue("DisplayName", "RuneLite", [Microsoft.Win32.RegistryValueKind]::String)
$reg.SetValue("DisplayVersion", "$version", [Microsoft.Win32.RegistryValueKind]::String)
$reg.SetValue("InstallLocation", "$dir", [Microsoft.Win32.RegistryValueKind]::String)
$reg.SetValue("Publisher", "RuneLite", [Microsoft.Win32.RegistryValueKind]::String)
$reg.SetValue("UninstallString", "scoop uninstall $app", [Microsoft.Win32.RegistryValueKind]::String)

$reg.Close()
