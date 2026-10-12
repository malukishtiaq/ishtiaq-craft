# Instagram access permissions

Chat from Thursday, October 8, 2026. This is the conversation that installed the design tools and created this repo.

## You

how can i let you access instagram?

## Cursor

**Accessing User Meta Tools**

I'm currently exploring how to enable access to Instagram. My initial investigation points towards utilizing the `user-Meta Developer Tools` namespace, as its description seems directly relevant to this functionality.

**Investigating Meta Access Tools**

I'm focused on accessing Instagram. My current understanding is that the `user-Meta Developer Tools` namespace is the most direct route, as its description explicitly mentions Instagram integration. I am also considering `cursor-ide-browser` for general browsing capabilities, should that be the user's intent.

**Clarifying Instagram Access Paths**

I'm analyzing the ambiguity in "how can I let you access Instagram." It seems to involve determining if you need to authenticate the Meta Developer Tools, which requires app access, or simply use the browser tool. I'm looking into the `mcp_auth` process to clarify the authentication steps needed for the former.

## Cursor

**Exploring Instagram Access Methods**

I'm currently considering how to grant access to Instagram. For developers, the `mcp_auth` tool within `user-Meta Developer Tools` appears to be the primary route. If the user is not a developer, I need to determine what their specific intent is for me to "access" Instagram.

## Cursor

To allow me to access Instagram, there are a few ways depending on whether you want me to interact with the platform as a developer or simply browse it.

### 1. Meta Developer Platform (For API Access)
If you are a developer and want me to manage or interact with Instagram via the **Graph API**, you can use the **Meta Social Technologies MCP** (formerly Meta Developer Tools). I already have access to some Meta apps, but to ensure I can access specific Instagram features:

*   **Authenticate:** You can call `mcp_auth` (or ask me to do it) to sign in and grant me permissions to your Meta developer apps.
*   **Grant App Permissions:** Ensure your Meta app has the **Instagram Graph API** product added and that the appropriate permissions (like `instagram_basic`, `instagram_content_publish`, etc.) are granted.
*   **Discover Apps:** I can run `devtools_app_list` to see which apps I currently have access to.

### 2. Browser Access (For UI/Browsing)
If you want me to view Instagram pages, take screenshots, or interact with the website directly, I can use the **built-in browser**.
*   **Navigate:** You can ask me to "Open Instagram in the browser" or "Check this Instagram profile."
*   **Authentication:** If you are logged into Instagram in your Cursor browser, I can access your feed or profile. I recommend **not** sharing your password with me directly; instead, log in manually in the browser tab that I open.

### 3. How to proceed now?
How would you like me to access it?

*   **"Run `mcp_auth`"**: If you want to connect your Meta Developer account.
*   **"Open Instagram in the browser"**: If you want me to look at a specific page or your feed.
*   **"Write a script to post to Instagram"**: If you want me to help you build an automation using your API keys.

**Important Note:** For your security, never share your raw Instagram password or long-lived access tokens in the chat text. Use the authenticated tools or the browser for sensitive actions.

**Accessing Meta Developer Tools**

I've identified an existing Meta app, 'linkmaids,' with a specific app ID. This discovery is key as I consider how to facilitate Instagram access, leveraging the Meta Developer platform for this purpose.

**Exploring Meta Developer Options**

My recent focus has been on pinpointing relevant Meta Developer tools. While I've found general platform management options, direct Instagram API interaction requires specific app permissions. I'm now considering how to best explain the authentication process, whether through Meta's developer portal or alternative browser-based methods, while also emphasizing security.

## You

someone just open sourced an entire AI company

it's called paperclip. 97k stars on github

give it a goal, then hire the team: a CEO, engineers, designers, any role you need. every one of them is an AI agent

they get titles, budgets & an org chart. every agent gets a monthly budget with a hard stop, so work pauses when it hits the limit & a runaway loop doesn't burn your tokens overnight

works with claude code, codex, cursor, openclaw & hermes. the readme says to just ask your agent to install it

free & open source (MIT)

comment "REPOS" & i'll send it to your DMs

#claudecode #aiagents #opensource #github #aitools #ai
1 d

how can i use this? example?

## Cursor

I'll look up Paperclip's repo and README so the example matches how it actually works.

## Cursor

