mise activate pwsh | Out-String | Invoke-Expression
starship init powershell --print-full-init | Out-String | Invoke-Expression

# https://wezterm.org/shell-integration.html#osc-7-on-windows-with-powershell
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

zoxide init powershell | Out-String | Invoke-Expression

Set-PSReadLineKeyHandler -Key ctrl+d -Function ViExit
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key ctrl+r -ScriptBlock {
    $cmd = Get-Content (Get-PSReadLineOption).HistorySavePath | Select-Object -Unique | fzf
    if ($cmd) {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($cmd.Trim())
    }
}

# https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}
