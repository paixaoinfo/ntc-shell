# NTC Shell - Setup Script
# Neves Terminal Command v1.0

Write-Host "NTC Shell Setup" -ForegroundColor Cyan
Write-Host "===============" -ForegroundColor Cyan

# 1. Check prerequisites
$checks = @(
    @{Name="PowerShell 7+"; Test={Test-Path "$env:USERPROFILE\AppData\Local\Programs\PowerShell\7\pwsh.exe"}},
    @{Name="Git"; Test={Get-Command git -ErrorAction SilentlyContinue}},
    @{Name="Windows Terminal"; Test={Get-AppxPackage -Name "Microsoft.WindowsTerminal" -ErrorAction SilentlyContinue}},
    @{Name="Oh My Posh"; Test={Get-Command oh-my-posh -ErrorAction SilentlyContinue}},
    @{Name="MesloLGS Nerd Font"; Test={Test-Path "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\MesloLGSNerdFont-Regular.ttf"}},
    @{Name="FZF"; Test={Get-Command fzf -ErrorAction SilentlyContinue}}
)

foreach ($check in $checks) {
    if (& $check.Test) {
        Write-Host "  [OK] $($check.Name)" -ForegroundColor Green
    } else {
        Write-Host "  [!!] $($check.Name) - NOT FOUND" -ForegroundColor Red
    }
}

# 2. Install profile
$profileDir = Split-Path $profile.CurrentUserCurrentHost -Parent
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

$repoProfile = Join-Path $PSScriptRoot "Microsoft.PowerShell_profile.ps1"
if (Test-Path $repoProfile) {
    Copy-Item -Path $repoProfile -Destination $profile.CurrentUserCurrentHost -Force
    Write-Host "  Profile installed to $($profile.CurrentUserCurrentHost)" -ForegroundColor Green
}

Write-Host "`nSetup complete! Restart your terminal to apply changes." -ForegroundColor Cyan
