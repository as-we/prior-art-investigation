# CHANGELOG

All notable changes are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.0] — 2026-04-14

### Added

- **MINIMAL prompt** (Q1+Q6) — Requirements phase, ~150 tokens, 5-10 min
- **FULL prompt** (Q1-Q7) — Design phase, ~500 tokens, 20-40 min
- **SELECTOR prompt** — Auto-routes to MINIMAL or FULL, ~100 tokens, 1-2 min
- **VS Code Agent Skills** — `.instructions.md` (EN) + `.instructions.ja.md` (JA)
- **MCP Server** — `mcp/server_lite.py` with embedded prompts, no external dependencies
- **Kiro SDD hooks** — `.kiro/hooks/` for requirements, design, post-PR phases
- **Kiro personalities** — 5 investigation profiles (researcher, startup-hunter, tech-auditor, patent-search, team-internal)
- **Bilingual docs** — `docs/en/` and `docs/ja/` (README, AGENT-SKILLS-SETUP, MCP-SETUP)
