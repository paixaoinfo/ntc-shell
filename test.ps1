Import-Module PwshSpectreConsole
$markup = [Spectre.Console.Markup]::new("[bold cyan]NTC Shell v3.0[/] | [bold purple]IA:[/] Gemini Pro")
$markup | Format-SpectrePanel -Title "Test" | Out-SpectreHost
