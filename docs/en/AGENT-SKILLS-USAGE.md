# VS Code Copilot Agent Skills Setup

## Zero-Config Installation

### Step 1: Copy Agent Skills File

The Agent Skills definition is already in the repository:
```
.instructions.md  ← Agent Skills definition
```

If you're using this repo as a submodule/npm package:
```bash
# Option A: Clone directly
git clone https://github.com/ma2tani/prior-art-investigation.git
cd prior-art-investigation

# Option B: From npm
npm install @ma2tani/prior-art-investigation
```

### Step 2: Use in VS Code Copilot Chat

1. **Open Copilot Chat** (Cmd+Shift+I)
2. **Type your query:**

```
@prior-art-investigation minimal
I need to add real-time metric dashboards to our app
```

### That's It! 🎉

Copilot automatically:
- ✅ Loads the `.instructions.md` Agent Skills
- ✅ Routes to appropriate prompt (minimal/full/selector)
- ✅ Returns concept names + risks + OSS options

---

## Usage Examples

### Quick Requirements Check
```
@prior-art-investigation minimal
We're building a feature to let users share grooves with audio snippets

Q1: Is embedding audio in shares the real feature, or discovery?
Q6: What fails? Users can't listen without downloading?
```

### Deep Design Investigation
```
@prior-art-investigation full
Designing a new recommendation system for music based on groove patterns

→ Returns: Exact frameworks (collaborative filtering, content-based), 
OSS options (implicit, lightfm, surprise), risks + verification steps
```

### Auto-Routing
```
@prior-art-investigation selector
Not sure which phase I'm in for this ML inference optimization

→ Agent asks clarifying questions, routes to minimal or full
```

---

## Features

| Feature | Status |
|---------|--------|
| Phase-aware prompts (minimal/full/selector) | ✅ Ready |
| Bilingual (EN/JA) | ✅ Ready |
| Zero-config install | ✅ Ready |
| Kiro SDD integration | ✅ Works (saves to .kiro/) |
| MCP Server (Claude Desktop) | ✅ Ready (separate) |
| npm package import | ✅ Ready |

---

## How It Works

### Behind the Scenes

1. **You type**: `@prior-art-investigation minimal`
2. **Copilot** loads `.instructions.md` Agent Skills definition
3. **Agent selects**: MINIMAL prompt (150 tokens, Q1+Q6)
4. **Returns**: Concept name + risks + OSS options

```plaintext
@prior-art-investigation
    ↓
Load .instructions.md
    ↓
Detect "minimal" command
    ↓
Load docs/en/github/prompts/minimal.prompt.md
    ↓
Execute with Q1+Q6 framework
    ↓
Return results
```

---

## Integration Points

### With Kiro SDD
```bash
# Phase 1: Requirements
/kiro-spec-requirements FEATURE-NAME
→ Uses: @prior-art-investigation minimal internally
→ Saves: .kiro/specs/FEATURE/docs/research.md

# Phase 2: Design
/kiro-spec-design FEATURE-NAME
→ Uses: @prior-art-investigation full internally
→ Saves results to spec workflow
```

### With GitHub Copilot Workspace
```
# In a workspace chat:
@prior-art-investigation
Tell me if we should use Rust or Go for our real-time backend
→ Routes through selector, returns analysis
```

### With npm
```javascript
// In your own tools/workflow
import selectorPrompt from '@ma2tani/prior-art-investigation/prompts/selector';
import minimalPrompt from '@ma2tani/prior-art-investigation/prompts/minimal';
import fullPrompt from '@ma2tani/prior-art-investigation/prompts/full';

// Use prompts in your LLM calls
```

---

## Troubleshooting

### ❌ Agent doesn't appear
- [ ] Verify `.instructions.md` is in repo root
- [ ] Restart VS Code (`Cmd+Q` then reopen)
- [ ] Check Copilot Chat is enabled: Settings → Copilot Chat

### ❌ Prompts not loading
- [ ] Verify `docs/en/github/prompts/` exists
- [ ] Check file paths in `.instructions.md`
- [ ] Try: `@prior-art-investigation selector` (simpler)

### ❌ Different behavior than expected
- [ ] Agent Skills auto-route based on context
- [ ] Try specifying: `@prior-art-investigation minimal` (explicit)
- [ ] Or use selector first: `@prior-art-investigation selector`

---

## Commands Quick Reference

```
@prior-art-investigation minimal
→ Requirements phase (5-10 min, 150 tokens)

@prior-art-investigation full
→ Design phase (20-40 min, 500 tokens)

@prior-art-investigation selector
→ Auto-detect phase (1-2 min, 100 tokens)
```

---

## Next Steps

1. **Start here**: `@prior-art-investigation selector`
2. **Have a feature?** `@prior-art-investigation minimal [your feature]`
3. **Designing subsystem?** `@prior-art-investigation full [your subsystem]`

---

**Version**: 1.0.0  
**Status**: ✅ Ready to use  
**Last Updated**: 2026-04-14
