# Caminho: TERMINAL/modules/tui.ps1
# Autor: Leandro Paixão (Architect)

function Show-NtcDashboard {
    # 1. Obtém as variáveis da IA Ativa
    $activeIA = $env:ACTIVE_LLM_MODEL
    $provider = $env:AI_PROVIDER
    $modelName = $env:AI_MODEL_NAME

    if (-not $activeIA) { 
        $activeIA = "Gemini Flash" 
        $provider = "google"
        $modelName = "gemini-2.5-flash"
    }

    # Customiza as cores do cabeçalho de acordo com a identidade visual do provedor
    $iaColor = "bold cyan"
    switch ($provider) {
        "google"    { $iaColor = "bold cyan" }       # Azul/Ciano do Google
        "anthropic" { $iaColor = "bold magenta" }    # Laranja/Magenta do Claude
        "deepseek"  { $iaColor = "bold white" }      # Azul escuro/Branco do DeepSeek
        "xai"       { $iaColor = "bold green" }      # Verde Matrix do Grok
        "ollama"    { $iaColor = "bold yellow" }     # Amarelo do Ollama Local
    }

    # 2. Sensor Inteligente de Firebase Local (Auto-Detectar Projeto Ativo)
    $activeServer = $env:ACTIVE_CLOUD_PROJECT
    if (-not $activeServer) {
        if (Test-Path ".firebase/active-project") {
            $firebaseProject = (Get-Content ".firebase/active-project" -Raw).Trim()
            if ($firebaseProject -match "^{") {
                try {
                    $json = ConvertFrom-Json $firebaseProject
                    $firebaseProject = $json.default
                } catch {}
            }
            $activeServer = "FIREBASE ($($firebaseProject.ToUpper()))"
        } else {
            $activeServer = "LOCAL (Desenvolvimento)"
        }
    }

    # Definição de cor visual de segurança para o Servidor
    $serverColor = "grey"
    if ($activeServer -match "PRODUCTION") {
        $serverColor = "bold red blink"
    } elseif ($activeServer -match "STAGING" -or $activeServer -match "FIREBASE") {
        $serverColor = "bold yellow"
    }

    # Verifica Status da Conexão
    $iaStatus = "[bold red]✗ (Sem Chave)[/]"
    switch ($provider) {
        "google" { if ($env:GEMINI_API_KEY) { $iaStatus = "[bold green]✓ Online[/]" } }
        "anthropic" { if ($env:ANTHROPIC_API_KEY) { $iaStatus = "[bold green]✓ Online[/]" } }
        "deepseek" { if ($env:DEEPSEEK_API_KEY) { $iaStatus = "[bold green]✓ Online[/]" } }
        "xai" { if ($env:XAI_API_KEY) { $iaStatus = "[bold green]✓ Online[/]" } }
        "ollama" { 
            try {
                $null = Invoke-WebRequest -Uri "http://localhost:11434" -UseBasicParsing -TimeoutSec 1 -ErrorAction Stop
                $iaStatus = "[bold green]✓ Online[/]"
            } catch {
                $iaStatus = "[bold red]✗ Off[/]"
            }
        }
    }

    # 3. Desenho do Cabeçalho de Alta Performance
    $headerText = @"
[bold cyan]NTC Shell v3.0[/] | [$iaColor]IA:[/] $activeIA ($modelName) $iaStatus | [bold $serverColor]Servidor:[/] $activeServer
[grey]Diretório Atual:[/] $((Get-Location).Path)
"@
    $headerMarkup = [Spectre.Console.Markup]::new($headerText)
    $headerPanel = $headerMarkup | Format-SpectrePanel -Title " Cockpit de Alta Performance | by Leandro Paixão (linkedin.com/in/leandro-paixao-26b207308/) " -Border Rounded

    # 4. Grid de comandos simétrico
    $gridText = @"
[bold yellow]n1 (projetos)[/]    -> Navegar e abrir Workspace no Antigravity IDE (Ex: n1 hpc-mentor)
[bold magenta]n2 (switcher)[/]    -> Alternar cérebro da IA (Ex: n2 pro, n2 sonnet, n2 r1, n2 grok, n2 local)
[bold cyan]n3 (monitor)[/]    -> Status de Portas, Containers e Serviços Multi-Cloud
[bold green]n4 (git-save)[/]   -> Commits inteligentes automatizados por IA (Ex: n4 `"fix api`")
[bold yellow]n5 (env-switch)[/] -> Alternar entre Staging e Produção do Cliente (Ex: n5 staging)
"@
    $gridMarkup = [Spectre.Console.Markup]::new($gridText)
    $gridPanel = $gridMarkup | Format-SpectrePanel -Title " Atalhos de Controle de Infraestrutura (Digite o comando ou use n1-n5) " -Border Rounded

    $footerText = "[bold green]➜ ~[/] NTC Shell carregado. Pronto para a orquestração multi-cloud, Arquiteto Paixão..."

    # Limpa e desenha o Cockpit
    try { [console]::Clear() } catch { Clear-Host }
    $headerPanel | Out-SpectreHost
    Write-Host ""
    $gridPanel | Out-SpectreHost
    Write-Host ""
    Write-Host ""
    Write-SpectreHost $footerText -ErrorAction SilentlyContinue
}
