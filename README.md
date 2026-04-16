# Prior Art Investigation Framework

**[日本語](docs/ja/README.md)**

---

## What It Does

With spec-driven development (SDD), you can move from idea to implementation using plain problem statements.

For example:
> "I want to use an LLM to generate reasoning explanations, then train a smaller ML model on those outputs."

That single sentence is enough to drive requirements, design, and implementation. **But there's a blind spot.**

A well-established research field called "Knowledge Distillation" already exists — with 10+ years of papers, OSS tools, and documented failure patterns. Without knowing that term, you'd rebuild it from scratch, convinced you invented it.

**This framework eliminates that blind spot before you start designing.**

```
@prior-art-investigation full I want to use LLM outputs to train a smaller ML model
```

It returns:

- **The name** — "Knowledge Distillation" (a known research area since Hinton et al., 2015)
- **Research lineage** — Model compression → neural distillation → LLM distillation boom (2023+)
- **Existing OSS** — DistilBERT, LLaMA-Factory, Hugging Face transformers, with evaluation matrix
- **Known failure points** — Data quality dependency, teacher bias, training instability

---

## How It Works

| Mode | Use When | Output |
|------|----------|---------|
| **minimal** | Early concept check, before design | Concept name + quick OSS list + risk flags |
| **full** | Architecture decisions, new subsystem design | Research lineage + OSS matrix + tradeoffs + failure modes |
| **selector** | Not sure which to use | Auto-routes to minimal or full |

<details>
<summary><strong>Example: Full investigation output</strong></summary>

**Input**: `@prior-art-investigation full I want to use LLM outputs to train a smaller ML model`

**Output**:

**Concept**: Knowledge Distillation

