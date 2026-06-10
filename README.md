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
/prior-art full I want to use LLM outputs to train a smaller ML model
```

It returns:

- **The name** — "Knowledge Distillation" (a known research area since Hinton et al., 2015)
- **Research lineage** — Model compression → neural distillation → LLM distillation boom (2023+)
- **Existing OSS** — DistilBERT, LLaMA-Factory, Hugging Face transformers, with evaluation matrix
- **Known failure points** — Data quality dependency, teacher bias, training instability

---

## It Also Works for OSS and Technology Selection

Prior art investigation isn't only for research concepts. You don't need to be building ML systems to benefit.

**OCR / PDF library selection** — evaluating Tesseract vs EasyOCR vs cloud APIs before writing a single line of integration code. The framework surfaces accuracy benchmarks, license tiers, and maintenance health from primary sources.

**Programming language & runtime decisions** — when your stack has specific constraints (async model, ecosystem maturity, WASM support), the framework returns tradeoffs from real postmortems and RFC discussions rather than Stack Overflow opinions.

**Any new dependency decision** — the evaluation criteria in the prompts are not fixed. Because it's a prompt collection, you can adjust the selection matrix for your context. The underlying question is always:

> *What do I need to know before I commit to this?*

- Is this author an individual or an organization? (Long-term maintenance signal)
- When was the last commit? (Health signal)
- What's the license tier? (Legal risk signal — MIT/Apache = Tier 1, GPL = Tier 3, AGPL = do not adopt)
- How does it compare to the two closest alternatives?

---

## Modes & Output

| Mode | Phase | Time | What You Get |
|------|-------|------|-------------|
| `minimal` | Requirements / Spec | ~5 min | Concept name + quick OSS list + risk flags (Q1 + Q6) |
| `full` | Design / Plan | ~20 min | Research lineage + OSS matrix + tradeoffs + failure modes (Q1–Q7) |
| `sowhat` | Tasks | ~2 min | Which tasks to change based on prior art (Q7 only) |
| `selector` | Any | — | Auto-routes to minimal or full |

**The output gets recorded.** Each investigation writes to `research.md` — future team members (or future you) can see what was evaluated and why:

```
## Named Concept
| Field       | Value                                               |
|-------------|-----------------------------------------------------|
| Concept     | Knowledge Distillation                              |
| Published   | 2015 / Hinton et al., NeurIPS                       |
| Maturity    | ✅ Production Ready                                  |
| Design impact | Use temperature scaling; add quality gate on LLM labels |

