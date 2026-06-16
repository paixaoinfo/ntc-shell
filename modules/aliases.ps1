# Caminho: TERMINAL/modules/aliases.ps1
# Autor: Leandro Paixão (Architect)

function global:set-key {
    param([string]$service)
    if (-not $service) {
        Write-Host "Uso: set-key [gemini | anthropic | deepseek | xai | openai]" -ForegroundColor Yellow
        return
    }
    $key = Read-Host "Insira a chave de API para [$service]"
    if ($key) {
        [System.Environment]::SetEnvironmentVariable("$($service.ToUpper())_API_KEY", $key, "User")
        Set-Item -Path "env:\$($service.ToUpper())_API_KEY" -Value $key
        Write-Host "Chave para [$service] configurada com sucesso!" -ForegroundColor Green
    }
}

function global:switch-env {
    param([string]$envName)
    if (-not $envName) {
        Write-Host "Uso: switch-env [staging | production]" -ForegroundColor Yellow
        return
    }
    $envClean = $envName.ToLower()
    $currentDir = (Get-Item .).Name.ToUpper()

    if ($envClean -eq "production") {
        $env:ACTIVE_CLOUD_PROJECT = "$currentDir (PRODUCTION)"
        Write-Host "ALERTA: Entrou no ambiente de PRODUÇÃO de $currentDir!" -ForegroundColor Red
    } else {
        $env:ACTIVE_CLOUD_PROJECT = "$currentDir (STAGING)"
        Write-Host "Ambiente alterado para Testes/Staging de $currentDir." -ForegroundColor Yellow
    }

    if (Test-Path "firebase.json") {
        Write-Host "Atualizando o contexto do Firebase para: $envClean" -ForegroundColor Cyan
        firebase use $envClean
    }

    Show-NtcDashboard
}

