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

if (-not $events) {
    Write-Host "   [-] No Event ID 1000 records found in Application log." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   [+] Done. Contact @tfqv if you run into any issues." -ForegroundColor Cyan
    Write-Host ""
    exit
}

$results = @($events | Select-Object TimeCreated, Id, ProviderName, LevelDisplayName, Message)

Write-Host "   [+] Found $($results.Count) event(s) with ID 1000" -ForegroundColor Green
Write-Host "   [+] Opening results in GUI window..." -ForegroundColor Green
Write-Host ""

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "metzir - Application Log Event ID 1000 ($($results.Count) events)"
$form.Size = New-Object System.Drawing.Size(1100, 650)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(24, 24, 24)
$form.ForeColor = [System.Drawing.Color]::White
$form.Font = New-Object System.Drawing.Font("Segoe UI", 9)

$panelTop = New-Object System.Windows.Forms.Panel
$panelTop.Dock = "Top"
$panelTop.Height = 60
$panelTop.BackColor = [System.Drawing.Color]::FromArgb(16, 16, 16)
$form.Controls.Add($panelTop)

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "METZIR - APPLICATION LOG EVENT ID 1000"
$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = [System.Drawing.Color]::Cyan
$lblTitle.AutoSize = $true
$lblTitle.Location = New-Object System.Drawing.Point(15, 10)
$panelTop.Controls.Add($lblTitle)

$lblCount = New-Object System.Windows.Forms.Label
$lblCount.Text = "$($results.Count) event(s) found"
$lblCount.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$lblCount.ForeColor = [System.Drawing.Color]::LightGreen
$lblCount.AutoSize = $true
$lblCount.Location = New-Object System.Drawing.Point(17, 34)
$panelTop.Controls.Add($lblCount)

$searchBox = New-Object System.Windows.Forms.TextBox
$searchBox.Width = 300
$searchBox.Location = New-Object System.Drawing.Point(($form.ClientSize.Width - 330), 18)
$searchBox.Anchor = "Top,Right"
$searchBox.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
$searchBox.ForeColor = [System.Drawing.Color]::White
$searchBox.BorderStyle = "FixedSingle"
$searchBox.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$panelTop.Controls.Add($searchBox)

$searchLabel = New-Object System.Windows.Forms.Label
$searchLabel.Text = "Search:"
$searchLabel.AutoSize = $true
$searchLabel.ForeColor = [System.Drawing.Color]::White
$searchLabel.Location = New-Object System.Drawing.Point(($form.ClientSize.Width - 390), 21)
$searchLabel.Anchor = "Top,Right"
$panelTop.Controls.Add($searchLabel)

$grid = New-Object System.Windows.Forms.DataGridView
$grid.Dock = "Fill"
$grid.BackgroundColor = [System.Drawing.Color]::FromArgb(24, 24, 24)
$grid.GridColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$grid.BorderStyle = "None"
$grid.ReadOnly = $true
$grid.AllowUserToAddRows = $false
$grid.AllowUserToDeleteRows = $false
$grid.AllowUserToResizeRows = $false
$grid.RowHeadersVisible = $false
$grid.AutoSizeColumnsMode = "Fill"
$grid.SelectionMode = "FullRowSelect"
$grid.MultiSelect = $false
$grid.EnableHeadersVisualStyles = $false
$grid.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::FromArgb(16, 16, 16)
$grid.ColumnHeadersDefaultCellStyle.ForeColor = [System.Drawing.Color]::Cyan
$grid.ColumnHeadersDefaultCellStyle.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$grid.ColumnHeadersDefaultCellStyle.SelectionBackColor = [System.Drawing.Color]::FromArgb(16, 16, 16)
$grid.ColumnHeadersDefaultCellStyle.SelectionForeColor = [System.Drawing.Color]::Cyan
$grid.ColumnHeadersHeight = 32
$grid.DefaultCellStyle.BackColor = [System.Drawing.Color]::FromArgb(24, 24, 24)
$grid.DefaultCellStyle.ForeColor = [System.Drawing.Color]::White
$grid.DefaultCellStyle.SelectionBackColor = [System.Drawing.Color]::FromArgb(0, 90, 120)
$grid.DefaultCellStyle.SelectionForeColor = [System.Drawing.Color]::White
$grid.DefaultCellStyle.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$grid.AlternatingRowsDefaultCellStyle.BackColor = [System.Drawing.Color]::FromArgb(32, 32, 32)
$grid.RowTemplate.Height = 26
$form.Controls.Add($grid)
$grid.BringToFront()

$grid.Columns.Add("TimeCreated", "Time Created")
$grid.Columns.Add("Id", "ID")
$grid.Columns.Add("ProviderName", "Provider")
$grid.Columns.Add("LevelDisplayName", "Level")
$grid.Columns.Add("Message", "Message")

$grid.Columns["TimeCreated"].Width = 150
$grid.Columns["Id"].Width = 60
$grid.Columns["ProviderName"].Width = 180
$grid.Columns["LevelDisplayName"].Width = 90

foreach ($r in $results) {
    $row = $grid.Rows.Add(
        $r.TimeCreated.ToString("yyyy-MM-dd HH:mm:ss"),
        $r.Id,
        $r.ProviderName,
        $r.LevelDisplayName,
        ($r.Message -replace "`r`n", " " -replace "`n", " ")
    )
}

$searchBox.Add_TextChanged({
    $term = $searchBox.Text
    $grid.Rows | ForEach-Object { $_.Visible = $true }
    if ([string]::IsNullOrWhiteSpace($term)) { return }
    foreach ($row in $grid.Rows) {
        $match = $false
        foreach ($cell in $row.Cells) {
            if ($cell.Value -and $cell.Value.ToString().ToLower().Contains($term.ToLower())) {
                $match = $true
                break
            }
        }
        $row.Visible = $match
    }
})

$status = New-Object System.Windows.Forms.StatusStrip
$status.BackColor = [System.Drawing.Color]::FromArgb(16, 16, 16)
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = "Ready - $($results.Count) events loaded"
$statusLabel.ForeColor = [System.Drawing.Color]::LightGreen
$status.Items.Add($statusLabel) | Out-Null
$form.Controls.Add($status)

$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()

Write-Host "   [+] GUI window closed." -ForegroundColor Green
Write-Host ""
Write-Host "   [+] Done. Contact @tfqv if you run into any issues." -ForegroundColor Cyan
Write-Host ""
