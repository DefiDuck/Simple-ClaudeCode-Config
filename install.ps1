# Installs the global CLAUDE.md and /diagnose skill into ~/.claude/
# Run from PowerShell:  & .\install.ps1
# Safe to re-run.

$ErrorActionPreference = "Stop"

$ClaudeRoot = Join-Path $env:USERPROFILE ".claude"
$SkillsDir  = Join-Path $ClaudeRoot "skills\diagnose"
$Source     = Split-Path -Parent $MyInvocation.MyCommand.Path

New-Item -ItemType Directory -Force -Path $ClaudeRoot | Out-Null
New-Item -ItemType Directory -Force -Path $SkillsDir  | Out-Null

$ClaudeMdTarget = Join-Path $ClaudeRoot "CLAUDE.md"
$ClaudeMdSource = Join-Path $Source "CLAUDE.md"
$NewContent = Get-Content $ClaudeMdSource -Raw

if (Test-Path $ClaudeMdTarget) {
    $Existing = Get-Content $ClaudeMdTarget -Raw
    if ($Existing -match "Output Discipline") {
        Write-Host "CLAUDE.md already contains the rules. Skipping append." -ForegroundColor Yellow
    } else {
        $Separator = [Environment]::NewLine + [Environment]::NewLine
        Add-Content -Path $ClaudeMdTarget -Value ($Separator + $NewContent)
        Write-Host "Appended global rules to existing CLAUDE.md." -ForegroundColor Green
    }
} else {
    Set-Content -Path $ClaudeMdTarget -Value $NewContent
    Write-Host "Created new CLAUDE.md at $ClaudeMdTarget" -ForegroundColor Green
}

$SkillTarget = Join-Path $SkillsDir "SKILL.md"
$SkillSource = Join-Path $Source "skills\diagnose\SKILL.md"
Copy-Item $SkillSource $SkillTarget -Force
Write-Host "Installed /diagnose skill at $SkillTarget" -ForegroundColor Green

Write-Host ""
Write-Host "Done. Restart Claude Code for changes to take effect." -ForegroundColor Cyan
