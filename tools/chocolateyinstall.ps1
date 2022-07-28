$ErrorActionPreference = 'Stop'; # stop on all errors
$pp         = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path "$(Get-ToolsLocation)" "PolyMC"

# Read parameter to decide if we install standard or legacy
if (!$pp['legacy']) {
  $url      = 'https://github.com/PolyMC/PolyMC/releases/download/1.4.1/PolyMC-Windows-1.4.1.zip'
  $checksum = '702d833313318fe8e3dbafc9540d0db23b1a4c6f682283aaa6b302886c5f1aee'
}
else {
  $url      = 'https://github.com/PolyMC/PolyMC/releases/download/1.4.1/PolyMC-Windows-Legacy-1.4.1.zip'
  $checksum = '71268c2d508446c758fedc6a8c96e94de2e8309a13693711d79d6d6a02dcc2c0'
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
