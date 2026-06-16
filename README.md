# 🚀 NTC Shell (Neves Terminal Command)

> **Cockpit Agnóstico, AI-Native e de Alta Performance**
> Desenvolvido por **Leandro Paixão** - [LinkedIn](https://linkedin.com/in/leandro-paixao-26b207308)

---

## 📖 1. Introdução

O **NTC Shell** não é apenas um terminal; é um verdadeiro cérebro de orquestração local. Projetado com uma estética minimalista *Apple-Style* (Zen), ele unifica o poder das Inteligências Artificiais modernas (Gemini, Anthropic, DeepSeek, xAI e Ollama Local) com uma Interface de Terminal (TUI) rica e fluida.

O objetivo é centralizar operações DevOps, atalhos de rotina e integrações Multi-Cloud (sem sacrificar a velocidade), atuando também como um **Engenheiro de Software Autônomo** capaz de programar junto com você.

---

## ⚙️ 2. Pré-requisitos

Para que o NTC Shell alcance sua performance e visual máximos, seu ambiente precisará de:

- **PowerShell 7+** (Core)
- **Windows Terminal**
- **Oh My Posh** (Para o prompt decorativo)
- **Fonte**: MesloLGS NF (Nerd Font para renderização de ícones)
- **Python/Pip** (Obrigatório caso deseje usar o NTC Agent Automático)

---

## 🛠️ 3. Instalação do Zero (Guia de Sobrevivência)

### Passo 3.1: Instalar Dependências (Nativo)

**No Windows (via Winget):**
```powershell
winget install Microsoft.PowerShell
winget install Microsoft.WindowsTerminal
winget install JanDeDobbeleer.OhMyPosh -s winget
```

### Passo 3.2: Configurar o Diretório do NTC
Clone ou mova a pasta base para o seu diretório local. Recomenda-se o caminho:
`~\Documents\antigravity\TERMINAL`

### Passo 3.3: Injetar o Orquestrador no `$PROFILE`
Abra o seu perfil do PowerShell executando o comando abaixo e insira o código de inicialização:
```powershell
code $PROFILE
```

Insira no arquivo:
```powershell
# Importação do módulo de TUI
if (-not (Get-Module -Name PwshSpectreConsole)) {
    Import-Module PwshSpectreConsole -ErrorAction SilentlyContinue
}

$NtcDir = "$env:USERPROFILE\Documents\antigravity\TERMINAL"
. "$NtcDir\modules\aliases.ps1"
. "$NtcDir\modules\tui.ps1"

Show-NtcDashboard
```

---

## 🔑 4. Configuração Inicial e Radar de Chaves

Antes de utilizar as integrações de IA, você precisará configurar suas chaves de API. O TUI do NTC Shell possui um **Radar Dinâmico de Conexão** no cabeçalho, que exibe um `✓ Online` caso a sua IA selecionada tenha uma chave válida instalada (ou se o servidor local Ollama estiver respirando).

Execute o comando interativo:
```powershell
set-key gemini
# Outras opções: anthropic, deepseek, xai, openai
```
Sua chave será salva de forma invisível nas variáveis de ambiente persistentes (`User`).

---

## 🎯 5. Cockpit e Comandos de Operação (Cheat Sheet)

Abaixo estão os atalhos unificados orquestrados pelo seu Dashboard:

| Atalho | Comando Completo | O que faz? |
| :---: | :--- | :--- |
| **`n1`** | `projetos` | Navega e abre Workspaces no Antigravity IDE. |
| **`n2`** | `switch-model` | Altera a IA de forma dinâmica. Ex: `n2 flash`, `n2 sonnet`, `n2 r1`, `n2 grok`, `n2 local`. O TUI se adapta à paleta de cores de cada marca. |
| **`n3`** | `monitor` | Rastreamento unificado de Portas, Containers e Serviços. |
| **`n4`** | `git-save` | Comita mudanças no Git com mensagens geradas automaticamente pela IA. |
| **`n5`** | `env-switch` | Alterna os servidores e o contexto do sistema entre `staging` e `production`. |

---

## 🤖 6. O Poder da IA no Terminal (?? e !!)

O NTC Shell transforma seu terminal numa central de Engenharia DevOps utilizando as LLMs que você escolheu no `n2`.

### 🧠 Modo Consultor ChatGPT (`??`)
Você não precisa sair do terminal para consultar a IA. Ele fará requisições de texto via REST diretamente para os motores da Google, Anthropic, xAI ou DeepSeek.
Use o operador `??` sem aspas caso deseje conversar livremente.

**Exemplos:**
```powershell
?? como listar portas abertas no linux
?? me explique o padrão observer
```
*(Ele apenas fala, não edita arquivos. Ótimo para dúvidas rápidas e documentação).*

### 🛠️ Modo Agente Engenheiro Autônomo (`!!` ou `Invoke-NtcAgent`)
Esse é o superpoder de programação do NTC. Usando a engine do *Aider* por baixo dos panos, o NTC invoca um Agente Autônomo que **lê seus arquivos, refatora seu código e commita sozinho**.

1. Na primeira execução, se você não tiver o motor instalado, o NTC Agent faz o bootstrapping baixando tudo pelo `pip` sozinho.
2. Ele traduz dinamicamente a sua IA selecionada no painel (`n2 flash`) para a sintaxe do Agente (`gemini/gemini-2.5-flash`).

**Exemplos:**
```powershell
!! conserte o erro no botão IR do arquivo script.js
!! crie um componente de formulário de login no React
```
*(Se você digitar apenas `!!`, ele abrirá a sessão interativa do Aider já orquestrada para o seu modelo).*

---

> **Aviso de Customização da Marca**: 
> Para alterar as credenciais ou títulos (Ex: `"Cockpit de Alta Performance"`), edite o arquivo `modules/tui.ps1`.
