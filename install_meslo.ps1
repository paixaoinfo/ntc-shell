$ErrorActionPreference = "Stop"
Write-Host "Baixando a fonte Meslo Nerd Font..." -ForegroundColor Cyan

$url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip"
$zipPath = "$env:TEMP\Meslo.zip"
$extractPath = "$env:TEMP\MesloFont"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $url -OutFile $zipPath -UseBasicParsing

if (Test-Path $extractPath) { Remove-Item -Recurse -Force $extractPath }
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

$fonts = Get-ChildItem -Path $extractPath -Filter "*.ttf"
$fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

if (-not (Test-Path $fontDir)) {
    New-Item -ItemType Directory -Path $fontDir -Force | Out-Null
}

$regKey = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"

Write-Host "Instalando fontes localmente..." -ForegroundColor Cyan
foreach ($font in $fonts) {
    $destFile = Join-Path $fontDir $font.Name
    Copy-Item -Path $font.FullName -Destination $destFile -Force
    
    $fontName = $font.BaseName + " (TrueType)"
    try {
        New-ItemProperty -Path $regKey -Name $fontName -Value $font.Name -PropertyType String -Force | Out-Null
    } catch {}
}

Write-Host "Fonte instalada com sucesso!" -ForegroundColor Green
