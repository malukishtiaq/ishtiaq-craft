# Installs the same Cursor design setup on this Windows user account:
#   Taste Skill, Impeccable, Awesome DESIGN.md, Img2ThreeJS,
#   UX Designer, Canvas Design, Web Artifacts Builder,
#   App Store Screenshots, Transitions.dev, Security Audit,
#   marketing skills for copy, conversion, SEO, social, and email,
#   ECC engineering skills for tests, verification, and implementation patterns,
#   and the ishtiaq-craft router that picks the guideline from the task.
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

Write-Host "Installing Security Audit..."
Invoke-Checked "Security Audit" {
    npx --yes skills add https://github.com/cloudflare/security-audit-skill --skill security-audit -g -a cursor -y --copy
}

Write-Host "Installing marketing skills..."
Invoke-Checked "marketing skills" {
    npx --yes skills add coreyhaines31/marketingskills `
        --skill product-marketing --skill copywriting --skill copy-editing `
        --skill cro --skill seo-audit --skill ai-seo --skill social `
        --skill content-strategy --skill emails --skill marketing-ideas `
        --skill image --skill marketing-psychology `
        -g -a cursor -y --copy
}

Write-Host "Installing ECC engineering skills..."
$eccSkills = @(
    "search-first", "tdd-workflow", "verification-loop", "change-impact",
    "coding-standards", "frontend-patterns", "react-patterns", "backend-patterns",
    "api-design", "error-handling", "e2e-testing", "browser-qa",
    "security-review", "production-audit"
)
$eccArgs = @("--yes", "skills", "add", "https://github.com/affaan-m/ECC")
foreach ($eccSkill in $eccSkills) {
    $eccArgs += @("--skill", $eccSkill)
}
$eccArgs += @("-g", "-a", "cursor", "-y", "--copy")
Invoke-Checked "ECC engineering skills" { npx @eccArgs }

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
Ensure-Junction (Join-Path $skillsDir "security-audit") (Join-Path $agentsSkillsDir "security-audit")
foreach ($marketingSkill in @(
    "product-marketing", "copywriting", "copy-editing", "cro", "seo-audit", "ai-seo",
    "social", "content-strategy", "emails", "marketing-ideas", "image", "marketing-psychology"
)) {
    Ensure-Junction (Join-Path $skillsDir $marketingSkill) (Join-Path $agentsSkillsDir $marketingSkill)
}
foreach ($eccSkill in $eccSkills) {
    Ensure-Junction (Join-Path $skillsDir $eccSkill) (Join-Path $agentsSkillsDir $eccSkill)
}

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

$routerDir = Join-Path $skillsDir "ishtiaq-craft"
New-Item -ItemType Directory -Force -Path $routerDir | Out-Null
$routerBody = @'
---
name: ishtiaq-craft
description: >-
  Routes a task to guidelines already installed on this machine. Use when the
  user mentions a design problem, UI, UX, app look, frontend, marketing,
  copy, landing page, conversion, SEO, social post, email sequence, building
  or fixing a feature, tests, an API, code review, or a cybersecurity,
  security, vulnerability, or audit task, including phrases like "design app
  problem" and "cybersecurity thing."
---

# Task routing

The guidelines are already on this machine. Do not search GitHub for a skill or ask which repo to use. Read the matching skill and follow it.

Skill folders:

- __SKILLS__
- __AGENTS__

## Design, UI, UX, or an app-look problem

1. Read `impeccable\SKILL.md` and follow it for the review, layout, and consistency pass.
2. Read `design-taste-frontend\SKILL.md` and follow it so the result does not look like a generic AI layout.
3. Read `ux-designer\SKILL.md` when the task is a flow, screens, or usability.
4. For scroll-linked motion, use StringTune. Do not add GSAP. Install `@fiddle-digital/string-tune` in that project only, register only the modules the interaction needs, and follow https://tune.fiddle.digital/docs/quick-start/. Use one `StringTune.getInstance()`, then `use(...)`, then `start(60)`. Attach effects with `string` attributes and CSS variables.
5. Read `transitions-dev\SKILL.md` for small hover or CSS motion that is not tied to scroll.
6. Read `awesome-design-md\SKILL.md` only when the user names a brand or asks for a design system. Copy that system's `DESIGN.md` into the project, then build.
7. Read `canvas-design\SKILL.md` or `web-artifacts-builder\SKILL.md` when the user wants a standalone visual or a single-page artifact.
8. Read `app-store-screenshots\SKILL.md` when the user wants store screenshots.

For a page that is both an interface and marketing, follow this section for layout and the marketing section for copy and conversion.

## Marketing

If the current project has no `.agents/product-marketing.md`, read `product-marketing\SKILL.md` and follow it before any other marketing skill.

Then read the one skill that matches the task:

1. Read `copywriting\SKILL.md` for new page copy, headlines, or calls to action.
2. Read `copy-editing\SKILL.md` to revise existing copy.
3. Read `cro\SKILL.md` when a page or form needs more conversions.
4. Read `seo-audit\SKILL.md` when a site is not ranking.
5. Read `ai-seo\SKILL.md` when the goal is citation in AI answers.
6. Read `social\SKILL.md` for posts on a specific platform.
7. Read `content-strategy\SKILL.md` to decide what to publish.
8. Read `emails\SKILL.md` for a lifecycle or drip sequence.
9. Read `marketing-ideas\SKILL.md` for campaign ideas.
10. Read `image\SKILL.md` for marketing images.
11. Read `marketing-psychology\SKILL.md` when the user asks to apply persuasion or behavioral principles.

## Engineering

Design skills own look and layout. These skills own how the code is built and checked.

1. Read `search-first\SKILL.md` before adding a dependency or writing a utility that may already exist.
2. Read `tdd-workflow\SKILL.md` when writing a feature, fixing a bug, or refactoring.
3. Read `change-impact\SKILL.md` before a cross-module, schema, auth, or public-interface change.
4. Read `coding-standards\SKILL.md` for naming and readability when no framework skill applies.
5. Read `react-patterns\SKILL.md` for React components. Read `frontend-patterns\SKILL.md` for Next.js state, data fetching, and render performance.
6. Read `backend-patterns\SKILL.md` for Node, Express, or Next.js API routes. Read `api-design\SKILL.md` for REST naming, status codes, pagination, and errors.
7. Read `error-handling\SKILL.md` when designing failures, retries, or user-facing errors.
8. Read `e2e-testing\SKILL.md` for Playwright tests.
9. Read `browser-qa\SKILL.md` when checking a deployed page in the browser.
10. Read `security-review\SKILL.md` when adding auth, user input, secrets, or API endpoints.
11. Read `verification-loop\SKILL.md` before calling the work done or opening a pull request.
12. Read `production-audit\SKILL.md` for a pre-launch or post-merge readiness check.

## Cybersecurity

Read `security-audit\SKILL.md` and follow it.

Answer a security question from the relevant section. Run the full audit workflow only when the user explicitly asks to audit, pen-test, or review a codebase for vulnerabilities. Use `security-review` for a change that handles auth, input, or secrets. Use this audit skill when the user asks for an audit.
'@
$routerBody = $routerBody.Replace('__SKILLS__', $skillsDir).Replace('__AGENTS__', $agentsSkillsDir)
Set-Content -Path (Join-Path $routerDir "SKILL.md") -Value $routerBody -Encoding utf8

Write-Host ""
Write-Host "Done. Start a new Cursor chat on this PC. Describe the task as a design problem, a marketing task, an engineering task, or a cybersecurity problem and Cursor will open the matching guidelines."
