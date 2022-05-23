$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path "$(Get-ToolsLocation)" "PolyMC"
$url        = 'https://github.com/PolyMC/PolyMC/releases/download/1.3.0/PolyMC-Windows-x86_64-1.3.0.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url
  softwareName  = 'PolyMC*'
  checksum      = 'cb11189b7185d9395ff9c9676f78c0d2c4a48b489fcd7e90e4198608a64efab4'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "Creating Start Menu and Desktop shortcuts"
$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $startmenu "PolyMC.lnk") -TargetPath $(Join-Path $installDir "PolyMC.exe")
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $desktop "PolyMC.lnk") -TargetPath $(Join-Path $installDir "PolyMC.exe")
