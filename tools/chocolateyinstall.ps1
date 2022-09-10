$ErrorActionPreference = 'Stop'; # stop on all errors
$pp         = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path "$(Get-ToolsLocation)" "PolyMC"

# Read parameter to decide if we install standard or legacy
if (!$pp['legacy']) {
  $url      = 'https://github.com/PolyMC/PolyMC/releases/download/1.4.2/PolyMC-Windows-1.4.2.zip'
  $checksum = '368b17560fd9571483b5915ba56b155f06b3963c7e6371fc8eb0cef1a3eb18ee'
}
else {
  $url      = 'https://github.com/PolyMC/PolyMC/releases/download/1.4.2/PolyMC-Windows-Legacy-1.4.2.zip'
  $checksum = '03facfa98a8e26290e7a597a8f4876a06474e0217c344f0ec4015f630df81e64'
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url
  softwareName  = 'PolyMC*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "Creating Start Menu and Desktop shortcuts"
$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $startmenu "PolyMC.lnk") -TargetPath $(Join-Path $installDir "PolyMC.exe")
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $desktop "PolyMC.lnk") -TargetPath $(Join-Path $installDir "PolyMC.exe")
