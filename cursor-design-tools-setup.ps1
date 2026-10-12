# Installs the same Cursor design setup on this Windows user account:
#   Taste Skill, Impeccable, Awesome DESIGN.md, Img2ThreeJS,
#   UX Designer, Canvas Design, Web Artifacts Builder,
#   App Store Screenshots, Transitions.dev
#
# Copy this file to the work PC, then in PowerShell:
#   powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\Documents\cursor-design-tools-setup.ps1"
#
# Requires Git and Node.js (npm and npx come with Node).
# When it finishes, start a new Cursor chat. This chat will not see the new skills.

$ErrorActionPreference = "Stop"

function Require-Command {
    param([string]$Name)
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Missing '$Name'. Install it, then run this script again."
    }
}

function Invoke-Checked {
    param(
        [string]$Label,
        [scriptblock]$Command
    )
    & $Command
    if ($LASTEXITCODE -ne 0) {
        throw "$Label failed with exit code $LASTEXITCODE."
    }
}

Require-Command git
Require-Command node
Require-Command npm
Require-Command npx

$cursorDir = Join-Path $env:USERPROFILE ".cursor"
$skillsDir = Join-Path $cursorDir "skills"
$agentsSkillsDir = Join-Path $env:USERPROFILE ".agents\skills"
$libraryParent = Join-Path $cursorDir "design-libraries"
$libraryDir = Join-Path $libraryParent "awesome-design-md"
$designMdRoot = Join-Path $libraryDir "design-md"

New-Item -ItemType Directory -Force -Path $skillsDir, $libraryParent | Out-Null
Set-Location $env:USERPROFILE

Write-Host "Installing Taste Skill..."
Invoke-Checked "Taste Skill" {
    npx --yes skills add https://github.com/Leonxlnx/taste-skill --skill design-taste-frontend -g -a cursor -y --copy
}

Write-Host "Installing Impeccable..."
$impeccableArgs = @("--yes", "impeccable", "install", "--providers=cursor", "--scope=global", "-y")
if (Test-Path (Join-Path $skillsDir "impeccable")) {
    $impeccableArgs += "--force"
}
Invoke-Checked "Impeccable" { npx @impeccableArgs }

Write-Host "Installing Img2ThreeJS..."
Invoke-Checked "Img2ThreeJS" {
    npx --yes skills add https://github.com/img2threejs/img2threejs --skill img2threejs -g -a cursor -y --copy
}

Write-Host "Installing UX Designer..."
Invoke-Checked "UX Designer" {
    npx --yes skills add https://github.com/szilu/ux-designer-skill --skill ux-designer -g -a cursor -y --copy
}

Write-Host "Installing Canvas Design and Web Artifacts Builder..."
Invoke-Checked "Canvas Design and Web Artifacts Builder" {
    npx --yes skills add https://github.com/anthropics/skills --skill canvas-design --skill web-artifacts-builder -g -a cursor -y --copy
}

Write-Host "Installing App Store Screenshots..."
Invoke-Checked "App Store Screenshots" {
    npx --yes skills add https://github.com/ParthJadhav/app-store-screenshots --skill app-store-screenshots -g -a cursor -y --copy
}

Write-Host "Installing Transitions.dev..."
Invoke-Checked "Transitions.dev" {
    npx --yes skills add https://github.com/Jakubantalik/transitions.dev --skill transitions-dev -g -a cursor -y --copy
}

function Ensure-Junction {
    param(
        [string]$Link,
        [string]$Target
    )
    if (Test-Path $Link) {
        return
    }
    if (-not (Test-Path $Target)) {
        throw "Expected skill folder is missing: $Target"
    }
    New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
}

Ensure-Junction (Join-Path $skillsDir "design-taste-frontend") (Join-Path $agentsSkillsDir "design-taste-frontend")
Ensure-Junction (Join-Path $skillsDir "img2threejs") (Join-Path $agentsSkillsDir "img2threejs")
Ensure-Junction (Join-Path $skillsDir "ux-designer") (Join-Path $agentsSkillsDir "ux-designer")
Ensure-Junction (Join-Path $skillsDir "canvas-design") (Join-Path $agentsSkillsDir "canvas-design")
Ensure-Junction (Join-Path $skillsDir "web-artifacts-builder") (Join-Path $agentsSkillsDir "web-artifacts-builder")
Ensure-Junction (Join-Path $skillsDir "app-store-screenshots") (Join-Path $agentsSkillsDir "app-store-screenshots")
Ensure-Junction (Join-Path $skillsDir "transitions-dev") (Join-Path $agentsSkillsDir "transitions-dev")

