# Troubleshooting Guide

## Installation Issues

### Q: npm install @ma2tani/prior-art-investigation fails

**Error**: `404 Not Found`

**Cause**: Package not yet published to registry

**Solution**:
```bash
# Use git clone instead
git clone https://github.com/ma2tani/prior-art-investigation.git
cd prior-art-investigation
bash scripts/setup.sh
```

---

### Q: Permission denied when running scripts/setup.sh

**Error**: `bash scripts/setup.sh: Permission denied`

**Cause**: Script not executable

**Solution**:
```bash
chmod +x scripts/setup.sh
bash scripts/setup.sh
```

Or use `make`:
```bash
make setup
```

---

### Q: Kiro rules not loaded

**Error**: `/kiro-spec-requirements` doesn't include OSS Evaluation rules

**Cause**: `.kiro/settings/rules/` path not set up correctly

**Solution**:

**For manual setup:**
```bash
# Verify structure
ls -la .kiro/settings/rules/oss-evaluation.md

# If missing, reinstall
bash scripts/setup.sh
```

**For npm:**
```bash
npm run setup:kiro-ja  # or setup:kiro-en
```

---

## Configuration Issues

### Q: How to switch languages mid-project?

**Use case**: Project started in English, now adding Japanese team

**Solution**:
```bash
# Copy Japanese rules
cp docs/ja/kiro/settings/rules/oss-evaluation.md \
   .kiro/settings/rules/oss-evaluation.ja.md

# Load in Kiro as separate rule reference
# Edit your Kiro manifest to include both
```

---

### Q: Kiro already has a custom oss-evaluation.md

**Conflict**: Package rules conflict with existing `.kiro/settings/rules/oss-evaluation.md`

**Solution 1 — Merge**:
```bash
# Backup your current
cp .kiro/settings/rules/oss-evaluation.md \
   .kiro/settings/rules/oss-evaluation.custom.md

# Install package version (custom merges with override)
bash scripts/setup.sh --merge

# Restore customizations by comparing both files
# git diff oss-evaluation.custom.md oss-evaluation.md
```

**Solution 2 — Keep custom**:
```bash
# Don't run setup.sh; manually reference package prompts
# In your Kiro steering: reference
#file:path/to/node_modules/@ma2tani/prior-art-investigation/docs/en/github/prompts/prior-art-check.prompt.md
```

---

## Usage Issues

### Q: How to pass Phase A results to Phase B?

**Use case**: Completed concept naming (Phase A-2), now need structured OSS search

**Solution**:
1. Use `research.md` template to record Phase A results
2. Copy "Named Concept" table into Phase B OSS search
3. Run OSS evaluation with concept name as anchor

```markdown
## Phase A Results
| Name | Year | Maturity | Design Implication |
|------|------|----------|-------------------|
| Concept-X | 2022 | maturity | ... |

## Phase B Search
Use "Concept-X" as search term in:
- GitHub (language tags)
- arXiv (keyword search)
- Papers with Code (benchmark search)
```

---

### Q: Q7 (Project overhead) scoring seems arbitrary

**Problem**: How to objectively measure "project overhead"?

**Q7 Rubric**:
- **Green (Low)**: <2 hrs to integrate, <5 dependencies, documented examples
- **Yellow (Medium)**: 2-8 hrs, 5-15 dependencies, needs customization
- **Red (High)**: >8 hrs, >15 dependencies, minimal docs, requires expert

**Tool**: Use matrix in `oss-evaluation.md` → Build vs Use section

---

### Q: Should I include "research.md" in my repo?

**Recommendation**: **YES**

**Why**:
- Tracks decision rationale (useful for context switching)
- Aids audits / compliance (shows evaluation rigor)
- Helps team learn from past decisions

**Location**:
```
.kiro/decisions/
├── prior-art-[feature-1].md
├── prior-art-[feature-2].md
└── prior-art-[feature-3].md
```

---

## Community Issues

### Q: I have suggestions for more questions in Phase A

**How to contribute**:

1. **Check existing** (GitHub Issues) for similar suggestions
2. **Open issue** with label `enhancement:questions`
3. **Propose concretely**: "Add Q8: {question text}" + rationale
4. **Wait for feedback** (maintainers will review)

**Issue template**: `.github/ISSUE_TEMPLATE/domain_expansion.md`

---

### Q: My domain isn't covered (ML / Frontend / etc.)

**How to extend**:

1. **Reference**: See Phase A-2 (Domain-specific angles) in `oss-evaluation.md`
2. **Create PR**: Add new row to table
3. **Include**: 
   - Domain name
   - 2-3 domain-specific Q examples
   - 3-5 keyword resources (arXiv, GitHub topics, etc.)

**PR template**: `.github/ISSUE_TEMPLATE/feature_request.md`

---

## Document Issues

### Q: Page renders incorrectly in GitHub

**Problem**: Some markdown not displaying (tables misaligned, code blocks broken)

**Likely cause**: Platform-specific markdown dialect

**Solution**:
1. Try rendering locally: `pandoc file.md -t html > file.html`
2. Open in browser to validate
3. Report issue with screenshot: https://github.com/ma2tani/prior-art-investigation/issues

---

### Q: Language switching not working in README

**Problem**: README language selector doesn't navigate correctly

**Expected**: Click [日本語](#ja) in README → navigates to docs/ja/README.md

**Fix**: GitHub may require full URL:
```markdown
# 言語選択 / Language Selection

- [English](docs/en/README.md)
- [日本語](docs/ja/README.md)
```

---

## Performance Issues

### Q: Rules file loading is slow (M1/Apple Silicon)

**Symptom**: 500-2000ms delay when loading oss-evaluation.md

**Cause**: File I/O overhead (common on cold start)

**Solution**:

**For individual use**:
```bash
# Cache locally (one-time)
cp docs/ja/kiro/settings/rules/oss-evaluation.md \
   .kiro/settings/rules/oss-evaluation.md
```

**For teams** (using npm):
```bash
# Add build step to prebuild rules
npm run prebuild:rules  # Included in package scripts
```

---

## Advanced Troubleshooting

### Q: How to debug Kiro rule loading?

**Enable verbose logging**:
```bash
export KIRO_DEBUG=1
/kiro-spec-requirements --verbose
```

**Check loaded resources**:
```bash
# Lists all active rules in .kiro/
ls -la .kiro/settings/rules/
grep -r "oss-evaluation" .kiro/
```

---

### Q: Can I fork and maintain my own version?

**Yes**:
```bash
# Fork on GitHub
git clone https://github.com/YOUR_ACCOUNT/prior-art-investigation.git
cd prior-art-investigation

# Customize docs/ja/kiro/settings/rules/oss-evaluation.md
# Add company-specific domains, questions

# To stay in sync with upstream:
git remote add upstream https://github.com/ma2tani/prior-art-investigation.git
git fetch upstream
git merge upstream/main
```

---

## Still Stuck?

1. **Check existing issues**: https://github.com/ma2tani/prior-art-investigation/issues
2. **Search this guide** for "Q: ..." matching your problem
3. **Open new issue** with:
   - What you tried
   - Expected behavior
   - Actual behavior
   - OS + Node version (if applicable)
4. **Provide context**: Minimal reproducible example

---

## Glossary

| Term | Definition |
|------|-----------|
| **Phase A** | Concept identification & naming |
| **Phase B** | OSS evaluation & licensing |
| **Q1-Q7** | Design Inquiry Questions |
| **Kiro SDD** | Spec-Driven Development framework |
| **License Tier** | Classification system (Tier 1-4 by copyleft restriction) |
| **research.md** | Decision log template |