function global:switch-model {
    param([string]$model)

    if (-not $model) {
        Show-NtcDashboard
        Write-Host "`n[Menu Switcher] Escolha uma IA passando o parâmetro correspondente:" -ForegroundColor Purple
        Write-Host "  n2 pro         -> Google Gemini Pro (Raciocínio)" -ForegroundColor Cyan
        Write-Host "  n2 flash       -> Google Gemini Flash (Velocidade/Economia)" -ForegroundColor Cyan
        Write-Host "  n2 sonnet      -> Anthropic Claude 3.5 Sonnet (Padrão Ouro)" -ForegroundColor Magenta
        Write-Host "  n2 haiku       -> Anthropic Claude 3.5 Haiku (Leve/Rápido)" -ForegroundColor Magenta
        Write-Host "  n2 r1          -> DeepSeek R1 (Raciocínio avançado)" -ForegroundColor White
        Write-Host "  n2 v3          -> DeepSeek V3 (Chat veloz)" -ForegroundColor White
        Write-Host "  n2 grok        -> xAI Grok 4.3 (Raciocínio avançado)" -ForegroundColor Green
        Write-Host "  n2 grok-fast   -> xAI Grok Build 0.1 (Agente/Chat rápido)" -ForegroundColor Green
        Write-Host "  n2 local       -> Ollama Local Llama 3 (100% Offline/Seguro)" -ForegroundColor Yellow
        Write-Host "  n2 local-r1    -> Ollama Local DeepSeek R1 (Raciocínio Offline)" -ForegroundColor Yellow
        return
    }

    $mClean = $model.ToLower()

    switch ($mClean) {
        # --- ECOSSISTEMA GOOGLE GEMINI ---
        "pro" {
            $env:ACTIVE_LLM_MODEL = "Gemini Pro"
            $env:AI_PROVIDER = "google"
            $env:AI_MODEL_NAME = "gemini-2.5-pro"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para Google Gemini Pro (Cérebro Avançado)." -ForegroundColor Green
        }
        "flash" {
            $env:ACTIVE_LLM_MODEL = "Gemini Flash"
            $env:AI_PROVIDER = "google"
            $env:AI_MODEL_NAME = "gemini-2.5-flash"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para Google Gemini Flash (Economia & Velocidade)." -ForegroundColor Green
        }
        
        # --- ECOSSISTEMA ANTHROPIC CLAUDE ---
        "sonnet" {
            $env:ACTIVE_LLM_MODEL = "Claude Sonnet"
            $env:AI_PROVIDER = "anthropic"
            $env:AI_MODEL_NAME = "claude-3-5-sonnet-latest"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para Anthropic Claude 3.5 Sonnet (Padrão Ouro)." -ForegroundColor Green
        }
        "haiku" {
            $env:ACTIVE_LLM_MODEL = "Claude Haiku"
            $env:AI_PROVIDER = "anthropic"
            $env:AI_MODEL_NAME = "claude-3-5-haiku-latest"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para Anthropic Claude 3.5 Haiku (Rápido)." -ForegroundColor Green
        }

        # --- ECOSSISTEMA DEEPSEEK ---
        "r1" {
            $env:ACTIVE_LLM_MODEL = "DeepSeek R1"
            $env:AI_PROVIDER = "deepseek"
            $env:AI_MODEL_NAME = "deepseek-reasoner"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para DeepSeek R1 (Deep Think Ativado)." -ForegroundColor Green
        }
        "v3" {
            $env:ACTIVE_LLM_MODEL = "DeepSeek V3"
            $env:AI_PROVIDER = "deepseek"
            $env:AI_MODEL_NAME = "deepseek-chat"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para DeepSeek V3 (Chat Express)." -ForegroundColor Green
        }

        # --- ECOSSISTEMA xAI GROK ---
        "grok" {
            $env:ACTIVE_LLM_MODEL = "Grok 4.3"
            $env:AI_PROVIDER = "xai"
            $env:AI_MODEL_NAME = "grok-4.3"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para xAI Grok 4.3 (Refatoração de Elite)." -ForegroundColor Green
        }
        "grok-fast" {
            $env:ACTIVE_LLM_MODEL = "Grok Build 0.1"
            $env:AI_PROVIDER = "xai"
            $env:AI_MODEL_NAME = "grok-build-0.1"
            $env:AI_ENDPOINT = "cloud"
            Write-Host "IA alterada para xAI Grok Build 0.1 (Agente Ágil)." -ForegroundColor Green
        }

        # --- ECOSSISTEMA OFFLINE LOCAL (OLLAMA) ---
        "local" {
            $env:ACTIVE_LLM_MODEL = "Ollama Local (Llama 3)"
            $env:AI_PROVIDER = "ollama"
            $env:AI_MODEL_NAME = "llama3:latest"
            $env:AI_ENDPOINT = "http://localhost:11434"
            Write-Host "ALERTA: Modo 100% Local e Offline Ativado via Ollama!" -ForegroundColor Cyan
        }
        "local-r1" {
            $env:ACTIVE_LLM_MODEL = "Ollama Local (DeepSeek R1)"
            $env:AI_PROVIDER = "ollama"
            $env:AI_MODEL_NAME = "deepseek-r1:8b"
            $env:AI_ENDPOINT = "http://localhost:11434"
            Write-Host "ALERTA: DeepSeek R1 Local Ativado via Ollama!" -ForegroundColor Cyan
        }

        Default {
            Write-Host "Modelo desconhecido. Digite 'n2' para ver a lista de opções suportadas." -ForegroundColor Red
            return
        }
    }

    # Atualiza o cockpit visual instantaneamente
    Show-NtcDashboard
}

