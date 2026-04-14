---
agent: agent
description: Prior Art Investigation — SELECTOR (Automatic Phase Router)
version: 2026.1
role: system/router
tokens: ~100
---

# Prior Art Investigation — SELECTOR

> **Purpose**: Automatically route to correct prompt based on development phase  
> **Role**: Internal router - use this first to determine which prompt to run  
> **Time**: 1 minute to determine phase  

---

## What Phase Are You In?

Answer these 3 questions in order:

### **Question 1: Feature Status**

**Is your feature already named in requirements?**

- ✅ **YES** → Has a clear, named requirement → Go to **Q2**
- ❌ **NO** → Requirement vague or unnamed → Use **MINIMAL**
- ❓ **UNSURE** → Partially defined → Use **MINIMAL** first

---

### **Question 2: Depth Available**

**Do you have 30+ minutes for investigation?**

- ✅ **YES, 30+ min available** → Go to **Q3**
- ⚠️ **MAYBE 15-20 min** → Use **MINIMAL** (5-10 min quick check)
- ❌ **NO, rush** → Use **MINIMAL** (5-10 min quick check)

---

### **Question 3: Decision Criticality**

**Is this a major architecture decision or core new subsystem?**

- ✅ **YES, critical** → Use **FULL** (20-40 min deep dive)
- ⚠️ **MAYBE** → Use **FULL** (better safe than sorry for big decisions)
- ❌ **NO, incremental change** → Use **MINIMAL** (quick validation)

---

## Routing Decision Tree

```
START
│
├─ Feature named? 
│  ├─ YES ──────────────┐
│  └─ NO/UNSURE ──> USE MINIMAL ✓
│
└─ Named feature:
   │
   ├─ 30+ min available?
   │  ├─ NO ──────> USE MINIMAL ✓
   │  └─ YES ────────┐
   │
   └─ Critical decision?
      ├─ YES ──> USE FULL ✓✓✓
      └─ NO  ──> USE MINIMAL ✓
```

---

## Output: Which Prompt to Use

### **Use MINIMAL if:**
- [ ] Requirements phase (need concept validation)
- [ ] Time: 5-10 minutes available
- [ ] Scope: Quick validation only (Q1 + Q6)
- [ ] Goal: Confirm problem is real, identify top risks

**File**: `minimum.prompt.md`  
**Phase**: Requirements  
**Token cost**: ~150

---

### **Use FULL if:**
- [ ] Design phase (comprehensive discovery)
- [ ] Time: 20-40 minutes available
- [ ] Scope: Deep investigation (Q1-Q7 + OSS map)
- [ ] Goal: Named concept + design impact analysis

**File**: `full.prompt.md`  
**Phase**: Design  
**Token cost**: ~500

---

### **Use Task Router if:**
- [ ] Task design phase (quick Q7 check)
- [ ] Time: 5 minutes available
- [ ] Scope: Verify tasks reflect prior art findings
- [ ] Goal: Ensure design decisions translate to tasks

**File**: `task-router.prompt.md` (future)  
**Phase**: Tasks  
**Token cost**: ~75

---

## Quick Decision: Copy/Paste Template

**Use this if you just want a quick decision:**

```
Feature name: [Your feature]
Current phase: [ ] Requirements  [ ] Design  [ ] Tasks  [ ] Other
Time available: [ ] <10 min  [ ] 10-30 min  [ ] 30+ min
Criticality: [ ] Incremental  [ ] Important  [ ] Critical

→ RECOMMENDATION: 
```

---

## Flow: Using SELECTOR → Selected Prompt

### Step 1: Run SELECTOR (1 minute)
Answer the routing questions above

### Step 2: Open Recommended Prompt
- MINIMAL → [minimal.prompt.md](minimal.prompt.md)
- FULL → [full.prompt.md](full.prompt.md)

### Step 3: Execute Prompt
Follow the steps in the selected prompt

### Step 4: Document Findings
Record in your requirements/design document

---

## Integration with Kiro SDD

If you're using **Kiro spec-driven development**:

| Phase | Prompt | Kiro Phase | Token Budget |
|-------|--------|-----------|--------------|
| Requirements | MINIMAL | Phase 1 | ~150 |
| Design | FULL | Phase 2-3 | ~500 |
| Tasks | Task Router | Phase 4 | ~75 |
| **Total SDD Cost** | - | 1-4 | **~725 tokens** |

> **Baseline without**: ~2000+ tokens (inefficient research)  
> **With routing**: ~725 tokens (**64% reduction**)

---

## See Also
- **MINIMAL**: [minimal.prompt.md](minimal.prompt.md)
- **FULL**: [full.prompt.md](full.prompt.md)
- **Prior Art Check**: [prior-art-check.prompt.md](prior-art-check.prompt.md) (legacy, full version)
