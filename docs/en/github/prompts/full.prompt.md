---
agent: agent
description: Prior Art Investigation — FULL (Design Phase) — Seven-question deep discovery framework
version: 2026.1
phase: Design
tokens: ~500
---

# Prior Art Investigation — FULL (Design Phase)

> **Purpose**: Comprehensive prior art & prior invention investigation before design  
> **Time**: 20-40 minutes  
> **Output**: Named concept + OSS ecosystem map + Design impact analysis  
> **Audience**: Architects, senior engineers, research-oriented teams

---

## When to Run

Execute this prompt at design phase start:

| Phase | Questions | Depth |
|-------|-----------|-------|
| **Design** | All 7 questions (Q1-Q7) | Full investigation |
| **Comprehensive** | With Phase A + B framework | Named concept + OSS decision |

---

## Step 1: Load Context

Confirm you have:
1. **Problem description** (1-2 paragraphs, technical detail)
2. **Technology layers involved**: ML/AI・Backend・Frontend・Data・Infrastructure・Security
3. **Requirements baseline** (what must be true for success)
4. **Any existing concept names or references** (if any)

---

## Step 2: Apply Seven Design Investigation Questions

Ask each question in order. Record answer before moving to next.

### **Q1: First Principles** (3-5 min)

*"Is the problem framework correct? Are you solving the right problem?"*

**Action:**
- State problem in simplest terms (strip all jargon)
- Verify: "Is this the real problem or a symptom?"
- Verify: "Is this the right level of abstraction?"

**Record:**
```markdown
### Q1 Response
- Original problem statement: [...]
- Simplified: [...]
- Reframed as: [...]
- Confidence: 70% / 80% / 90%
```

---

### **Q2: Null Hypothesis** (5-7 min)

*"Why hasn't this approach already become mainstream? If obvious, it would be mainstream — why isn't it?"*

**Action:**
- Research: "Has someone already solved this?"
- If yes: "Why didn't it become industry standard?"
- If no: "What's blocking adoption?"

**Record:**
```markdown
### Q2 Response
- Existing approaches: [List 2-3]
- Why not mainstream:
  • Technical barrier: [...]
  • Economic barrier: [...]
  • Organizational barrier: [...]
- Potential differentiation: [...]
```

---

### **Q3: Start with Failure** (5-10 min)

*"How many people have failed with this approach? How did they fail?"*

**Action:**
- Search: GitHub Issues, arXiv papers, Stack Overflow, Reddit
- Find: 2-3 documented failures or abandoned projects
- Analyze: What went wrong?

**Record:**
```markdown
### Q3 Response
- Failed project 1: [Project name] 
  Why failed: [Technical reason]
- Failed project 2: [Project name]
  Why failed: [Architectural reason]
- Common failure pattern: [...]
- What to avoid: [...]
```

---

### **Q4: Find the Expert** (5-10 min)

*"Who thinks deepest about this domain? Where are their words published?"*

**Action:**
- Identify: Leading researcher, architect, or practitioner
- Find: Papers, RFCs, blog posts, conference talks
- Extract: Key insights specific to your problem

**Record:**
```markdown
### Q4 Response
- Expert identified: [Name, affiliation]
- Primary source 1: [Title, link]
  Key insight: [...]
- Primary source 2: [Title, link]
  Key insight: [...]
- Domain pattern: [...]
```

---

### **Q5: Read Primary Sources** (10-15 min)

*"Have you read primary sources (papers, RFCs, commit logs, Issues) — not just READMEs or blog posts?"*

**Action:**
- Read: At least 2 peer-reviewed papers or established RFCs
- Read: GitHub Issues from leading implementations
- Extract: Design decisions + trade-offs documented

**Record:**
```markdown
### Q5 Response
- Paper 1: [Title, year]
  Design insight: [...]
  Trade-off: [...]
- RFC / Standard: [Name, version]
  Relevant section: [...]
- Implementation notes: [Link to GitHub issue/commit]
  Decision rationale: [...]
```

---

### **Q6: Inversion** (3-5 min)

*"If this failed in the worst way possible, what would be the cause? What should you verify?"*

**Action:**
- Assume worst-case failure in 6-12 months
- Identify: Root cause (architectural, behavioral, economic)
- Plan: Verification tests pre-design

**Record:**
```markdown
### Q6 Response
- Failure scenario 1: [Describes worst case]
  Root cause: [...]
  Verification needed: [Test/metric]
- Failure scenario 2: [...]
  Root cause: [...]
  Verification needed: [Test/metric]
```

---

### **Q7: So What** (5-10 min)

*"Now that you've named the concept, how does it change your design?"*

**Action:**
- Name the concept (if you found it in prior art)
- Or innovate: "This is novel combination of X + Y"
- Translate discovery into design impact

**Record:**
```markdown
### Q7 Response
- Concept name: [Established name or novel combination]
- Design impact:
  • Architecture change: [...]
  • API boundary: [...]
  • Data model: [...]
- Why this matters: [How prior art changes your approach]
```

---

## Step 3: Build OSS Ecosystem Map

Once all 7 questions answered, map OSS candidates:

| Package | License | Last Update | Stars | Decision |
|---------|---------|-------------|-------|----------|
| [Pkg 1] | MIT | [Date] | [#] | Build vs Use? |
| [Pkg 2] | Apache-2.0 | [Date] | [#] | Build vs Use? |
| [Pkg 3] | GPL-3.0 | [Date] | [#] | Build vs Use? |

**Decision criteria:**
- [ ] Maintenance active (commits < 1 year old)
- [ ] License compatible (check vs your project)
- [ ] API stability (v1.0+, not v0.x)
- [ ] Community size (50+ stars, active issues)

---

## Step 4: Design Impact Summary

Synthesize into 1-page design note:

```markdown
## Prior Art Investigation Summary

### Concept
[Named concept from Q7]

### Key Finding
[Most important discovery from Q1-Q6]

### Design Decision
- **Build vs Use**: [Which OSS to build on, or build from scratch]
- **Architectural implication**: [How this changes design]
- **Risk mitigation**: [What to verify from Q6]

### Next Phase
→ Move to requirements refinement / detailed design
```

---

## Token Budget
- Execution cost: ~500 tokens
- Typical time: 20-40 minutes
- ROI: Prevents architectural mistakes (worth 10x+ costs)

---

## See Also
- **MINIMAL** phase: [minimal.prompt.md](minimal.prompt.md) for Requirements phase
- **SELECTOR**: [selector.prompt.md](selector.prompt.md) for automatic routing
