# === IA SETTINGS ===

function Invoke-IASettings {
    try { Clear-Host } catch {}
    
    Import-Module PwshSpectreConsole -ErrorAction SilentlyContinue
    
    "Gerenciador de Chaves de API do NTC Shell" | Format-SpectrePanel -Title "⚙️ IA Settings" -Border Rounded | Out-SpectreHost
    
    # Verifica chaves de usuário
    $gemini = if ([Environment]::GetEnvironmentVariable("GEMINI_API_KEY", "User")) { "[green]OK[/]" } else { "[red]Ausente[/]" }
    $anthropic = if ([Environment]::GetEnvironmentVariable("ANTHROPIC_API_KEY", "User")) { "[green]OK[/]" } else { "[red]Ausente[/]" }
    $deepseek = if ([Environment]::GetEnvironmentVariable("DEEPSEEK_API_KEY", "User")) { "[green]OK[/]" } else { "[red]Ausente[/]" }
    
    Format-SpectreGrid -Data @(
        @("Gemini API Key:", $gemini),
        @("Anthropic API Key:", $anthropic),
        @("DeepSeek API Key:", $deepseek)
    ) | Format-SpectrePanel -Border Rounded | Out-SpectreHost
    
    Write-Host ""
    Write-Host "  Use o painel do Windows (Win + R -> sysdm.cpl) para configurar as chaves 'Ausentes'." -ForegroundColor DarkGray
    Write-Host "  Use o atalho [3] ou digite 'switch-model <nome>' para alterar o modelo." -ForegroundColor DarkGray
    Write-Host ""
}
