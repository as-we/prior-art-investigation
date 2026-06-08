---
description: "Prior art investigation — concept naming, OSS discovery, failure mode analysis"
---

# Prior Art Investigation

> Identify concept names, existing OSS, and failure risks **before** writing requirements, design, or code.
>
> **Depth is controlled by the `$ARGUMENTS` value passed by the hook or user:**
> - `minimal` — Q1 + Q6 only (~5 min). Use at **spec** phase.
> - `full` — All 7 questions + OSS matrix (~20 min). Use at **plan** phase.
> - `sowhat` — Q7 only (~2 min). Use at **tasks** phase.

## User Input

```text
$ARGUMENTS
```

Read the depth argument above. If empty, default to `full`.

---

## Context to Load First

Before starting, read the following if they exist in the project:
- `.specify/specs/[current feature]/spec.md` or `requirements.md` — feature description
- `research.md` in the current spec directory — prior research notes
- `kiro/settings/rules/oss-evaluation.md` or `.kiro/settings/rules/oss-evaluation.md` — full rule set

---

## Minimal Mode (Q1 + Q6) — for `before_specify`

Run only these two questions. Record answers in `research.md` under `## Prior Art (Quick Check)`.

### Q1 — First Principles
> "Is the problem framed correctly? Are we solving the right problem?"

- State the problem in one sentence
- Challenge the framing: is there a simpler version of this problem?
- Is there a well-known name for this problem or approach?

### Q6 — Inversion
> "How could this fail catastrophically? What should we verify before building?"

- Name the top 3 failure modes
- For each: is it architectural, performance, adoption, or security risk?
- Is there a known precedent of this failure in OSS or production systems?

**Output**: 2–4 bullet points per question. Add `[Named Concept: TBD]` if a concept name was found.

---

## Full Mode (All 7 Questions + OSS Matrix) — for `before_plan`

Run all questions. Record answers in `research.md` under `## Prior Art Investigation`.

### Q1 — First Principles
(same as minimal)

### Q2 — Null Hypothesis
> "Why hasn't this approach already become mainstream? If it's obvious, why isn't everyone doing it?"

- State why this is not already solved by existing tools
- If there IS an existing solution: should we use it instead of building?

### Q3 — Start with Failures
> "Who has tried this approach before and failed? How did they fail?"

- Search for postmortems, GitHub issues, HN threads about failures
- Name at least one known failure mode with a source

### Q4 — Find the Expert
> "Who has thought most deeply about this domain? Where are their words?"

- Name a key researcher, author, or practitioner
- Link to a paper, talk, RFC, or influential blog post

### Q5 — Read Primary Sources
> "Have you read the primary source — not a blog post, but the paper / RFC / commit log / issue?"

- Cite at least one primary source (arxiv, RFC, GitHub issue, original commit)
- Summarize the key insight in one sentence

### Q6 — Inversion
(same as minimal)

### Q7 — So What
> "You found the concept name. How does it change the design?"

- State the concept name found
- List 1–3 concrete design changes implied by prior art
- Identify any OSS libraries that can be adopted instead of building from scratch

### OSS Matrix

After completing Q1–Q7, produce a comparison table:

| Library / Tool | License | Stars (approx) | Actively maintained | Fits our use case | Notes |
|----------------|---------|----------------|--------------------|--------------------|-------|
| [name] | [MIT/Apache] | [★k] | [yes/no] | [yes/partial/no] | |

**Build vs Use decision**: Based on the matrix, state whether to build, adopt, or wrap an existing library.

**Output**: Full `research.md` section with all questions answered and OSS matrix.

---

## So-What Mode (Q7 only) — for `before_tasks`

> "You found the concept name. Do the current tasks reflect what you learned?"

Read the current `tasks.md` and `research.md`. For each non-trivial task, ask:

1. Does this task implement something that already exists in an OSS library? → Replace with adoption/wrapper task
2. Does this task ignore a known failure mode identified in prior art? → Add a mitigation task
3. Does the task list reflect the concept name's best practices? → Flag misaligned tasks

**Output**: List of tasks to add, remove, or modify based on prior art. Add these as comments or edits to `tasks.md`.