> This technique has a 10+ year history. It started as a model compression method ([Hinton et al., 2015](https://arxiv.org/abs/1503.02531): "Distilling the Knowledge in a Neural Network"), evolved through [DistilBERT](https://arxiv.org/abs/1910.01108) (2019), [MiniLM](https://arxiv.org/abs/2002.10957) (2021), and exploded with LLM applications starting in 2023. The core insight: a small model can learn from a large model's outputs + reasoning, achieving 90% of performance at 10% of compute.

**Research lineage**:
| Year | Paper | Key Insight |
|------|-------|------------|
| 2015 | Hinton et al. ["Distilling the Knowledge in a Neural Network"](https://arxiv.org/abs/1503.02531) | Temperature-scaled softmax enables knowledge transfer |
| 2019 | Sanh et al. ["DistilBERT"](https://arxiv.org/abs/1910.01108) | BERT-scale distillation is practical |
| 2021 | Wang et al. ["MiniLM"](https://arxiv.org/abs/2002.10957) | Layer-wise intermediate matching improves small models |
| 2023 | Li et al. ["Distilling Step-by-Step"](https://arxiv.org/abs/2212.10071) | LLM reasoning can be distilled, not just outputs |
| 2024 | Zheng et al. ["LLaMA-Factory"](https://arxiv.org/abs/2403.13372) | Production-ready distillation pipelines |

**OSS Evaluation Matrix**:
| Tool | License | Maintainer | Updated | Data Prep | Best For | Source |
|------|---------|-----------|---------|-----------|----------|--------|
| Hugging Face transformers | Apache-2.0 | Hugging Face (org) | Active (weekly) | Low | Standard BERT-scale distillation | [GitHub](https://github.com/huggingface/transformers) |
| LLaMA-Factory | Apache-2.0 | HKUST / Tsinghua (academic org) | Active (monthly) | Medium | LLM distillation end-to-end | [GitHub](https://github.com/hiyouga/LLaMA-Factory) |
| Paper training code | Varies | Individual researchers | Stale | High | Research / custom architectures | [arXiv](https://arxiv.org/abs/2212.10071) |

**Key Risks**:
- **Teacher bias**: Small model inherits teacher's errors + biases
- **Data quality**: Without high-quality reasoning labels, distillation fails
- **Instability**: Temperature tuning and loss weighting are sensitive
- **Verify**: Always A/B test against direct training on data

</details>

---

## 4 Ways to Use

### 1. VS Code Custom Agent — 0 min setup (recommended)

> Requires: VS Code with GitHub Copilot Chat

The `.github/agents/prior-art.agent.md` file in this repo is a **VS Code Custom Agent** (introduced in VS Code 1.99 / April 2025, updated schema April 2026).

**In this repo** — just select the agent from the chat dropdown:

1. Open Copilot Chat (`⌃⌘I`)
2. Click the agent selector → choose **Prior Art Investigation**
3. The agent auto-checks `git diff HEAD` and runs investigation if spec files changed

**In your project** — copy the agent file:

```bash
mkdir -p .github/agents
cp path/to/prior-art-investigation/.github/agents/prior-art.agent.md .github/agents/
```

Select **Prior Art Investigation** from the Copilot Chat dropdown → done.

> **Note**: `.chatmode.md` was the old format (deprecated). VS Code 1.99+ uses `.github/agents/*.agent.md`. If you have old `.chatmode.md` files, rename them.

---

### 2. VS Code Agent Skills (cross-workspace) — 2 min setup

Copy `.instructions.md` to your Agent Skills folder to use across **all projects**:

```bash
# macOS
cp .instructions.md \
  ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/agent-skills/prior-art-investigation.md

# Linux
cp .instructions.md \
  ~/.config/Code/User/globalStorage/github.copilot-chat/agent-skills/prior-art-investigation.md
```

Then use in Copilot Chat:

```
@prior-art-investigation minimal I need a real-time caching layer for our API
```

→ [Full setup guide](docs/en/AGENT-SKILLS-SETUP.md)

---

### 3. Claude Desktop (MCP) — 5 min setup

Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "prior-art-investigation": {
      "command": "python3",
      "args": ["/path/to/prior-art-investigation/mcp/server_lite.py"]
    }
  }
}
```

Restart Claude Desktop → 3 tools available: `load_minimal`, `load_full`, `load_selector`.

→ [Full setup guide](docs/en/MCP-SETUP.md)

---

### 4. Kiro SDD — hooks & personalities

Copy directly into your project:

```bash
cp -r .kiro/hooks /your-project/.kiro/
cp -r .kiro/personalities /your-project/.kiro/
```

Prior art investigation runs automatically at requirements and design phases.

#### VS Code Copilot Chat: Hook Format & Disabling

The `.kiro/hooks/` directory includes both **Kiro IDE** format (`.json` with `enabled` flag) and **VS Code** format (`.kiro.hook` with `agentStop` trigger).

**VS Code setup** (copy `.kiro.hook` files, not `.json`):
```bash
cp .kiro/hooks/*.kiro.hook /your-project/.kiro/hooks/
```

Hooks are **disabled by default** (`"enabled": false`). To enable:
```bash
# Enable auto-investigation for requirements phase
# Edit .kiro/hooks/prior-art-requirements.kiro.hook:
# Change "enabled": false to "enabled": true

# Enable auto-investigation for design phase
# Edit .kiro/hooks/prior-art-design.kiro.hook:
# Change "enabled": false to "enabled": true
```

> **Recommended**: Use the [VS Code Custom Agent](#1-vs-code-custom-agent--0-min-setup-recommended) approach instead.
> Switch to the agent only when needed — no file editing required.

**Note**: VS Code hooks use `agentStop` trigger + git diff detection (checks if `requirements.md` or `design.md` changed). Kiro IDE hooks use command-specific triggers (`after_kiro_spec_requirements`, `after_kiro_spec_design`).

#### GitHub Copilot Cloud Agent (Browser) — Different Schema

**VS Code** and **GitHub Copilot Cloud Agent** (copilot.github.com) use `.github/hooks/` but with incompatible schemas:

| Item | VS Code | GitHub Cloud Agent |
|------|---------|--------------------|
| `version` | Not required | `1` required |
| Event name case | PascalCase (`UserPromptSubmit`) | camelCase (`userPromptSubmitted`) |
| Script keys | `command` / `osx` / `linux` | `bash` / `powershell` |
| Timeout key | `timeout` | `timeoutSec` |
| `agentStop` | `"Stop"` | `"sessionEnd"` |

This framework's `.kiro.hook` files target **VS Code Copilot Chat**. Cloud Agent users need a separate hook file with the Cloud Agent schema. See [VS Code hooks docs](https://code.visualstudio.com/docs/copilot/copilot-extensibility-overview) and [GitHub Cloud Agent hooks docs](https://docs.github.com/en/copilot/reference/hooks-configuration).

---

## Optional: Control Hook Execution

**Recommended approach**: Use the [VS Code Custom Agent](#1-vs-code-custom-agent--0-min-setup-recommended). Switch to the "Prior Art Investigation" agent from the chat dropdown only when investigation is needed — no file editing required.

**Legacy hook approach** (if you prefer file-based hooks):

Each prior art investigation increases token consumption. Hooks are **disabled by default** and can be enabled per-project:

### Enable hooks
1. Open `.kiro/hooks/prior-art-requirements.kiro.hook`
2. Change `"enabled": false` to `"enabled": true`
3. Repeat for `.kiro/hooks/prior-art-design.kiro.hook`

### When to enable
- **Greenfield / zero-to-one projects** — unknown territory, high discovery value
- **Major architecture decisions** — new subsystem design, new dependency selection
- **Technology selection** — choosing between OSS options

### When to keep disabled
- **Maintenance / refactoring** — existing codebase, no new paradigms
- **Well-known patterns** — already familiar with the domain
- **Token budget constraint** — running multiple investigations in parallel

---

## Personalities (Kiro SDD)

Switch investigation focus by selecting a personality:

| Personality | Focus |
|-------------|-------|
| `researcher` | Academic papers, citations, prior research |
| `startup-hunter` | Market validation, competitor analysis, startup trends |
| `tech-auditor` | Technical depth, architecture, engineering best practices |
| `patent-search` | IP risk, patent landscape, prior art claims |
| `team-internal` | Internal knowledge, existing docs, in-house patterns |
| `platform-expert` | IDE/runtime native APIs, platform hooks, SDK capabilities — avoids re-inventing what the platform already provides |

---

## Customization

Extend the framework by adding your own personalities, modes, or integration hooks.

See `.kiro/personalities/` and `.kiro/hooks/` for examples.

---

## Documentation

Language-specific setup guides:

| | English | 日本語 |
|-|---------|--------|
| VS Code setup | [docs/en/AGENT-SKILLS-SETUP.md](docs/en/AGENT-SKILLS-SETUP.md) | [docs/ja/AGENT-SKILLS-SETUP.md](docs/ja/AGENT-SKILLS-SETUP.md) |
| Claude setup | [docs/en/MCP-SETUP.md](docs/en/MCP-SETUP.md) | [docs/ja/MCP-SETUP.md](docs/ja/MCP-SETUP.md) |

---

## License

MIT

- **GitHub**: https://github.com/as-we/prior-art-investigation
- **Release**: https://github.com/as-we/prior-art-investigation/releases/tag/v1.0.0
