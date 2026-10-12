# ishtiaq-craft

Personal Cursor setup for this Windows account. The skills themselves are not stored in this repo. This repo is the installer. Clone it on the work PC and run the script. The script downloads the same skills and writes the router that picks the right one from the task.

The conversation that started this setup is in `instagram-access-chat.md`.

## What gets installed

Design: Taste Skill, Impeccable, Awesome DESIGN.md, Img2ThreeJS, UX Designer, Canvas Design, Web Artifacts Builder, App Store Screenshots, Transitions.dev.

Marketing: product context, copywriting, copy editing, conversion, SEO, AI SEO, social, content strategy, emails, marketing ideas, images, marketing psychology.

Engineering: search-first, tests, change impact, coding standards, React, frontend, backend, API design, error handling, end-to-end tests, browser QA, security review, verification, production audit.

Security: Security Audit.

Router: `ishtiaq-craft`, so a new chat can match a design, marketing, engineering, or security task to those guidelines.

StringTune is not a global skill. The router tells Cursor to install `@fiddle-digital/string-tune` inside a project only when that project needs scroll-linked motion.

## This PC

The installer is already updated. Push `main` to `git@github.com:malukishtiaq/ishtiaq-craft.git` before using the work PC. The work PC can only pull what GitHub has.

## Work PC

1. Install Git, Node.js, and Cursor. Node.js includes `npm` and `npx`. Leave the machine online. The script clones public GitHub repos.
2. Make sure this GitHub account can clone `malukishtiaq/ishtiaq-craft`. SSH is what this repo uses. If `git clone` asks for a password or says permission denied, add this PC's public key at https://github.com/settings/keys and try again.
3. In PowerShell:

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\Documents\GitHub" | Out-Null
Set-Location "$env:USERPROFILE\Documents\GitHub"
git clone git@github.com:malukishtiaq/ishtiaq-craft.git
Set-Location ishtiaq-craft
powershell -ExecutionPolicy Bypass -File .\cursor-design-tools-setup.ps1
```

4. Wait until the script prints `Done.` If a step fails, read the error, fix that tool (usually Git or Node), and run the same command again. Installed pieces are skipped or updated.
5. Quit Cursor completely, open it again, and start a new chat. A chat that was already open will not see the new skills.

Open any project and say: "This is a design problem. Use the installed guidelines." Cursor should read `ishtiaq-craft` and then the matching skill. It should not search GitHub for a new skill.

## Paste this into Cursor on the work PC

Use this only after the clone exists and this folder is the open project:

```text
Read README.md in this repo and run cursor-design-tools-setup.ps1 for this Windows user. Do not search for other skill repos. When the script finishes, tell me to quit Cursor and start a new chat.
```
