$isAdmin = [System.Security.Principal.WindowsPrincipal]::new([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host ""
    Write-Host "   ███╗   ███╗███████╗████████╗███████╗██╗██████╗ " -ForegroundColor Red
    Write-Host "   ████╗ ████║██╔════╝╚══██╔══╝╚══███╔╝██║██╔══██╗" -ForegroundColor Red
    Write-Host "   ██╔████╔██║█████╗     ██║     ███╔╝ ██║██████╔╝" -ForegroundColor Red
    Write-Host "   ██║╚██╔╝██║██╔══╝     ██║    ███╔╝  ██║██╔══██╗" -ForegroundColor Red
    Write-Host "   ██║ ╚═╝ ██║███████╗   ██║   ███████╗██║██║  ██║" -ForegroundColor Red
    Write-Host "   ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝╚═╝  ╚═╝" -ForegroundColor Red
    Write-Host ""
    Write-Host "   [-] ADMINISTRATOR PRIVILEGES REQUIRED" -ForegroundColor Red
    Write-Host "   [-] Please run this script as Administrator!" -ForegroundColor Red
    Write-Host ""
    exit
}

Clear-Host

Write-Host ""
Write-Host -ForegroundColor Cyan "   ███╗   ███╗███████╗████████╗███████╗██╗██████╗ "
Write-Host -ForegroundColor Cyan "   ████╗ ████║██╔════╝╚══██╔══╝╚══███╔╝██║██╔══██╗"
Write-Host -ForegroundColor Cyan "   ██╔████╔██║█████╗     ██║     ███╔╝ ██║██████╔╝"
Write-Host -ForegroundColor Cyan "   ██║╚██╔╝██║██╔══╝     ██║    ███╔╝  ██║██╔══██╗"
Write-Host -ForegroundColor Cyan "   ██║ ╚═╝ ██║███████╗   ██║   ███████╗██║██║  ██║"
Write-Host -ForegroundColor Cyan "   ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝╚═╝  ╚═╝"
Write-Host ""
Write-Host -ForegroundColor DarkGray "   Made By @tfqv"
Write-Host ""

Write-Host "   ┌──────────────────────────────────────────────┐" -ForegroundColor DarkGray
Write-Host "   │  EVENT VIEWER - APPLICATION LOG (ID 1000)    │" -ForegroundColor DarkGray
Write-Host "   └──────────────────────────────────────────────┘" -ForegroundColor DarkGray
Write-Host ""

Write-Host "   [+] Querying Application log for Event ID 1000..." -ForegroundColor Green
Write-Host ""

$events = Get-WinEvent -FilterHashtable @{LogName='Application'; Id=1000} -ErrorAction SilentlyContinue

if ($events) {
    $results = @($events | Select-Object TimeCreated, Id, ProviderName, LevelDisplayName, Message)
    Write-Host "   [+] Found $($results.Count) event(s) with ID 1000" -ForegroundColor Green
    Write-Host "   [+] Opening results in GUI window... (close the window to exit)" -ForegroundColor Green
    Write-Host ""

    $results | Out-GridView -Title "metzir - Application Log Event ID 1000 ($($results.Count) events)"

    Write-Host "   [+] GUI window closed." -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "   [-] No Event ID 1000 records found in Application log." -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "   [+] Done. Contact @tfqv if you run into any issues." -ForegroundColor Cyan
Write-Host ""
