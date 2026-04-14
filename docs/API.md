# Prompt Reference API

このドキュメントは、`prior-art-investigation` のプロンプトを プログラマティックに参照・利用するための API 仕様です。

---

## Overview

```
.
├── docs/en/github/prompts/prior-art-check.prompt.md  ← Main prompt (English)
├── docs/ja/github/prompts/prior-art-check.prompt.md  ← Main prompt (Japanese)
├── docs/en/kiro/settings/rules/oss-evaluation.md     ← Kiro rule (English)
└── docs/ja/kiro/settings/rules/oss-evaluation.md     ← Kiro rule (Japanese)
```

---

## Usage Patterns

### Pattern 1: Standalone Prompt

**Location**: `docs/{lang}/github/prompts/prior-art-check.prompt.md`

**Use case**: Any IDE / Chat interface

```bash
# Manual reference in GitHub Copilot Chat
#file:docs/ja/github/prompts/prior-art-check.prompt.md

# Or copy to local
cp docs/ja/github/prompts/prior-art-check.prompt.md \
  ~/.config/copilot/prompts/
```

**Format**: (YAML front matter + Markdown)
```yaml
---
mode: agent
description: ...
---

# Prompt content
...
```

---

### Pattern 2: Kiro Integration

**Location**: `docs/{lang}/kiro/settings/rules/oss-evaluation.md`

**Use case**: Kiro SDD projects

```bash
# Automatic reference via .kiro/
# Loaded by: /kiro-spec-requirements, /kiro-spec-design, /kiro-spec-tasks
```

**Kiro auto-load order** (highest priority first):
1. `.kiro/settings/rules/oss-evaluation.md` (project custom)
2. `docs/{language}/kiro/settings/rules/oss-evaluation.md` (this package)

---

### Pattern 3: Programmatic Access

**For npm packages / scripts**:

```javascript
// JavaScript
import fs from 'fs';

const priorArtPath = require.resolve('@ma2tani/prior-art-investigation');
const ruleENPath = `${priorArtPath}/docs/en/kiro/settings/rules/oss-evaluation.md`;
const ruleJAPath = `${priorArtPath}/docs/ja/kiro/settings/rules/oss-evaluation.md`;

const rule = fs.readFileSync(ruleJAPath, 'utf-8');
console.log(rule);
```

```python
# Python
import importlib.resources as resources

try:
    # Python 3.9+
    files = resources.files('prior_art_investigation')
    rule = files.joinpath('docs/ja/kiro/settings/rules/oss-evaluation.md').read_text()
except:
    # Fallback
    import pkg_resources
    rule = pkg_resources.resource_string('prior_art_investigation', 
                                         'docs/ja/kiro/settings/rules/oss-evaluation.md')
```

```bash
# Shell
RULE_PATH=$(npm root)/@ma2tani/prior-art-investigation
cat "$RULE_PATH/docs/ja/kiro/settings/rules/oss-evaluation.md"
```

---

## Content Structure

### prior-art-check.prompt.md

**Sections** (always in this order):
1. Front matter (YAML)
2. Purpose statement
3. When to run (table)
4. Step-by-step flow (Steps 1-5)
5. Checklist

**Q&A format**: 7 Design Inquiry Questions (Q1-Q7)

**Consumption**: Parse Markdown → Extract Q1-Q7 → Apply to feature

---

### oss-evaluation.md

**Sections** (always in this order):
1. Scope / Purpose
2. Phase A: Concept Identification
   - A-0: 7 Questions
   - A-1: Naming
   - A-2: Domain-specific angles
   - A-3: Research resources
   - A-4: Recording
3. Phase B: OSS Evaluation
   - B-1: Search order
   - B-2: License Tier table
   - B-3: Health check
   - B-4: Build vs Use matrix

**Consumption**: Parse tables → Populate research.md

---

## Language Fallback

```
User language = "ja"
├─ ja/ exists?        → Load from docs/ja/
├─ ja/ not found?     → Fall back to docs/en/
└─ Both missing?      → Error
```

---

## Versioning

Package version is semantic:  
- **Major** (X.0.0): Breaking changes to prompt structure / Q numbers
- **Minor** (0.X.0): New sections / questions added (backward compatible)
- **Patch** (0.0.X): Wording fixes / typo corrections

**Recommendation**: Pin to minor version:
```json
{
  "@ma2tani/prior-art-investigation": "^1.0.0"
}
```

---

## Integration Checklist

When integrating `prior-art-investigation`:

- [ ] **Tool mapping**: Map Q1-Q7 to your tool's structure
- [ ] **Language support**: Detect project language → load correct docs/
- [ ] **Caching**: Cache parsed rules (avoid repeated I/O)
- [ ] **Version handling**: Update when package version changes
- [ ] **Fallback**: Provide graceful degradation if file not found

---

## Example: IDE Integration

```typescript
// Example: Custom IDE integration

class PriorArtClient {
  constructor(language: 'en' | 'ja' = 'ja', packageRoot?: string) {
    this.language = language;
    this.packageRoot = packageRoot || require.resolve('@ma2tani/prior-art-investigation');
  }

  loadPrompt(): string {
    const path = `${this.packageRoot}/docs/${this.language}/github/prompts/prior-art-check.prompt.md`;
    return fs.readFileSync(path, 'utf-8');
  }

  loadRule(): string {
    const path = `${this.packageRoot}/docs/${this.language}/kiro/settings/rules/oss-evaluation.md`;
    return fs.readFileSync(path, 'utf-8');
  }

  getQuestions(): string[] {
    const rule = this.loadRule();
    // Parse Q1-Q7 from markdown
    return extractQuestions(rule);
  }
}
```

---

## Feedback

- Report API issues: https://github.com/ma2tani/prior-art-investigation/issues
- Suggest extensions: PR welcome