Write-Host "Cloning Awesome DESIGN.md..."
if (Test-Path (Join-Path $libraryDir ".git")) {
    Invoke-Checked "design library update" { git -C $libraryDir pull --ff-only }
} else {
    Invoke-Checked "design library clone" {
        git clone --depth 1 https://github.com/VoltAgent/awesome-design-md.git $libraryDir
    }
}

$skillDir = Join-Path $skillsDir "awesome-design-md"
New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
$skillPath = Join-Path $skillDir "SKILL.md"
$skillBody = @"
---
name: awesome-design-md
description: >-
  Applies a ready-made DESIGN.md from the local Awesome DESIGN.md library so
  UI matches a known website's design system. Use when the user asks for a
  design system, DESIGN.md, or a frontend inspired by an existing brand or
  site such as Linear, Stripe, Vercel, Notion, Nike, or Apple.
---

# Awesome DESIGN.md

A local library of design-system documents extracted from real websites. Each document is a ``DESIGN.md`` an agent can follow for color, type, spacing, components, and guardrails.

Library root:

``$designMdRoot``

Each subdirectory is one system. The file to copy is ``<system>\DESIGN.md``.

## When this applies

Use it when the user wants a new or redesigned interface to follow a known site's visual language, or asks for a ``DESIGN.md``.

Do not apply a brand system for ordinary UI work when the user did not ask for a reference look. Taste Skill and Impeccable still cover that work.

## Steps

1. List the directory names under the library root. Do not hardcode the catalog; the clone can change.
2. If the user named a brand, match it to one folder (for example ``linear.app``, ``stripe``, ``vercel``, ``notion``).
3. If they did not name one, show a short list of close matches and ask which system to use. Do not pick a brand for them.
4. Copy that system's ``DESIGN.md`` into the current project's root as ``DESIGN.md``. Leave the library copy untouched.
5. Follow the project ``DESIGN.md`` for palette, type, spacing, components, and do's and don'ts.
6. Keep the user's product name, copy, and logo. The file is a visual system, not a license to impersonate the source brand.
7. If the project already has a ``DESIGN.md``, read it first. Replace it only when the user agrees.

## Refresh

From a terminal:

``````powershell
git -C "`$env:USERPROFILE\.cursor\design-libraries\awesome-design-md" pull
``````
"@
Set-Content -Path $skillPath -Value $skillBody -Encoding utf8

Write-Host "Wiring the Impeccable design check for Windows..."
$hooksPath = Join-Path $cursorDir "hooks.json"
$hookCommand = 'cmd /d /c "' + (Join-Path $skillsDir "impeccable\scripts\impeccable.cmd") + '" hook-before-edit'
$hookScript = Join-Path $env:TEMP "cursor-design-tools-hooks.js"
@'
const fs = require("fs");
const hooksPath = process.argv[2];
const command = process.argv[3];
let doc = { version: 1, hooks: {} };
if (fs.existsSync(hooksPath)) {
  doc = JSON.parse(fs.readFileSync(hooksPath, "utf8"));
  doc.hooks = doc.hooks || {};
}
const list = Array.isArray(doc.hooks.preToolUse) ? doc.hooks.preToolUse : [];
const kept = [];
let hasWindowsHook = false;
for (const item of list) {
  const current = String(item && item.command || "");
  if (current.includes("hook-before-edit") && current.includes("impeccable")) {
    if (current.includes("impeccable.cmd")) {
      hasWindowsHook = true;
      kept.push(item);
    }
    continue;
  }
  if (current) kept.push(item);
}
if (!hasWindowsHook) {
  kept.push({
    command,
    timeout: 20,
    matcher: "Write|Edit|StrReplace|ApplyPatch"
  });
}
doc.version = doc.version || 1;
doc.hooks.preToolUse = kept;
fs.writeFileSync(hooksPath, JSON.stringify(doc, null, 2) + "\n");
'@ | Set-Content -Path $hookScript -Encoding utf8
Invoke-Checked "hook update" { node $hookScript $hooksPath $hookCommand }

Write-Host ""
Write-Host "Done. Start a new Cursor chat on this PC, then ask it to build a page with a named design system."
