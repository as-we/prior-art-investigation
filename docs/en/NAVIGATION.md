# Navigation & Quick Start

Welcome to **Prior Art Investigation** — a framework for identifying concept names, existing patterns, and OSS before writing code.

---

## 🎯 Quick Start (2 minutes)

### Step 1: Choose Your Entry Point

- **Using VS Code?** → [Agent Skills Setup](./AGENT-SKILLS-SETUP.md)
- **Using Claude Desktop?** → [MCP Setup](./MCP-SETUP.md)
- **Just learning?** → [Start with SELECTOR](./github/prompts/selector.prompt.md)
- **Using npm?** → [INSTALL.md](./INSTALL.md)

### Step 2: Pick Your Path

```
Before starting a feature?
├─ 5-10 min available → Run MINIMAL prompt
├─ 20-40 min available → Run FULL prompt
└─ Not sure? → Run SELECTOR first
```

---

## 📚 Complete Navigation

### For New Users

| Resource | Purpose | Time | Best For |
|----------|---------|------|----------|
| [SELECTOR](./github/prompts/selector.prompt.md) | Auto-route to right prompt | 1 min | Getting started |
| [MINIMAL](./github/prompts/minimal.prompt.md) | Quick validation (Q1+Q6) | 5-10 min | Requirements phase |
| [FULL](./github/prompts/full.prompt.md) | Deep investigation (Q1-Q7) | 20-40 min | Design phase |
| [Research Template](./templates/research.md) | Document your findings | - | Recording results |

### For Tool Setup