Paperclip is a local control panel for a team of AI agents. You give it a company goal, hire agents that already run on your machine (Claude Code, Codex, Cursor, and others), and it assigns them work, tracks costs, and stops an agent when its monthly budget runs out.

The repo is public at [github.com/paperclipai/paperclip](https://github.com/paperclipai/paperclip). You do not need a Paperclip account.

## What you actually do

1. Start Paperclip on your computer. It opens a dashboard at `http://localhost:3100`.
2. Create a company and write a goal.
3. Hire a CEO first. The CEO reads the goal, proposes a strategy, and you approve it.
4. Hire the rest of the team under the CEO (engineer, designer, and so on). Each hire is an adapter that runs an agent you already have.
5. Set a monthly budget per agent. When that agent hits the limit, Paperclip pauses it.
6. Agents wake on a schedule (a heartbeat), pick up tickets, and work. You review what they did.

Paperclip does not include the models. You still pay Anthropic, OpenAI, or Cursor. The budget is a hard stop so one loop cannot spend all night.

## Install

You need Node.js 24.11 or newer. On Windows, this is the path that matches the docs:

```bash
npx --registry https://registry.npmjs.org paperclipai onboard --yes
```

That writes config under `~/.paperclip`, starts an embedded database, and serves the UI at `http://localhost:3100`. The bash `install.sh` script in the README is aimed at macOS and Linux.

## A small example

Company: **Notelet**

Goal: *Ship a simple local markdown notes app with search, and publish a README people can follow.*

| Agent | Reports to | Adapter | Monthly budget |
| --- | --- | --- | --- |
| CEO | you (the board) | Claude Code or Codex | $20 |
| Engineer | CEO | Cursor or Claude Code | $40 |
| Designer | CEO | Claude Code | $10 |

What happens:

1. You create **Notelet**, then add the goal from the Goals section.
2. You hire the CEO, paste your API key into that agent, and turn on its heartbeat.
3. On the first heartbeat the CEO writes a strategy. It sits in Approvals until you accept it.
4. After you approve, tasks show up on the board (scaffold the app, add search, write the README).
5. You hire the Engineer and Designer and set them to report to the CEO. The CEO assigns engineering tickets to the Engineer and UI tickets to the Designer.
6. Each heartbeat, an agent checks out one task, works in a project folder, and logs the run. If the Engineer spends $40, that agent pauses until next month. The others keep going.

You stay in the dashboard: approve hires and strategy, pause anyone, and read the run transcript under that agent.

A single coding agent does not need this. It is useful when several agents share one goal and you want tickets, an org chart, and a spending cap.

## You

I’m horrible at UI/UX, so for the frontend of my new website, I let Claude Code do most of the heavy lifting 😅

But I didn’t just ask it to “make it look good.” I gave it a much better setup, tested the website across different cases and users, and made sure it actually felt usable in the browser.

I’ll put the 4 free tools I used in the comments 👇

[Claude Code, Claude AI, AI coding, vibe coding, frontend development, UI UX, web development, software engineering, AI engineering, artificial intelligence, machine learning, data science, generative AI, developer tools, coding tools, AI tools, web design, frontend design, Three.js, LLM, large language models, coding with AI, software development]
Taste Skill: helps avoid generic AI-looking UI.
2. Impeccable: helps review and improve the design and keep the UI consistent.
3. Awesome DESIGN.md: gives you ready-made design systems inspired by existing websites.
4. Img2ThreeJS: turns a reference image into an editable Three.js scene.

how can i use this?

## Cursor

I'll look up those four tools so the steps match how they actually work.

## Cursor

These four tools give the agent a design system, a style, a review pass, and an optional 3D scene. You still open the site in a browser and check real states yourself. They do not replace that.

Use them in this order.

## 1. Pick a look before anyone writes UI

[Awesome DESIGN.md](https://github.com/VoltAgent/awesome-design-md) is a folder of ready-made design systems copied from real sites (Linear, Vercel, Stripe, Notion, and others). Each file lists colors, type, spacing, buttons, and what not to do.

1. Open the list and pick one that matches the product. Linear is a calm product UI. Stripe is a marketing site. Notion is warm and spacious.
2. Copy that site's `DESIGN.md` into your project root.
3. Change the product name, one accent color, and the font so you are borrowing the system, not cloning the brand.

Then tell the agent: "Build the homepage. Follow `DESIGN.md`. Do not invent a new palette."

## 2. Stop the generic AI look

[Taste Skill](https://github.com/Leonxlnx/taste-skill) is a skill the agent loads while it writes the page. It pushes layout, type, spacing, and motion away from the usual Inter font, purple gradient, and cards-inside-cards.

From the project root:

```bash
npx skills add https://github.com/Leonxlnx/taste-skill --skill "design-taste-frontend"
```

The skill has three dials, each from 1 to 10, at the top of its `SKILL.md`:

| Dial | Low | High |
| --- | --- | --- |
| `DESIGN_VARIANCE` | Centered and simple | Asymmetric |
| `MOTION_INTENSITY` | Hover only | Scroll and magnetic motion |
| `VISUAL_DENSITY` | Lots of space | Dense, like a dashboard |

For a marketing site, start around variance 6, motion 3, density 3. For an app, lower variance and raise density.

## 3. Review it, then keep later pages consistent

[Impeccable](https://github.com/pbakaus/impeccable) is the review layer. It writes `PRODUCT.md` (who it is for, voice, what to avoid) and reads `DESIGN.md` on later edits. It also has checks for accessibility, spacing, type, and the same AI-looking patterns.

From the project root, for Cursor:

```bash
npx impeccable install --providers=cursor --scope=project
```

Reload Cursor, then ask it to run Impeccable init. In Claude Code the same step is `/impeccable init`.

After the first page exists, ask for these passes one at a time:

- **shape** before code, if you have not built the page yet
- **critique** for hierarchy and whether a first-time visitor understands it
- **audit** for accessibility, responsive layout, and performance
- **polish** before you ship
- **harden** for empty, error, and long-text states

`/impeccable live` in Claude Code lets you iterate on one element in the browser. In Cursor, ask the agent to use the Impeccable skill on a specific section, then check that section yourself.

## 4. Add 3D only if you have a reference object

[Img2ThreeJS](https://github.com/img2threejs/img2threejs) turns one photo of an object into editable Three.js code: a TypeScript factory that returns a `THREE.Group`, built from shapes and materials, not a locked mesh. Skip it for a normal website.

```bash
git clone https://github.com/img2threejs/img2threejs.git ~/.claude/skills/img2threejs
```

Attach the photo and say: "Rebuild this object as a Three.js model. Keep the proportions, angles, and colors." It builds in passes and checks each pass against the photo. Drop the factory into the page the other three tools already styled.

## One example

A notes app landing page, aimed at Linear's system, with a 3D notebook only in the hero.

1. Copy Linear's `DESIGN.md` into the repo. Rename the product and swap the purple accent.
2. Install Taste Skill. Set motion to 3 so the page stays quiet.
3. Install Impeccable and init it. Tell it the audience is people who write in markdown.
4. Ask: "Build the homepage from `DESIGN.md`. Hero, three features, pricing, footer. Follow the taste skill."
5. Open it in the browser. Check a short headline, a very long headline, mobile width, and an empty pricing state.
6. Ask for an Impeccable critique, then an audit, then a polish pass. Fix what those passes find and look again.
7. If you want the notebook, run Img2ThreeJS on a photo and place that component in the hero only.

The first three tools are what make the page feel designed. The fourth is optional scenery.

## You

will this help cursor?

## Cursor

Yes. Three of the four work in Cursor. The Three.js one is built for Claude Code and Codex, so Cursor only gets the code it produces.

| Tool | In Cursor |
| --- | --- |
| Taste Skill | Yes. `npx skills add` installs it as a Cursor skill, and later UI edits follow it. |
| Impeccable | Yes. Install with `npx impeccable install --providers=cursor --scope=project`, then reload Cursor. It writes into this project's `.cursor` folder. |
| Awesome DESIGN.md | Yes. Put `DESIGN.md` in the project root and tell Cursor to follow it. No plugin. |
| Img2ThreeJS | The `/img2threejs` command is for Claude Code. Cursor can still edit the Three.js file it generates. |

Installing them only into Claude Code's skill folder does nothing for this chat. They have to be installed for Cursor, in this project.

After that, a normal request is enough: "Build the homepage. Follow `DESIGN.md` and the taste skill." When the page exists, ask Cursor to run an Impeccable critique, then an audit. Open the page in the browser and check it yourself. The skills change what Cursor aims for and what it flags. They do not look at the screen for you.

## You

i want you to do it. but i want this be done global scale. so i can reuse it on other projects

## Cursor

I'll install these for Cursor at the user level so every project can use them, starting by checking where Cursor keeps global skills and how each tool installs.

## Cursor

Cursor keeps personal skills in your user folder, so I’ll install Taste Skill and Impeccable there, and put the design-system library and Img2ThreeJS next to them.

## Cursor

These four tools are installed for your Cursor account, so every project on this machine can use them. Start a new chat before relying on them. This conversation started before they were installed.

| Tool | What you get |
| --- | --- |
| Taste Skill | Steers landing pages and redesigns away from generic AI layouts. |
| Impeccable | Reviews and edits UI, and checks new UI writes for design problems. |
| Awesome DESIGN.md | 74 ready-made design systems from real sites. |
| Img2ThreeJS | Turns a reference photo into editable Three.js code. |

Nothing was copied into a project. The design system is chosen per project, when you ask.

In any project, say something like: "Build the homepage using the Linear design system." Cursor copies that system's `DESIGN.md` into the project and follows it. For a review, say "Run Impeccable critique on the homepage." For a 3D object, attach a photo and ask to rebuild it with Img2ThreeJS.

Taste Skill's layout, motion, and density dials live in one file. Change them once and every project inherits the change:

`C:\Users\maluk\.agents\skills\design-taste-frontend\SKILL.md`

## You

keep what we doing in a file. because i will do same in my work pc too. so all these tools will be installed there too

## Cursor

I’ll save a setup script you can copy to the work PC and run once, covering the same global installs.

## Cursor

The setup script’s skill text uses PowerShell escaping, so I’m checking that the file it writes is the same skill we installed here.

## Cursor

The setup is saved in `C:\Users\maluk\Documents\cursor-design-tools-setup.ps1`. Copy that file to the work PC and run it in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\Documents\cursor-design-tools-setup.ps1"
```

The work PC needs Git and Node.js. The script installs Taste Skill, Impeccable, the Awesome DESIGN.md library, and Img2ThreeJS for that Windows user, the same way they are installed here. Start a new Cursor chat after it finishes.

## You

name this repo as ishtiaqs way of coding. i need some good name

## Cursor

I’ll look for the repo first, then pick a name that reads like your way of coding rather than a literal phrase.

## Cursor

**ishtiaq-way** is the name to use.

It is short, it reads as your way of building rather than a folder of scripts, and it works as a GitHub repo: `ishtiaq-way`.

If you want a different tone, **ishtiaq-craft** sounds more like design and finish, and **ishtiaq-method** sounds more like a repeatable process.

## You

echo "# ishtiaq-craft" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:malukishtiaq/ishtiaq-craft.git
git push -u origin main

comit so i can pull on other pc

## Cursor

I’ll put the setup in a new `ishtiaq-craft` repo, commit it, and push so you can pull it on the work PC.

## Cursor

The commit is on this PC. GitHub rejected the push, so the work PC cannot pull it yet.

`ishtiaq-craft` is at `C:\Users\maluk\Documents\GitHub\ishtiaq-craft` on `main`, commit `edafd10` (“first commit”). It contains `README.md` and `cursor-design-tools-setup.ps1`. The remote is `git@github.com:malukishtiaq/ishtiaq-craft.git`.

GitHub refused both SSH keys on this machine (`id_ed25519_147` and `id_ed25519_server`), and the GitHub CLI is not logged in. Add `C:\Users\maluk\.ssh\id_ed25519_147.pub` to the GitHub account, and make sure the empty repo `malukishtiaq/ishtiaq-craft` exists. Then, from that folder:

```powershell
git push -u origin main
```

On the work PC:

```powershell
git clone git@github.com:malukishtiaq/ishtiaq-craft.git
powershell -ExecutionPolicy Bypass -File .\cursor-design-tools-setup.ps1
```

## Cursor

The GitHub SSH check hung and was stopped. It never logged in, so the push result is unchanged: `ishtiaq-craft` is committed locally on `main`, and GitHub still rejects the key. Add `C:\Users\maluk\.ssh\id_ed25519_147.pub` to that GitHub account, then run `git push -u origin main` from `C:\Users\maluk\Documents\GitHub\ishtiaq-craft`.
