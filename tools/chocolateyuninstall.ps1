$ErrorActionPreference = 'Stop'; # stop on all errors
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'PolyMC*'
}

Write-Host "Removing Start Menu and Desktop shortcuts"
$StartMenuShortcut = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs\PolyMC.lnk"
$DesktopShortcut = Join-Path $([Environment]::GetFolderPath("Desktop")) "PolyMC.lnk"
if (Test-Path $StartMenuShortcut)
{
  Remove-Item $StartMenuShortcut
}
if (Test-Path $DesktopShortcut)
{
  Remove-Item $DesktopShortcut
}
