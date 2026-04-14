# VS Code Agent Skills Setup Guide

Register the Prior Art Investigation Framework as an Agent Skill in VS Code Copilot Chat.

---

## Prerequisites

- Visual Studio Code (latest)
- GitHub Copilot / Copilot Chat extension

---

## Setup Steps

### Step 1: Copy the Instructions File

```bash
# macOS
cp .instructions.md \
  ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/agent-skills/prior-art-investigation.md

# Linux
cp .instructions.md \
  ~/.config/Code/User/globalStorage/github.copilot-chat/agent-skills/prior-art-investigation.md

# Windows (PowerShell)
$dest = "$env:APPDATA\Code\User\globalStorage\github.copilot-chat\agent-skills"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item ".instructions.md" "$dest\prior-art-investigation.md"
```

### Step 2: Restart VS Code

### Step 3: Use in Copilot Chat

```
@prior-art-investigation minimal I need to design a rate limiter for our API
```

---

## Available Commands

| Command | Phase | Time | Tokens |
|---------|-------|------|--------|
| `@prior-art-investigation minimal` | Requirements | 5-10 min | ~150 |
| `@prior-art-investigation full` | Design | 20-40 min | ~500 |
| `@prior-art-investigation selector` | Unsure | 1-2 min | ~100 |

---

## Troubleshooting

**Agent not appearing**: Verify the file was copied, then fully restart VS Code.

**Errors in output**: Check your Copilot Chat version (latest recommended) and confirm `.instructions.md` is complete.

---

## Related Docs

- [README.md](./README.md) — Overview & full guide
- [MCP-SETUP.md](./MCP-SETUP.md) — Setup for Claude Desktop

---

**Version**: 1.0.0
