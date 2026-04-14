# VS Code Copilot Agent Skills Setup Guide

## Overview

Prior Art Investigation is fully compatible with **GitHub Copilot Agent Skills** in VS Code, with **no setup required** beyond copying prompts.

> **Recommended for**: VS Code users, initial learning  
> **Setup time**: 2 minutes  
> **Compatibility**: Copilot Free & Pro  

---

## Quick Start (Copy/Paste Method)

### Step 1: Open VS Code Chat

```
⌃⌘I  (Mac)  or  Ctrl+Shift+I  (Windows)
```

### Step 2: Use SELECTOR Prompt

Copy the **SELECTOR** prompt and paste into chat:

```bash
# Get the prion-art-investigation selector prompt
curl -s https://raw.githubusercontent.com/ma2tani/prior-art-investigation/main/docs/en/github/prompts/selector.prompt.md
```

Or manually copy from: [docs/en/github/prompts/selector.prompt.md](../github/prompts/selector.prompt.md)

### Step 3: Chat Determines Your Phase

Chat shows 3 routing questions:

```
✓ Feature Status [Named/Unnamed]
✓ Time Available [<10min / 10-30min / 30+min]
✓ Criticality [Incremental / Important / Critical]

→ Recommendation: Use MINIMAL or FULL ✓
```

### Step 4: Chat Routes to Right Prompt

Chat suggests the appropriate prompt:

```
🟢 Your situation matches MINIMAL prompt ✓

→ Copy & run: [minimal.prompt.md](../github/prompts/minimal.prompt.md)
```

---

## Advanced: Create Custom Agent

### Option A: Persistent Agent in VS Code

Create `.vscode/agent-prior-art.md`:

```bash
mkdir -p .vscode
cat > .vscode/agent-prior-art.md << 'EOF'
# @vs/code/agent/prior-art-research

**Purpose**: Quick prior art investigation

> **When to use**: Before writing requirements or design
> **Time**: 5-40 min depending on phase

[Copy SELECTOR prompt content here...]
EOF
```

Then in chat, reference it:

```
@prior-art [your question]
```

---

### Option B: Project-Specific Agent

Create `.copilot-instructions.md` in your project root:

```bash
cat > .copilot-instructions.md << 'EOF'
# Prior Art Workflow

When users ask about "prior art", "research", or "concept naming":
1. Load SELECTOR prompt
2. Ask the user 3 routing questions
3. Recommend MINIMAL or FULL
4. Execute the selected prompt

Prior Art Investigation Repo:
https://github.com/ma2tani/prior-art-investigation
EOF
```

---

## Integration Patterns

### Pattern 1: One-Off Investigation

**Best for**: Quick validation, learning

```
1. Open VS Code Chat (⌃⌘I)
2. Paste SELECTOR prompt
3. Answer 3 questions
4. Get MINIMAL or FULL recommendation
5. Copy & run recommended prompt
```

**Setup**: 2 minutes  
**Execution**: 5-40 minutes  
**Cost**: ~150-500 tokens

---

### Pattern 2: Project Agent

**Best for**: Teams, recurring investigations

```bash
# Create team agent in repo `.vscode/agent-prior-art.md`
# Team members just type:
@prior-art [feature name]

# Agent automatically:
# ✓ Routes to MINIMAL/FULL
# ✓ Checks Kiro SDD phase
# ✓ Records findings in docs/
```

---

### Pattern 3: Kiro SDD Integration

**Best for**: Organizations using Kiro spec-driven development

Create `.vscode/agent-kiro-sdd.md`:

```markdown
# @vs/code/agent/kiro-research

**For Kiro SDD projects**, prior-art investigation is Phase 1 activity:

| Kiro Phase | Agent Action | Time | Tokens |
|-----------|-------------|------|---------|
| Phase 1: Requirements | Run SELECTOR → MINIMAL | 10min | ~150 |
| Phase 2: Design | Run FULL prompt | 30min | ~500 |
| Phase 4: Tasks | Verify Q7 alignment | 5min | ~75 |

**Workflow**:
1. User: "I need prior art research for feature X"
2. Agent checks Kiro phase (git/kiro/specs/)
3. Agent automatically runs appropriate prompt
4. Agent saves findings to Kiro spec
```

---

## Configuration Examples

### Example: Tech Team at Startup

**File**: `.vscode/settings.json`

```json
{
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": true
  },
  "copilot.chat.useProjectContext": true,
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

**File**: `.copilot-instructions.md`

```bash
# Product guidance for AI research

Use Prior Art Investigation framework for all new features:
- GitHub repo: github.com/ma2tani/prior-art-investigation
- When: Before requirements, design, or tasks phase
- How: Use @prior-art agent in chat
```

### Example: Enterprise with Kiro SDD

**File**: `.vscode/agent-kiro.md`

```markdown
# Kiro SDD Integration Agent

Kiro is our internal spec-driven development framework.
Prior Art Investigation integrates at Phase 1 & 2.

**User prompt**: "I need prior art for [feature]"  
**Agent action**: 
1. Check current Kiro phase from `.kiro/specs/`
2. Route to appropriate prompt (MINIMAL/FULL)
3. Execute using $ prompt helper
4. Save findings to `docs/research.md`

Reference: [MCP-SETUP.md](../MCP-SETUP.md#integration-patterns)
```

---

## Troubleshooting

### Q: "Chat doesn't remember my phase selection"

**A**: Agent Skills has stateless chat sessions. Use the SELECTOR→MINIMAL/FULL workflow:

```
Session 1: Chat runs SELECTOR
Session 2: User copies MINIMAL prompt manually
```

**Workaround**: Create `.vscode/agent-prior-art.md` to preserve context.

---

### Q: "Can I save findings to my Kiro spec?"

**A**: Yes! Use the research template:

```bash
# After running FULL prompt
# Copy findings into:
.kiro/specs/FEATURE-NAME/docs/research.md
```

See: [../templates/research.md](../templates/research.md)

---

### Q: "How many tokens does this cost?"

| Phase | Prompt | Tokens | Time |
|-------|--------|--------|------|
| Requirements | MINIMAL | ~150 | 5-10 min |
| Design | FULL | ~500 | 20-40 min |
| Task | Router | ~75 | 5 min |

> **Total for 1 feature**: ~725 tokens (vs ~2000+ without prior art)

---

## FAQ

### Can I use this in VS Code without Copilot?

No, this requires GitHub Copilot. Free plan (`Copilot Free`) is supported.

### Does this work with other code editors?

- ✅ Claude Desktop (manual copy/paste)
- ✅ ChatGPT / Claude.ai (browser)
- ⚠️ Other editors (manual workflow only)

### Can I integrate this with our team's tools?

Yes! See patterns in [Option B](#option-b-project-specific-agent) and [Integration Patterns](#integration-patterns).

---

## Roadmap

### Current (v1.0.0)
- ✅ Markdown-based prompts work in all agents
- ✅ Copy/paste method proven
- ✅ SELECTOR routing works in chat

### v1.2.0 (Q3 2026)
- [ ] Native Agent Skills template
- [ ] Kiro SDD agent personality
- [ ] Auto-save to workspace

---

## Links

- **Repository**: https://github.com/ma2tani/prior-art-investigation
- **GitHub Copilot docs**: https://code.visualstudio.com/docs/copilot/
- **Agent Skills guide**: https://code.visualstudio.com/docs/copilot/agents/overview
- **Kiro SDD**: See `.kiro/` in your project

---

**License**: MIT  
**Support**: github.com/ma2tani/prior-art-investigation/issues
