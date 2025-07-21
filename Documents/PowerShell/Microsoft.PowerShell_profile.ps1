mise activate pwsh | Out-String | Invoke-Expression
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