# --- COMANDO DE LINGUAGEM NATURAL REAL (??) ---
# Captura de argumentos sem aspas e chamadas diretas via API REST para todos os provedores!
function global:Invoke-NaturalLanguage {
    $query = $args -join " "
    if (-not $query) {
        Write-Host "Uso: ?? [sua pergunta em linguagem natural]" -ForegroundColor Yellow
        return
    }

    $provider = $env:AI_PROVIDER
    $model = $env:AI_MODEL_NAME
    if (-not $provider) { 
        $provider = "google" 
        $model = "gemini-2.5-flash"
    }

    Write-Host "`n[AI-Native] Orquestrando consulta via $provider ($model)..." -ForegroundColor Cyan

    $reply = ""
    try {
        switch ($provider) {
            # --- INTEGRAÇÃO GOOGLE GEMINI ---
            "google" {
                $apiKey = $env:GEMINI_API_KEY
                if (-not $apiKey) {
                    throw "GEMINI_API_KEY não configurada. Use 'set-key gemini' para salvar sua chave."
                }
                $url = "https://generativelanguage.googleapis.com/v1beta/models/$($model):generateContent?key=$apiKey"
                $body = @{
                    contents = @(
                        @{ parts = @( @{ text = $query } ) }
                    )
                } | ConvertTo-Json -Depth 10

                $response = Invoke-RestMethod -Uri $url -Method Post -ContentType "application/json" -Body $body -TimeoutSec 20
                $reply = $response.candidates[0].content.parts[0].text
            }

            # --- INTEGRAÇÃO ANTHROPIC CLAUDE ---
            "anthropic" {
                $apiKey = $env:ANTHROPIC_API_KEY
                if (-not $apiKey) {
                    throw "ANTHROPIC_API_KEY não configurada. Use 'set-key anthropic' para salvar sua chave."
                }
                $url = "https://api.anthropic.com/v1/messages"
                $headers = @{
                    "x-api-key" = $apiKey
                    "anthropic-version" = "2023-06-01"
                    "content-type" = "application/json"
                }
                $body = @{
                    model = $model
                    max_tokens = 1024
                    messages = @( @{ role = "user"; content = $query } )
                } | ConvertTo-Json -Depth 10

                $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body -TimeoutSec 20
                $reply = $response.content[0].text
            }

            # --- INTEGRAÇÃO DEEPSEEK ---
            "deepseek" {
                $apiKey = $env:DEEPSEEK_API_KEY
                if (-not $apiKey) {
                    throw "DEEPSEEK_API_KEY não configurada. Use 'set-key deepseek' para salvar sua chave."
                }
                $url = "https://api.deepseek.com/v1/chat/completions"
                $headers = @{
                    "Authorization" = "Bearer $apiKey"
                    "Content-Type" = "application/json"
                }
                $body = @{
                    model = $model
                    messages = @( @{ role = "user"; content = $query } )
                } | ConvertTo-Json -Depth 10

                $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body -TimeoutSec 20
                $reply = $response.choices[0].message.content
            }

            # --- INTEGRAÇÃO xAI GROK ---
            "xai" {
                $apiKey = $env:XAI_API_KEY
                if (-not $apiKey) {
                    throw "XAI_API_KEY não configurada. Use 'set-key xai' para salvar sua chave."
                }
                $url = "https://api.x.ai/v1/chat/completions"
                $headers = @{
                    "Authorization" = "Bearer $apiKey"
                    "Content-Type" = "application/json"
                }
                $body = @{
                    model = $model
                    messages = @( @{ role = "user"; content = $query } )
                } | ConvertTo-Json -Depth 10

                $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body -TimeoutSec 20
                $reply = $response.choices[0].message.content
            }

            # --- INTEGRAÇÃO OLLAMA LOCAL (OFFLINE) ---
            "ollama" {
                $url = "http://localhost:11434/api/generate"
                $body = @{
                    model = $model
                    prompt = $query
                    stream = $false
                } | ConvertTo-Json -Depth 10

                $response = Invoke-RestMethod -Uri $url -Method Post -ContentType "application/json" -Body $body -TimeoutSec 30
                $reply = $response.response
            }
        }

        # Formatação e exibição estruturada da resposta
        if (Get-Command Format-SpectrePanel -ErrorAction SilentlyContinue) {
            Write-Host ""
            $safeReply = [Spectre.Console.Markup]::Escape($reply)
            $markup = [Spectre.Console.Markup]::new($safeReply)
            $panel = $markup | Format-SpectrePanel -Title " Resposta da IA ($($env:ACTIVE_LLM_MODEL)) " -Border Rounded
            $panel | Out-SpectreHost
            Write-Host ""
        } else {
            Write-Host "`n=== RESPOSTA DA IA ($($env:ACTIVE_LLM_MODEL)) ===" -ForegroundColor Green
            Write-Host $reply
            Write-Host "============================================`n" -ForegroundColor Green
        }

    } catch {
        Write-Host "❌ Falha ao consultar a inteligência artificial!" -ForegroundColor Red
        Write-Host "Detalhe do Erro: $_" -ForegroundColor DarkRed
    }
}

# --- FUNÇÃO DE NAVEGAÇÃO DE PROJETOS (WORKON) ---
function global:workon {
    param([string]$projectName)

    if (-not $projectName) {
        Write-Host "Utilização: workon [nome-do-projeto]" -ForegroundColor Yellow
        return
    }

    $path = "$HOME\Documents\antigravity\$projectName"
    if (Test-Path $path) {
        Set-Location $path
        # Inicializa o NTC IDE PRO na pasta do projeto com fallback seguro
        if (Get-Command ntc-ide -ErrorAction SilentlyContinue) {
            ntc-ide .
        } else {
            code .
        }
    } else {
        Write-Host "Projeto '$projectName' não encontrado em Documents/antigravity/" -ForegroundColor Red
    }
}

