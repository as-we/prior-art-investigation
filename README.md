# Prior Art Investigation Framework

**[日本語](docs/ja/README.md)**

---

## What It Does

You have a problem but don't know what it's called or if it's already solved.

**Example problem**: 
> "I want to use an LLM to generate training data and reasoning explanations, then teach a smaller ML model to replicate that behavior. How do I build this?"

**What this framework does**:
Before you design a solution, run an investigation:

```
@prior-art-investigation full I want to use LLM outputs to train a smaller ML model
```

It returns:

- **The name** — "Knowledge Distillation" (a 2015 technique by Hinton et al.)
- **Historical lineage** — How it evolved from model compression → neural network distillation → LLM distillation (2023+)
- **Existing OSS** — DistilBERT, LLaMA-Factory, Hugging Face transformers API, with evaluation of each
- **Known risks** — Data quality dependency, teacher model bias, training instability

Without this framework, you'd spend days searching "LLM training smaller model" and rarely find the term "knowledge distillation" that connects all existing work.

---

## How It Works

| Mode | Use When | Time | Tokens |
|------|----------|------|--------|
| **minimal** | Early concept check — just the name + quick OSS list | 5-10 min | ~150 |
| **full** | Design phase — research history, evaluation matrix, tradeoffs, risks | 20-40 min | ~500 |
| **selector** | Not sure which phase | 1-2 min | auto-routes |

<details>
<summary><strong>Example: Full investigation output</strong></summary>

**Input**: `@prior-art-investigation full I want to use LLM outputs to train a smaller ML model`

**Output**:

**Concept**: Knowledge Distillation

> This technique has a 10+ year history. It started as a model compression method (Hinton et al., 2015: "Distilling the Knowledge in a Neural Network"), evolved through DistilBERT (2019), MiniLM (2021), and exploded with LLM applications starting in 2023. The core insight: a small model can learn from a large model's outputs + reasoning, achieving 90% of performance at 10% of compute.

**Research lineage**:
| Year | Paper | Key Insight |
|------|-------|------------|
| 2015 | Hinton et al. "Distilling the Knowledge in a Neural Network" | Temperature-scaled softmax enables knowledge transfer |
| 2019 | Sanh et al. "DistilBERT" | BERT-scale distillation is practical |
| 2021 | Wang et al. "MiniLM" | Layer-wise intermediate matching improves small models |
| 2023 | Li et al. "Distilling Step-by-Step" | LLM reasoning can be distilled, not just outputs |
| 2024 | Craft et al. "LLaMA-Factory" | Production-ready distillation pipelines |

**OSS Evaluation Matrix**:
| Tool | Distillation Type | Reasoning Support | Ops Complexity | Best For |
|------|-----|---|---|---|
| Hugging Face transformers | Layer-wise | ❌ No | Low | Standard BERT-scale models |
| LLaMA-Factory | Full pipeline | ✅ Yes | Medium | LLM distillation end-to-end |
| Distil training code (papers) | Custom | ❌ No | High | Research, custom architectures |

**Key Risks**:
- **Teacher bias**: Small model inherits teacher's errors + biases
- **Data quality**: Without high-quality reasoning labels, distillation fails
- **Instability**: Temperature tuning and loss weighting are sensitive
- **Verify**: Always A/B test against direct training on data

</details>

---

## 3 Ways to Use

### 1. VS Code Copilot — 0 min setup

Copy `.instructions.md` to your Agent Skills folder:

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

### 2. Claude Desktop (MCP) — 5 min setup

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

### 3. Kiro SDD — hooks & personalities

Copy directly into your project:

```bash
cp -r .kiro/hooks /your-project/.kiro/
cp -r .kiro/personalities /your-project/.kiro/
```

Prior art investigation runs automatically at requirements and design phases.

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
