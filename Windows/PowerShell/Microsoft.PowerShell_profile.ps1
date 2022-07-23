$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
$ENV:STARSHIP_DISTRO = "  $env:username"
Invoke-Expression (&starship init powershell)