# Atalhos numéricos e navegação
function global:projetos-menu { param([string]$p) if ($p) { workon $p } else { workon } }
function global:monitor-menu { monitor }
function global:git-save-menu { param([string]$m) if ($m) { git-save $m } else { git-save } }
function global:env-switcher-menu { param([string]$e) if ($e) { switch-env $e } else { switch-env } }

# --- NTC AGENT (Motor Autônomo via Aider) ---
function global:Invoke-NtcAgent {
    $query = $args -join " "
    
    # 0. Prompt para transição para IDE
    Write-Host ""
    $choice = Read-Host "Para sua melhor produtividade iremos para o ambiente IDE, tudo bem? [Y/N]"
    if ($choice -match '^[Yy]') {
        if (Get-Command code -ErrorAction SilentlyContinue) {
            Write-Host "Abrindo NTC IDE PRO... Repita o comando lá dentro para melhor visualização!" -ForegroundColor Green
            if (Get-Command ntc-ide -ErrorAction SilentlyContinue) {
                ntc-ide .
            } else {
                code .
            }
            return
        } else {
            Write-Host "`n[Aviso] VS Code não detectado no sistema." -ForegroundColor Red
            Write-Host "Para a melhor experiência e produtividade, instale o VS Code:" -ForegroundColor Cyan
            Write-Host "Download: https://code.visualstudio.com/`n" -ForegroundColor Yellow
            Write-Host "Continuando no terminal atual..." -ForegroundColor Magenta
            Start-Sleep -Seconds 2
        }
    }

    # 1. Verifica Instalação do Aider
    if (-not (Get-Command aider -ErrorAction SilentlyContinue)) {
        Write-Host "`n[NTC Agent] Instalando o motor de IA autônomo (Aider)..." -ForegroundColor Yellow
        if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
            Write-Host "ERRO: Python/Pip não encontrado! Instale o Python primeiro." -ForegroundColor Red
            return
        }
        $pipCommand = "pip install aider-chat"
        Invoke-Expression $pipCommand
        if (-not (Get-Command aider -ErrorAction SilentlyContinue)) {
            Write-Host "ERRO: Falha ao instalar o Aider." -ForegroundColor Red
            return
        }
        Write-Host "[NTC Agent] Instalação concluída!" -ForegroundColor Green
    }

    # 2. Descobre qual IA está configurada no TUI
    $provider = $env:AI_PROVIDER
    $model = $env:AI_MODEL_NAME
    if (-not $provider) { 
        $provider = "google" 
        $model = "gemini-2.5-flash"
    }

    # 3. Formata o modelo para a sintaxe do Aider
    $aiderModel = "$provider/$model"
    # Ajuste para Ollama
    if ($provider -eq "ollama") {
        $aiderModel = "ollama_chat/$model"
    }

    # 4. Injeta e Roda o Piloto Automático
    if ($query) {
        Write-Host "`n[NTC Agent] Analisando arquitetura com $aiderModel para executar: '$query'..." -ForegroundColor Magenta
        aider --model $aiderModel --message $query
    } else {
        Write-Host "`n[NTC Agent] Abrindo console interativo autônomo com $aiderModel..." -ForegroundColor Magenta
        aider --model $aiderModel
    }
}

Set-Alias -Name n1 -Value projetos-menu -Scope Global -ErrorAction SilentlyContinue
Set-Alias -Name n2 -Value switch-model -Scope Global -ErrorAction SilentlyContinue
Set-Alias -Name n3 -Value monitor-menu -Scope Global -ErrorAction SilentlyContinue
Set-Alias -Name n4 -Value git-save-menu -Scope Global -ErrorAction SilentlyContinue
Set-Alias -Name n5 -Value env-switcher-menu -Scope Global -ErrorAction SilentlyContinue
Set-Alias -Name "??" -Value Invoke-NaturalLanguage -Scope Global -ErrorAction SilentlyContinue
Set-Alias -Name "!!" -Value Invoke-NtcAgent -Scope Global -ErrorAction SilentlyContinue
