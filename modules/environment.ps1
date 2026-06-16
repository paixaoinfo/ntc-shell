# === AMBIENTE E TEMA ===

# Localiza o Oh My Posh
$ohMyPoshPaths = @(
    "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\oh-my-posh.exe",
    "$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe",
    "C:\Program Files (x86)\oh-my-posh\bin\oh-my-posh.exe"
)
$ohMyPoshExe = $null
foreach ($p in $ohMyPoshPaths) {
    if (Test-Path $p) { $ohMyPoshExe = $p; break }
}

$ohMyPoshConfig = "$env:USERPROFILE\Documents\antigravity\TERMINAL\themes\ntc-zen.omp.json"

if ($ohMyPoshExe) {
    if (Test-Path $ohMyPoshConfig) {
        & $ohMyPoshExe init pwsh --config $ohMyPoshConfig | Invoke-Expression
    } else {
        & $ohMyPoshExe init pwsh | Invoke-Expression
    }
}

# === PSReadLine ===
$psrl = Get-Module -Name PSReadLine -ListAvailable | Select-Object -First 1
if ($psrl) {
    try {
        Set-PSReadLineOption -PredictionSource History -ErrorAction Stop
        Set-PSReadLineOption -PredictionViewStyle InlineView -ErrorAction Stop
        Set-PSReadLineOption -HistoryNoDuplicates
        Set-PSReadLineOption -BellStyle None
    } catch {}
}

# === FZF ===
$ntcFzfDir = "$env:USERPROFILE\AppData\Local\Programs\fzf"
if ((Test-Path "$ntcFzfDir\fzf.exe") -and ($env:Path -notlike "*$ntcFzfDir*")) {
    $env:Path = "$ntcFzfDir;$env:Path"
}
try {
    $fzfPaths = @(
        "$env:USERPROFILE\scoop\apps\fzf\current\fzf.exe",
        "C:\ProgramData\chocolatey\lib\fzf\tools\fzf.exe",
        "$env:USERPROFILE\.fzf\bin\fzf.exe"
    )
    foreach ($fp in $fzfPaths) {
        if (Test-Path $fp) {
            Set-Alias fzf $fp -Scope Global
            break
        }
    }
    if (Get-Command fzf -ErrorAction SilentlyContinue) {
        Set-PSReadLineKeyHandler -Key Ctrl+t -Function PossibleCompletion
    }
} catch {}

function Set-NtcPrompt {
    $host.UI.RawUI.WindowTitle = "NTC Shell"
}
Set-NtcPrompt
