---
agent: agent
description: Prior Art Investigation — MINIMAL (Requirements Phase) — Identify concept name & risks
version: 2026.1
phase: Requirements
tokens: ~150
---

# Prior Art Investigation — MINIMAL (Requirements Phase)

> **Purpose**: Quick prior art check for requirements phase  
> **Time**: 5-10 minutes  
> **Output**: Concept name confirmed + major risks identified  
> **Audience**: Product managers, requirements authors

---

## When to Run

| Phase | Trigger | Questions |
|-------|---------|-----------|
| **Requirements** | Problem needs naming | Q1 + Q6 only |
| **Quick gate** | Before moving to design | Skip full Q2-Q5 |

---

## Step 1: Load Context

Confirm you have:
1. **Problem statement** (1-2 sentences)
2. **Technology layers**: ML/AI・Backend・Frontend・Data・Infrastructure・Security
3. **Any existing concept names** mentioned in requirements (if any)

---

## Step 2: Answer Two Critical Questions

### **Q1: First Principles** (3-5 min)

*"Is the problem framework correct? Are you solving the right problem?"*

**What to do:**
- State your problem in simplest terms (remove all jargon)
- Ask: "Is this problem real?" 
- Ask: "Is this the actual problem or a symptom?"
- Record your answer in 2-3 sentences

**Example response:**
> Problem: "We need feature X"  
> Reframed: "Users struggle to compare Y because Z lacks visibility"  
> Real problem: "Visibility gap in Y, not missing feature X"

---

### **Q6: Inversion** (3-5 min)

*"If this failed in the worst way possible, what would be the cause? What should you verify?"*

**What to do:**
- Imagine the feature fails spectacularly in 6 months
- Ask: "What causes this failure?"
- Ask: "What assumptions might be wrong?"
- Record 2-3 critical risks

**Example risks:**
> • Assumption: "Users will adopt behavior X"  
>   Risk: Performance overhead breaks adoption  
> • Assumption: "Current architecture supports Y"  
>   Risk: Architectural constraints prevent implementation

---

## Step 3: Record Output

Create a **concept validation record** with:

```markdown
## Concept Validation — [Date]

### Q1: First Principles
- **Original problem**: [Your problem as stated]
- **Reframed problem**: [Root cause identified]
- **Validation**: [Is this the real problem?]

### Q6: Inversion  
- **Critical Risk 1**: [Assumption + Risk]
- **Critical Risk 2**: [Assumption + Risk]
- **Verification needed**: [What to test]

### Decision
- [ ] Problem confirmed — proceed to Design  
- [ ] Rethink required — loop back to Q1
```

---

## Next Steps

- ✅ Requirements clear? → Move to **Design** phase
- ❌ Need deeper research? → Run **FULL** prompt (all 7 questions)
- 🔄 Rethinking needed? → Loop back to Q1, revise problem

---

## Token Budget
- Execution cost: ~150 tokens
- Savings vs FULL: 70% reduction
