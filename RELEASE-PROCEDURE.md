# リリース手順書 (v1.0.0)

## ステップ 1: ローカル確認 ✅

```bash
cd prior-art-investigation

# タグ確認
git tag -l v1.0.0

# コミットログ確認
git log --oneline HEAD~6..HEAD
```

**確認事項:**
- ✅ コミット 6 個: phase-split → npm → MCP → Agent Skills → CHANGELOG → RELEASE
- ✅ タグ: v1.0.0 作成済み
- ✅ メッセージ: Production ready ✅

---

## ステップ 2: GitHub にプッシュ

```bash
# main ブランチをプッシュ
git push origin main

# タグをプッシュ
git push origin v1.0.0
```

---

## ステップ 3: GitHub Release 作成

**ブラウザで:**

1. リポジトリ → Releases → Draft a new release
2. **Tag**: v1.0.0 を選択
3. **Title**: `Prior Art Investigation v1.0.0 — Production Ready`
4. **Description**: [RELEASE.md](RELEASE.md) の内容をコピー

**または CLI:**

```bash
# gh CLI が必要
gh release create v1.0.0 \
  --title "Prior Art Investigation v1.0.0" \
  --notes-file RELEASE.md \
  --target main
```

---

## ステップ 4: npm 公開（オプション）

```bash
# npm ログイン
npm login

# パッケージ公開
npm publish
```

**確認:**
```bash
npm info @ma2tani/prior-art-investigation
# → version 1.0.0 が表示されたら成功 ✅
```

---

## ステップ 5: 公開チェックリスト

リリース後の確認:

- [ ] GitHub tag v1.0.0 が見える
- [ ] GitHub Release が表示されている
- [ ] npm package が公開されている（オプション）
- [ ] MCP server が Smithery に登録されているか確認（v1.1+）
- [ ] VS Code Copilot で動作確認
- [ ] Claude Desktop MCP で動作確認

---

## 📊 リリース概要

| 項目 | 内容 |
|------|------|
| **バージョン** | 1.0.0 |
| **リリース日** | 2026-04-14 |
| **コミット数** | 6 個（この短期ロードマップ） |
| **前 commit** | 0f14dba (origin/main) |
| **タグ** | v1.0.0 |
| **ブランチ** | main |

---

## 🎯 リリース内容

### ✅ Phase-Split Prompts
- minimal.prompt.md — 150 tokens
- full.prompt.md — 500 tokens
- selector.prompt.md — 100 tokens

### ✅ VS Code Agent Skills
- `.instructions.md` (EN)
- `.instructions.ja.md` (JA)
- `copilot-instructions.md`

### ✅ MCP Server
- `mcp/server_lite.py` — JSON-RPC
- `mcp/server.py` — Optional FastMCP

### ✅ npm Package
- Tree-shake enabled
- Granular exports
- MCP metadata

### ✅ Documentation
- NAVIGATION.md (EN/JA)
- AGENT-SKILLS-USAGE.md
- CLAUDE-DESKTOP-SETUP.md
- CHANGELOG.md / RELEASE.md

---

## 🚀 公開後のアクション

1. **Announce** — Twitter, GitHub Discussions, Dev.to
2. **Community** — Add links to registry, communities
3. **Monitor** — Issues, feedback collection
4. **v1.1 Roadmap** — Smithery, Docker, CI tracking

---

## 🔗 リンク

- **GitHub Repo**: https://github.com/ma2tani/prior-art-investigation
- **npm Package**: https://www.npmjs.com/package/@ma2tani/prior-art-investigation
- **Release**: https://github.com/ma2tani/prior-art-investigation/releases/tag/v1.0.0
- **Issues**: https://github.com/ma2tani/prior-art-investigation/issues

---

**バージョン**: 1.0.0  
**ステータス**: リリース準備完了 ✅
