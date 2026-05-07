# Installs the global CLAUDE.md and every skill in skills/ into ~/.claude/
# Run from PowerShell:  & .\install.ps1
# Safe to re-run.

$ErrorActionPreference = "Stop"

$ClaudeRoot   = Join-Path $env:USERPROFILE ".claude"
$SkillsTarget = Join-Path $ClaudeRoot "skills"
$Source       = Split-Path -Parent $MyInvocation.MyCommand.Path

New-Item -ItemType Directory -Force -Path $ClaudeRoot   | Out-Null
New-Item -ItemType Directory -Force -Path $SkillsTarget | Out-Null

# CLAUDE.md: append if exists, create if not
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
    Write-Host "Created CLAUDE.md at $ClaudeMdTarget" -ForegroundColor Green
}

# Skills: copy every subfolder in skills/
$SkillsSource = Join-Path $Source "skills"
$SkillFolders = Get-ChildItem -Path $SkillsSource -Directory

foreach ($Skill in $SkillFolders) {
    $TargetDir = Join-Path $SkillsTarget $Skill.Name
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
    Copy-Item -Path (Join-Path $Skill.FullName "*") -Destination $TargetDir -Recurse -Force
    Write-Host "Installed /$($Skill.Name) skill at $TargetDir" -ForegroundColor Green
}

Write-Host ""
Write-Host "Done. Restart Claude Code for changes to take effect." -ForegroundColor Cyan
