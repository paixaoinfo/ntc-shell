$key = [Environment]::GetEnvironmentVariable("GEMINI_API_KEY", "User")
if (-not $key) { Write-Host "NO_KEY"; exit }
$res = Invoke-RestMethod -Uri "https://generativelanguage.googleapis.com/v1beta/models?key=$key"
$res.models | Where-Object { $_.supportedGenerationMethods -contains "generateContent" } | Select-Object name