| Platform | Guide | Setup Time | Ongoing |
|----------|-------|-----------|---------|
| VS Code Copilot | [Agent Skills Setup](./AGENT-SKILLS-SETUP.md) | 2 min | Copy/paste |
| Claude Desktop | [MCP Setup](./MCP-SETUP.md) | 5 min | Server integration (v1.1+) |
| npm package | [INSTALL.md](./INSTALL.md) | 3 min | Import prompts |
| GitHub raw | [Raw URL](https://github.com/ma2tani/prior-art-investigation) | 1 min | curl/wget |

### For Detailed References

| Document | Purpose | Audience |
|----------|---------|----------|
| [OSS Evaluation Framework](./kiro/settings/rules/oss-evaluation.md) | Phase A/B rules for concept naming & OSS selection | Architects |
| [Research Template](./templates/research.md) | Structured record format | Everyone |
| [README.md](./README.md) | Project overview | Decision makers |

### For Integrations

| Integration | Status | Link |
|------------|--------|------|
| **Kiro SDD** | ✅ Fully supported | See [MCP-SETUP.md](./MCP-SETUP.md#-kiro-sdd-integration) |
| **Agent Skills** | ✅ Supported | [Agent Skills Setup](./AGENT-SKILLS-SETUP.md) |
| **MCP Server** | ⏳ Coming v1.1 | [MCP-SETUP.md](./MCP-SETUP.md#option-3-mcp-server-wrapper-future--v110) |
| **Docker** | ⏳ Coming v1.1 | [MCP-SETUP.md#roadmap](./MCP-SETUP.md#roadmap) |

---

## 🔍 Use Cases

### Case 1: "I have a feature idea, should I build it?"

1. Read: [MINIMAL prompt](./github/prompts/minimal.prompt.md)
2. Answer: Q1 (Is this the real problem?) + Q6 (What could fail?)
3. Record: [Research template](./templates/research.md)
4. Time: 5-10 minutes | Cost: ~150 tokens

---

### Case 2: "I need to design a new subsystem"

1. Start: [SELECTOR](./github/prompts/selector.prompt.md) → Routes to FULL
2. Run: [FULL prompt](./github/prompts/full.prompt.md) (all 7 questions)
3. Map: OSS ecosystem options
4. Record: [Research template](./templates/research.md)
5. Time: 20-40 minutes | Cost: ~500 tokens

---

### Case 3: "We're using Kiro SDD"

1. Phase 1 (Requirements): [MINIMAL](./github/prompts/minimal.prompt.md)
2. Phase 2-3 (Design): [FULL](./github/prompts/full.prompt.md)
3. Phase 4 (Tasks): Task Router (coming v1.2)
4. Save: `.kiro/specs/FEATURE/docs/research.md`
5. Total: ~725 tokens | Time: 45-60 minutes

---

## 📋 Decision Tree: Which Prompt?

```
START
│
├─ Do you have ≥20 minutes?
│  ├─ NO  → Use MINIMAL (5-10 min)
│  └─ YES ──────────────┐
│
└─ Is this a critical architecture decision?
   ├─ YES → Use FULL (20-40 min) 
   └─ NO  → Use MINIMAL
```

**Not sure?** Run [SELECTOR](./github/prompts/selector.prompt.md) first — it will guide you!

---

## 🔗 External Links

### Learn More About Prior Art
- [Wikipedia: Prior Art](https://en.wikipedia.org/wiki/Prior_art)
- [US Patent Office: Prior Art](https://www.uspto.gov/learning-and-resources/glossary/prior-art)

### GitHub Copilot / VS Code
- [VS Code Copilot Chat](https://code.visualstudio.com/docs/copilot/chat/copilot-chat)
- [Copilot Agents](https://code.visualstudio.com/docs/copilot/agents/overview)

### Model Context Protocol
- [MCP Documentation](https://modelcontextprotocol.io/)
- [MCP Registry](https://registry.modelcontextprotocol.io/)

### Kiro Spec-Driven Development
- See `.kiro/` directory in your project

---

## 📊 Feature Matrix

| Feature | v1.0.0 | v1.1.0 | v1.2.0 |
|---------|--------|--------|--------|
| **SELECTOR prompt** | ✅ | ✅ | ✅ |
| **MINIMAL/FULL prompts** | ✅ | ✅ | ✅ |
| **Research template** | ✅ | ✅ | ✅ |
| **npm distribution** | ✅ | ✅ | ✅ |
| **Bilingual (EN/JA)** | ✅ | ✅ | ✅ |
| **MCP Server wrapper** | - | ⏳ | ✅ |
| **Agent Skills template** | - | - | ⏳ |
| **Docker container** | - | ⏳ | ✅ |
| **Smithery registry** | - | - | ✅ |

---

## ❓ FAQ

### Where do I start if I'm new?

→ Read [SELECTOR](./github/prompts/selector.prompt.md) first. It will route you to the right prompt.

### Can I use this without coding?

→ Yes! All prompts are Markdown and work in any chat interface (Claude Desktop, VS Code, ChatGPT, etc.)

### How much does this cost?

→ Token usage depends on prompt:
- **MINIMAL**: ~150 tokens (5-10 min)
- **FULL**: ~500 tokens (20-40 min)
- **Total w/ Kiro**: ~725 tokens (45-60 min)

### Is this compatible with my editor?

→ Check [Tool Setup table](#for-tool-setup) above. If not listed, you can copy/paste prompts manually.

### How do I contribute?

→ See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

---

## 🎓 Learning Path

**Beginner (30 min)**
1. Read: [README.md](./README.md)
2. Run: [SELECTOR](./github/prompts/selector.prompt.md)
3. Execute: [MINIMAL](./github/prompts/minimal.prompt.md)

**Intermediate (1 hour)**
1. Review: [MINIMAL](./github/prompts/minimal.prompt.md) findings
2. Run: [FULL](./github/prompts/full.prompt.md)
3. Study: [OSS Evaluation Framework](./kiro/settings/rules/oss-evaluation.md)

**Advanced (2+ hours)**
1. Integrate with your project (Agent Skills / MCP)
2. Create team agent (see [Agent Skills Setup](./AGENT-SKILLS-SETUP.md))
3. Connect to Kiro SDD (see [MCP-SETUP.md](./MCP-SETUP.md#kiro-sdd-integration))

---

## 🆘 Need Help?

- **Questions?** → [GitHub Discussions](https://github.com/ma2tani/prior-art-investigation/discussions)
- **Found a bug?** → [GitHub Issues](https://github.com/ma2tani/prior-art-investigation/issues)
- **Quick question?** → [README.md FAQ](./README.md#faq)

---

**Last updated**: April 2026  
**Version**: 1.0.0  
**License**: MIT
