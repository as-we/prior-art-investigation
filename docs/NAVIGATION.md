# Site Navigation & Sitemap

## Quick Navigation

```
🏠 Home (README.md)
 ├─ 🇬🇧 English (docs/en/)
 │  ├─ README.md  ← Start here
 │  ├─ setup-checklist.md
 │  ├─ CONTRIBUTING.md
 │  ├─ templates/
 │  │  └─ research.md
 │  ├─ kiro/
 │  │  └─ settings/rules/oss-evaluation.md
 │  └─ github/
 │     └─ prompts/prior-art-check.prompt.md
 │
 ├─ 🇯🇵 日本語 (docs/ja/)
 │  ├─ README.md  ← 最初にここを読んでください
 │  ├─ setup-checklist.md
 │  ├─ CONTRIBUTING.md
 │  ├─ templates/
 │  │  └─ research.md
 │  ├─ kiro/
 │  │  └─ settings/rules/oss-evaluation.md
 │  └─ github/
 │     └─ prompts/prior-art-check.prompt.md
 │
 ├─ 📖 Documentation
 │  ├─ INSTALL.md  ← インストール方法 (3 options)
 │  ├─ API.md  ← プログラマティック利用
 │  ├─ TROUBLESHOOTING.md  ← よくある質問
 │  ├─ NAVIGATION.md  ← このファイル
 │  └─ AGENTS.md  ← (親プロジェクト)
 │
 ├─ 🔧 Setup & Community
 │  ├─ scripts/setup.sh  ← 自動セットアップ
 │  ├─ Makefile  ← タスク実行
 │  ├─ package.json  ← npm 配布
 │  ├─ .github/ISSUE_TEMPLATE/  ← Issue テンプレート
 │  │  ├─ bug.md
 │  │  ├─ feature_request.md
 │  │  └─ domain_expansion.md
 │  ├─ LICENSE  ← MIT License
 │  └─ CONTRIBUTING.md
 │
 └─ 🚀 Getting Started
    ├─ (1) Language selection
    ├─ (2) Install: INSTALL.md
    ├─ (3) Setup: make setup (or bash scripts/setup.sh)
    ├─ (4) Read: docs/{en|ja}/README.md
    └─ (5) Follow: Kiro SDD workflow in parent project
```

---

## Reading Paths by Use Case

### Use Case 1: "I want to understand Prior Art Investigation"

**Time**: ~20 minutes  
**Path**:
1. ✅ Root [README.md](README.md) — Overview (2 min)
2. ✅ Select language → `docs/{lang}/README.md` (10 min)
3. ✅ [Skim] `docs/{lang}/kiro/settings/rules/oss-evaluation.md` (8 min)

**Outcome**: Understand Phase A → Phase B workflow

---

### Use Case 2: "I want to set up in my project NOW"

**Time**: ~5 minutes  
**Path**:
1. ✅ [INSTALL.md](docs/INSTALL.md) — Choose method (2 min)
   - Option A: `git clone` (easiest)
   - Option B: `npm install` (best for multiple projects)
   - Option C: Standalone (minimal)
2. ✅ Run: `make setup` or `bash scripts/setup.sh` (2 min)
3. ✅ Verify: `ls .kiro/settings/rules/oss-evaluation.md` (1 min)

**Outcome**: Ready to use in Kiro SDD project

---

### Use Case 3: "I'm stuck / something isn't working"

**Time**: ~10 minutes  
**Path**:
1. ✅ [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) — Search "Q: ..." for your issue
2. ✅ Try solution
3. ✅ If still broken → GitHub Issues (with error details)

**Outcome**: Resolved or escalated to team

---

### Use Case 4: "I want to integrate this into my IDE / tool"

**Time**: ~30 minutes  
**Path**:
1. ✅ [API.md](docs/API.md) — Integration patterns (15 min)
2. ✅ Choose pattern: Prompt vs Kiro Rule vs Programmatic (5 min)
3. ✅ Read example code / implementation (10 min)

**Outcome**: Code integration path clear

---

### Use Case 5: "I want to contribute / extend this"

**Time**: ~40 minutes  
**Path**:
1. ✅ [CONTRIBUTING.md](CONTRIBUTING.md) — Contribution guidelines (5 min)
2. ✅ [CONTRIBUTING.md](docs/{lang}/CONTRIBUTING.md) — Language-specific notes (5 min)
3. ✅ Read [oss-evaluation.md](docs/{lang}/kiro/settings/rules/oss-evaluation.md) — Understand structure (15 min)
4. ✅ Fork/Branch → Edit → Test → PR (10 min)

**Outcome**: Ready to contribute

---

## File Reference by Role

### For Project Managers / Decision-makers