## OSS Decision
| Package         | License    | Last Commit | Verdict                      |
|-----------------|------------|-------------|------------------------------|
| HF transformers | Apache-2.0 | Active      | ✅ Adopted                    |
| LLaMA-Factory   | Apache-2.0 | Active      | ❌ Overkill for this use case |
```

<details>
<summary><strong>Example: full mode output</strong></summary>

**Input**: `/prior-art full I want to use LLM outputs to train a smaller ML model`

**Concept**: Knowledge Distillation

> This technique has a 10+ year history. It started as a model compression method ([Hinton et al., 2015](https://arxiv.org/abs/1503.02531)), evolved through [DistilBERT](https://arxiv.org/abs/1910.01108) (2019) and [MiniLM](https://arxiv.org/abs/2002.10957) (2021), and exploded with LLM applications starting in 2023. Core insight: a small model can achieve 90% of performance at 10% of compute by learning from a large model's outputs and reasoning.

**Research lineage**:
| Year | Paper | Key Insight |
|------|-------|------------|
| 2015 | Hinton et al. ["Distilling the Knowledge in a Neural Network"](https://arxiv.org/abs/1503.02531) | Temperature-scaled softmax enables knowledge transfer |
| 2019 | Sanh et al. ["DistilBERT"](https://arxiv.org/abs/1910.01108) | BERT-scale distillation is practical |
| 2021 | Wang et al. ["MiniLM"](https://arxiv.org/abs/2002.10957) | Layer-wise matching improves small models |
| 2023 | Li et al. ["Distilling Step-by-Step"](https://arxiv.org/abs/2212.10071) | LLM reasoning can be distilled, not just outputs |
| 2024 | Zheng et al. ["LLaMA-Factory"](https://arxiv.org/abs/2403.13372) | Production-ready distillation pipelines |

**OSS Evaluation Matrix**:
| Tool | License | Maintainer | Updated | Data Prep | Best For | Source |
|------|---------|-----------|---------|-----------|----------|--------|
| Hugging Face transformers | Apache-2.0 | Hugging Face (org) | Active (weekly) | Low | Standard BERT-scale distillation | [GitHub](https://github.com/huggingface/transformers) |
| LLaMA-Factory | Apache-2.0 | HKUST / Tsinghua (academic org) | Active (monthly) | Medium | LLM distillation end-to-end | [GitHub](https://github.com/hiyouga/LLaMA-Factory) |
| Paper training code | Varies | Individual researchers | Stale | High | Research / custom architectures | [arXiv](https://arxiv.org/abs/2212.10071) |

**Key Risks**:
- **Teacher bias**: Small model inherits teacher's errors and biases
- **Data quality**: Without high-quality reasoning labels, distillation fails
- **Instability**: Temperature tuning and loss weighting are sensitive
- **Verify**: Always A/B test against direct training

</details>

---

## SDD Framework Integration

The framework runs at different depths **automatically** depending on the phase — no manual triggering needed.

| Phase | Depth | Questions | Auto-triggers in |
|-------|-------|-----------|-----------------|
| Requirements / Spec | Minimal | Q1 + Q6 | SpecKit `before_specify`, Kiro `requirements` hook, Claude Code CLAUDE.md |
| Design / Plan | Full | Q1–Q7 | SpecKit `before_plan`, Kiro `design` hook, Claude Code CLAUDE.md |
| Tasks | So-What | Q7 | SpecKit `before_tasks`, Claude Code CLAUDE.md |

**GitHub SpecKit** (VS Code + GitHub Copilot):
```bash
specify extension add https://github.com/as-we/prior-art-investigation
```
Registers `before_specify`, `before_plan`, `before_tasks` hooks automatically.

**Kiro SDD**: Copy `.kiro/hooks/` to your project — hooks fire at requirements and design phases.

**Claude Code**: Add `claude-code/CLAUDE.md.snippet` to your `CLAUDE.md` — persistent instruction fires at each phase automatically.

**Standalone** (any IDE): Use the `/prior-art` slash command or prompt files manually.

→ Full setup instructions: [Setup Guide](docs/en/SETUP.md)

---

## Quick Start

```bash
git clone https://github.com/as-we/prior-art-investigation
cd prior-art-investigation
make install
```

**One-time install, works across all your projects.** VS Code + Copilot Chat gains `/prior-art`. Add `#web` for live search beyond the training cutoff.

- Full setup (Kiro / Claude Desktop / Custom Agent) → [Setup Guide](docs/en/SETUP.md)
- Usage, reading output, when to skip → [Usage Guide](docs/en/USAGE.md)

---

**Version**: 1.1.1 | **License**: MIT

---

## Documentation

| | English | 日本語 |
|-|---------|--------|
| Overview | [README.md](./README.md) | [docs/ja/README.md](docs/ja/README.md) |
| Usage Guide (SDD workflow) | [docs/en/USAGE.md](docs/en/USAGE.md) | [docs/ja/USAGE.md](docs/ja/USAGE.md) |
| Setup Guide (installation) | [docs/en/SETUP.md](docs/en/SETUP.md) | [docs/ja/SETUP.md](docs/ja/SETUP.md) |
| Q1–Q8 Reference | [docs/en/QUESTIONS.md](docs/en/QUESTIONS.md) | [docs/ja/QUESTIONS.md](docs/ja/QUESTIONS.md) |

---

## License

MIT

- **GitHub**: https://github.com/as-we/prior-art-investigation
- **Release**: https://github.com/as-we/prior-art-investigation/releases/tag/v1.1.1
