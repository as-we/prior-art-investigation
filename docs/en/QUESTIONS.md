# Investigation Framework Q1–Q8 Reference

The `full` mode runs eight questions (Q1–Q8) in sequence.  
Below is the **intent, what is asked, and expected output** for each question.

> `minimal` mode uses Q1 + Q6 only.

---

## Q1: First Principles

**Intent**: Verify "are we solving the right problem?" — challenge the problem definition, not just the solution.

**Asks**:
- Is the problem definition correct?
- Are we solving root causes, not surface symptoms?
- What is the simplest way to state this without jargon?

**Sample**:

> Input: "API responses are slow"  
> Q1 insight: "The real problem is N+1 database queries, not response speed. Optimize queries before adding a cache."

**Why it matters**: Perfectly solving the wrong problem wastes weeks. Q1 catches this before any design work begins.

---

## Q2: Concept Name

**Intent**: Identify what this problem and solution are called in existing research and engineering literature.

**Asks**:
- Does this problem already have a name?
- Which established patterns or paradigms apply?
- What is the research lineage? (key papers by year)

**Sample**:

| Year | Paper | Key Insight |
|------|-------|------------|
| 2015 | [Hinton et al. "Distilling the Knowledge in a Neural Network"](https://arxiv.org/abs/1503.02531) | Temperature-scaled softmax enables knowledge transfer |
| 2019 | [Sanh et al. "DistilBERT"](https://arxiv.org/abs/1910.01108) | BERT-scale distillation is practical |
| 2023 | [Li et al. "Distilling Step-by-Step"](https://arxiv.org/abs/2212.10071) | LLM reasoning can be distilled, not just outputs |

**Why it matters**: Once you have the concept name, you can search existing documentation, OSS, and failure cases. No need to invent from scratch.

---

## Q3: Technical Options

**Intent**: Enumerate the full space of approaches and architectures available for this problem.

**Asks**:
- What algorithms or architecture patterns exist?
- What are the tradeoffs between them?

**Sample**:

> Options for "distributed cache":
> - Cache-Aside pattern (app controls it, flexible)
> - Write-Through (synchronous on write, high consistency)
> - Read-Through (library controls it, simpler code)
> - Event-Driven Invalidation (invalidate on change events)

---

## Q4: OSS Ecosystem

**Intent**: Check whether this is already solved by existing OSS before building from scratch.

**Required output columns**:

| Tool | License | Maintainer | Updated | Data Prep | Best For | Source |
|------|---------|-----------|---------|-----------|----------|--------|
| Redis | BSD-3 | Redis Ltd (org) | Active (weekly) | Low | General-purpose cache, session management | [GitHub](https://github.com/redis/redis) |
| Dragonfly | BSL-1.1 | Dragonfly DB (org) | Active (monthly) | Low | Redis-compatible, high throughput | [GitHub](https://github.com/dragonflydb/dragonfly) |

**Why it matters**: OSS lets you offload maintenance, security patches, and documentation to the community. Q4 lets you weigh adoption cost vs. build cost.

---

## Q5: Architecture Choice

**Intent**: Given Q3–Q4, produce a concrete recommendation for what to use and why.

**Asks**:
- Which OSS or approach should we adopt, and why?
- What are the tradeoffs between adopting vs. building?

**Sample**:

> "For Knowledge Distillation: recommend LLaMA-Factory. Reasons: (1) production-ready pipeline, (2) Apache-2.0 license for commercial use, (3) native Hugging Face integration. If a custom distillation architecture is needed, use Hugging Face transformers directly for more flexibility."

---

## Q6: Inversion

**Intent**: Think from the failure scenario, not the success scenario.

**Asks**:
- If this fails spectacularly in 6 months, what caused it?
- Which assumptions might be wrong?
- What must be validated **before** proceeding?

**Sample**:

> "Distributed cache failure scenarios:
> - Cache invalidation timing inconsistency → stale data surfacing
> - Cache size underestimated → OOM crash
> - Write-Through too slow → latency gets worse, not better
>
> Must validate: simulate production traffic cache hit rate before committing"

**Why it matters**: `minimal` mode always runs Q6. It's the most important risk check before any design decision.

---

## Q7: Next Steps

**Intent**: Translate investigation results into concrete, prioritized actions.

**Asks**:
- What are the prioritized next actions to move forward?

**Sample**:

> 1. Build a PoC with OSS and measure cache hit rate on real traffic (1 week)
> 2. Confirm license (BSL-1.1 may restrict commercial use — check with legal)
> 3. Calculate cache size ceiling from production memory limits
> 4. Define cache invalidation test strategy in the design phase

---

## Q8: Platform Native Capabilities

**Intent**: Check whether the target platform (VS Code, GitHub, Azure, AWS, etc.) already natively provides the capability — before building it yourself.

**Asks**:
- Does this platform already solve this problem natively?
- Have you checked the official docs, the last 6 months of Changelog, and GitHub Releases?
- Are you about to re-invent something the platform gives you for free?

**Sample**:

> "We were planning to build a custom hook system for VS Code. Q8 revealed that VS Code 1.99 (April 2025) introduced `UserPromptSubmit` / `PostToolUse` lifecycle hooks natively. No custom implementation needed — just add a `.github/hooks/*.json` config file."
>
> Source: [VS Code Hooks documentation](https://code.visualstudio.com/docs/copilot/customization/hooks) (updated April 2026)

**Why it matters**: Platform-native capabilities require zero maintenance on your part. Unlike other questions where arXiv papers are the primary source, **Q8 targets official docs and Changelogs** — that's what makes it distinct from Q2–Q5.