| File | Purpose | Read Time |
|------|---------|-----------|
| [README.md](README.md) | Project overview | 2 min |
| [docs/{lang}/README.md](docs/en/README.md) | Business value | 5 min |
| [oss-evaluation.md (Phase B)](docs/en/kiro/settings/rules/oss-evaluation.md#phase-b) | License/risk assessment | 10 min |

---

### For Engineers / Practitioners

| File | Purpose | Read Time |
|------|---------|-----------|
| [INSTALL.md](docs/INSTALL.md) | Setup instructions | 5 min |
| [research.md template](docs/en/templates/research.md) | Decision log | 10 min |
| [prior-art-check.prompt.md](docs/en/github/prompts/prior-art-check.prompt.md) | Execution steps | 15 min |
| [oss-evaluation.md](docs/en/kiro/settings/rules/oss-evaluation.md) | Full reference | 30 min |

---

### For AI Agents / Tool Developers

| File | Purpose | Format |
|------|---------|--------|
| [prior-art-check.prompt.md](docs/en/github/prompts/prior-art-check.prompt.md) | System prompt | YAML + Markdown |
| [oss-evaluation.md](docs/en/kiro/settings/rules/oss-evaluation.md) | Rule engine | Markdown tables + sections |
| [API.md](docs/API.md) | Integration guide | Tech reference |

---

### For Community Contributors

| File | Purpose | First Step |
|------|---------|-----------|
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines | Read full |
| [.github/ISSUE_TEMPLATE](../.github/ISSUE_TEMPLATE) | Issue templates | Use when filing |
| [GitHub Issues](https://github.com/ma2tani/prior-art-investigation/issues) | Discussions | Browse + comment |

---

## Document Relationships

```
📋 ROOT NAVIGATION
        ↓
[README.md]  ← Language selector  
   ↙ ↘
EN   JA
 ↓    ↓
[docs/en/README.md]    [docs/ja/README.md]
   ↙             ↘
   │              │
[setup-checklist.md]   [INSTALL.md] ← Cross-linked
   │              │
   └──→ [INSTALL.md] ← Technology guide
        │
        ├─→ [scripts/setup.sh] ← Automation
        ├─→ [Makefile] ← Task runner
        └─→ [package.json] ← Dependencies
        
[oss-evaluation.md] ← Core rules
   ├─→ [prior-art-check.prompt.md] ← AI execution
   ├─→ [research.md] ← Decision log
   └─→ [FAQ in TROUBLESHOOTING.md] ← Support

[API.md] ← Programmatic access
   └─→ [oss-evaluation.md] ← Referenced

[CONTRIBUTING.md] ← Community setup
   └─→ [ISSUE_TEMPLATE/*.md] ← GitHub UI
```

---

## Localization Map

Both English and Japanese versions have identical structures:

```
docs/
├── en/
│  ├── README.md
│  ├── setup-checklist.md
│  ├── CONTRIBUTING.md
│  ├── templates/research.md
│  ├── kiro/settings/rules/oss-evaluation.md
│  └── github/prompts/prior-art-check.prompt.md
│
└── ja/
   ├── README.md  (Japanese)
   ├── setup-checklist.md  (Japanese)
   ├── CONTRIBUTING.md  (Japanese)
   ├── templates/research.md  (Japanese)
   ├── kiro/settings/rules/oss-evaluation.md  (Japanese)
   └── github/prompts/prior-art-check.prompt.md  (Japanese)
```

**Landing pages** (at root):
- README.md (language selector)
- INSTALL.md (language-neutral)
- TROUBLESHOOTING.md (language-neutral)
- API.md (language-neutral)
- NAVIGATION.md (this file)

---

## Update Frequency

| Document | Frequency | Owner |
|----------|-----------|-------|
| README.md | Minor fixes only | Team |
| oss-evaluation.md | When rules change | Team review |
| research.md (template) | Never (user copies) | N/A |
| TROUBLESHOOTING.md | As issues arise | Community |
| API.md | When APIs change | Team |
| INSTALL.md | When setup changes | Team |

---

## Search Tips

**On GitHub**:
```
# Find all rules references
site:github.com/ma2tani/prior-art-investigation oss-evaluation

# Find all prompts
site:github.com/ma2tani/prior-art-investigation prompt
```

**Locally**:
```bash
# Find all markdown files
find docs -name "*.md" -type f

# Search for term (e.g., "Phase B")
grep -r "Phase B" docs/

# Search with line numbers
grep -n "OSS health" docs/*/kiro/settings/rules/oss-evaluation.md
```

---

## Glossary Navigation

- **Phase A**: Concept identification (see `oss-evaluation.md` → Phase A)
- **Phase B**: OSS evaluation (see `oss-evaluation.md` → Phase B)
- **Q1-Q7**: Design inquiry questions (see `prior-art-check.prompt.md` → Framework)
- **License Tier**: Classification table (see `oss-evaluation.md` → Phase B-2)
- **research.md**: Decision log template (see `docs/{lang}/templates/research.md`)
- **Kiro SDD**: Spec-Driven Development framework (see parent project [AGENTS.md](../AGENTS.md))

