$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path "$(Get-ToolsLocation)" "PolyMC"
$url        = 'https://github.com/PolyMC/PolyMC/releases/download/1.3.2/PolyMC-Windows-x86_64-1.3.2.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url
  softwareName  = 'PolyMC*'
  checksum      = 'a186ed232cb51100c4a7ddb01d5e77c31fc188ba48b9ac20fac38975bc168483'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "Creating Start Menu and Desktop shortcuts"
$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $startmenu "PolyMC.lnk") -TargetPath $(Join-Path $installDir "PolyMC.exe")
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $desktop "PolyMC.lnk") -TargetPath $(Join-Path $installDir "PolyMC.exe")
