# NTC Shell (Neves Terminal Command) - Profile
# AI-Native Terminal Environment - Refatorado (Orquestrador)

# Ponto de entrada leve. Importa dinamicamente todos os módulos.
$modulesPath = Join-Path $PSScriptRoot "modules"

if (Test-Path $modulesPath) {
    # Carrega ambiente, funções e aliases
    $modules = @("environment.ps1", "functions.ps1", "aliases.ps1")
    foreach ($module in $modules) {
        $modulePath = Join-Path $modulesPath $module
        if (Test-Path $modulePath) {
            . $modulePath
        }
    }

    # Carrega o banner no final
    $bannerPath = Join-Path $modulesPath "banner.ps1"
    if (Test-Path $bannerPath) {
        . $bannerPath
    }
} else {
    Write-Host "ERRO: Diretório 'modules' não encontrado em $PSScriptRoot" -ForegroundColor Red
}
