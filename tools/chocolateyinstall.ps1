$ErrorActionPreference = 'Stop'; # stop on all errors
$pp         = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path "$(Get-ToolsLocation)" "PolyMC"

# Read parameter to decide if we install standard or legacy
if (!$pp['legacy']) {
  $url      = 'https://github.com/PolyMC/PolyMC/releases/download/1.4.0/PolyMC-Windows-1.4.0.zip'
  $checksum = '89da603458deb29c3e9ad71801fb679d7b06ba1937d305b7a27360bde1df6670'
}
else {
  $url      = 'https://github.com/PolyMC/PolyMC/releases/download/1.4.0/PolyMC-Windows-Legacy-1.4.0.zip'
  $checksum = '4f52c6b002a2d33027ac5e51b5b91f42e6460473834a7b701d7740680871c57c'
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
