# === NTC SHELL FUNCTIONS ===
function global:workon {
    param([string]$ProjectName)
    $projectsRoot = "$env:USERPROFILE\Documents\antigravity"
    $projectPath = Join-Path -Path $projectsRoot -ChildPath $ProjectName
    if (Test-Path $projectPath) {
        Set-Location $projectPath
        $envFile = Join-Path $projectPath ".env"
        if (Test-Path $envFile) {
            Get-Content $envFile | ForEach-Object {
                if ($_ -match "^\s*([^#=]+)=(.*)") {
                    $key = $matches[1].Trim()
                    $value = $matches[2].Trim()
                    [Environment]::SetEnvironmentVariable($key, $value, "Process")
                }
            }
            Write-Host "  .env loaded" -ForegroundColor Green
        }
        if (Get-Command ntc-ide -ErrorAction SilentlyContinue) {
            ntc-ide $projectPath
            Write-Host "  NTC IDE PRO opened" -ForegroundColor Cyan
        } elseif (Get-Command code -ErrorAction SilentlyContinue) {
            code $projectPath
            Write-Host "  VS Code opened" -ForegroundColor Cyan
        }
        Write-Host "  Entered $ProjectName" -ForegroundColor Yellow
    } else {
        Write-Host "  Project '$ProjectName' not found in $projectsRoot" -ForegroundColor Red
    }
}

function global:start-dev {
    $current = Get-Location
    $pkg = Join-Path $current "package.json"
    $req = Join-Path $current "requirements.txt"
    $compose = Join-Path $current "docker-compose.yml"
    $csproj = Get-ChildItem $current -Filter "*.csproj" -ErrorAction SilentlyContinue | Select-Object -First 1

    if (Test-Path $pkg) {
        Write-Host "  Node.js project detected" -ForegroundColor Cyan
        if (Test-Path (Join-Path $current "node_modules")) {
            $devScripts = & node -e "try { const p = require('./package.json'); const s = Object.keys((p.scripts||{})).filter(k=>/dev|start|serve/.test(k)); console.log(s[0]||'') } catch(e){}" 2>$null
            if ($devScripts) {
                npm run $devScripts
            } else {
                npm start
            }
        } else {
            Write-Host "  Run 'npm install' first" -ForegroundColor Yellow
        }
    } elseif (Test-Path $req) {
        Write-Host "  Python project detected" -ForegroundColor Cyan
        $venvDirs = @(".venv", "venv", "env", ".env")
        $venvFound = $false
        foreach ($vd in $venvDirs) {
            $activate = Join-Path $current "$vd\Scripts\Activate.ps1"
            if (Test-Path $activate) {
                & $activate
                Write-Host "  Virtualenv activated" -ForegroundColor Green
                $venvFound = $true
                break
            }
        }
        if (-not $venvFound) {
            Write-Host "  No virtualenv found. Create with: python -m venv .venv" -ForegroundColor Yellow
        }
    } elseif ($csproj) {
        Write-Host "  .NET project detected" -ForegroundColor Cyan
        dotnet run
    } elseif (Test-Path $compose) {
        Write-Host "  Docker Compose project detected" -ForegroundColor Cyan
        docker compose up
    } else {
        Write-Host "  No recognized project type found" -ForegroundColor Red
    }
}

function global:sys-logs {
    $current = Get-Location
    $compose = Join-Path $current "docker-compose.yml"
    $firebaseDir = Join-Path $current ".firebase"

    if (Test-Path $compose) {
        docker compose logs -f --tail=50
    } elseif (Test-Path $firebaseDir) {
        $logFile = Join-Path $firebaseDir "*.log"
        $logs = Get-ChildItem $firebaseDir -Filter "*.log" -ErrorAction SilentlyContinue
        if ($logs) {
            Get-Content $logs[0].FullName -Tail 50 -Wait
        } else {
            Write-Host "  No Firebase logs found" -ForegroundColor Yellow
        }
    } else {
        Get-ChildItem $current -Filter "*.log" -ErrorAction SilentlyContinue | ForEach-Object {
            Write-Host "  === $($_.Name) ===" -ForegroundColor Cyan
            Get-Content $_.FullName -Tail 30
        }
    }
}

function global:ai-debug {
    $lines = (Get-History -Count 1 | Select-Object -ExpandProperty CommandLine)
    $output = "Comando executado:`n$lines`n`nErro/Não funcionou como esperado."
    $output | Set-Clipboard
    Write-Host "  Debug info copied to clipboard (paste in Claude/Gemini)" -ForegroundColor Green
}

function global:git-save {
    param([string]$Message)
    $msg = if ($Message) { "update via AI: $Message" } else { "update via AI" }
    $projectRoot = & git rev-parse --show-toplevel 2>$null
    if (-not $projectRoot) {
        Write-Host "  Not a git repository" -ForegroundColor Red
        return
    }
    $gitignore = Join-Path $projectRoot ".gitignore"
    $envFile = Join-Path $projectRoot ".env"
    if (Test-Path $envFile) {
        if (-not (Test-Path $gitignore)) {
            Write-Host "  WARNING: No .gitignore found. Create one!" -ForegroundColor Red
            return
        }
        $gitignoreContent = Get-Content $gitignore -Raw
        if ($gitignoreContent -notmatch "(?m)^\s*\.env\s*$") {
            Write-Host "  WARNING: .env not in .gitignore! Add it to prevent secret leaks." -ForegroundColor Red
            return
        }
    }
    git add .
    git commit -m $msg
    git push
    Write-Host "  Saved and pushed! ✓" -ForegroundColor Green
}

function global:git-undo {
    git reset --soft HEAD~1
    Write-Host "  Last commit undone (files preserved)" -ForegroundColor Yellow
}

function global:env-check {
    $projectRoot = & git rev-parse --show-toplevel 2>$null
    if (-not $projectRoot) {
        Write-Host "  Not a git repository" -ForegroundColor Red
        return
    }
    $gitignore = Join-Path $projectRoot ".gitignore"
    $envFile = Join-Path $projectRoot ".env"
    if (-not (Test-Path $envFile)) {
        Write-Host "  No .env file found. No risk." -ForegroundColor Green
        return
    }
    if (-not (Test-Path $gitignore)) {
        Write-Host "  WARNING: No .gitignore exists! .env could be leaked." -ForegroundColor Red
        return
    }
    $gitignoreContent = Get-Content $gitignore -Raw
    if ($gitignoreContent -match "(?m)^\s*\.env\s*$") {
        Write-Host "  .env is in .gitignore. Safe to push." -ForegroundColor Green
    } else {
        Write-Host "  WARNING: .env NOT in .gitignore! Add it!" -ForegroundColor Red
    }
}

function global:docker-nuke {
    Write-Host "  Stopping all containers..." -ForegroundColor Yellow
    docker stop $(docker ps -aq) 2>$null
    Write-Host "  Removing all containers..." -ForegroundColor Yellow
    docker rm $(docker ps -aq) 2>$null
    Write-Host "  Removing all images..." -ForegroundColor Yellow
    docker rmi $(docker images -q) -f 2>$null
    Write-Host "  Docker environment nuked! ✓" -ForegroundColor Green
}

