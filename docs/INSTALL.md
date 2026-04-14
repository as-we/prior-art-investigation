# インストールガイド

`prior-art-investigation` を あなたのプロジェクトに統合する 3 つの方法。

---

## 方法 A: 最も簡単（リポジトリクローン）

**推奨対象**: Kiro SDD を使用中のプロジェクト、またはスタンドアロン利用

```bash
# リポジトリをクローン
git clone https://github.com/ma2tani/prior-art-investigation.git /tmp/prior-art

# 言語別にコピー（Kiro 統合の場合）
## 日本語版
cp -r /tmp/prior-art/docs/ja/kiro/settings/rules/oss-evaluation.md .kiro/settings/rules/
cp /tmp/prior-art/docs/ja/templates/research.md .kiro/settings/templates/specs/

## 英語版
cp -r /tmp/prior-art/docs/en/kiro/settings/rules/oss-evaluation.md .kiro/settings/rules/
cp /tmp/prior-art/docs/en/templates/research.md .kiro/settings/templates/specs/

# スタンドアロン利用の場合（GitHub Copilot agent prompt 利用）
cp /tmp/prior-art/docs/ja/github/prompts/prior-art-check.prompt.md .github/prompts/
# または
cp /tmp/prior-art/docs/en/github/prompts/prior-art-check.prompt.md .github/prompts/
```

**メリット:**
- ✅ クローンして即座に利用可能
- ✅ バージョン管理がシンプル
- ✅ カスタマイズが完全にできる

**デメリット:**
- ❌ 更新時は手動で再コピー必要

---

## 方法 B: npm パッケージ（推奨）

**推奨対象**: npm ワークスペースがあるプロジェクト、複数プロジェクト間で共有したい場合

```bash
# インストール
npm install --save-dev @ma2tani/prior-art-investigation

# Kiro 統合の場合（npm scripts で自動化推奨）
npm run setup:kiro-ja  # 日本語版
npm run setup:kiro-en  # 英語版

# または手動コピー
cp -r node_modules/@ma2tani/prior-art-investigation/docs/ja/kiro/settings/rules/oss-evaluation.md .kiro/settings/rules/
```

**package.json に追加:**
```json
{
  "devDependencies": {
    "@ma2tani/prior-art-investigation": "^1.0.0"
  },
  "scripts": {
    "setup:prior-art-ja": "cp node_modules/@ma2tani/prior-art-investigation/docs/ja/kiro/settings/rules/oss-evaluation.md .kiro/settings/rules/ && cp node_modules/@ma2tani/prior-art-investigation/docs/ja/templates/research.md .kiro/settings/templates/specs/",
    "setup:prior-art-en": "cp node_modules/@ma2tani/prior-art-investigation/docs/en/kiro/settings/rules/oss-evaluation.md .kiro/settings/rules/ && cp node_modules/@ma2tani/prior-art-investigation/docs/en/templates/research.md .kiro/settings/templates/specs/"
  }
}
```

**メリット:**
- ✅ npm で一元管理
- ✅ 複数プロジェクト間での共有が簡単
- ✅ CI/CD で自動統合可能

**デメリット:**
- ❌ Node.js/npm 環境が必須

---

## 方法 C: スタンドアロン（プロンプトコピー）

**推奨対象**: 単一機能の利用、Kiro SDD 不使用

```bash
# 1. prior-art-check.prompt.md をダウンロード
curl -o prior-art-check.prompt.md \
  https://raw.githubusercontent.com/ma2tani/prior-art-investigation/main/docs/ja/github/prompts/prior-art-check.prompt.md

# 2. GitHub Copilot Chat で実行
@prior-art-check-prompt

# または VS Code の prompt 機能で参照
.github/prompts/prior-art-check.prompt.md
```

**メリット:**
- ✅ 最小限のセットアップ
- ✅ IDE 非依存

**デメリット:**
- ❌ 更新の追跡が困難
- ❌ Kiro SDD との統合なし

---

## セットアップ検証

インストール後、以下を確認してください：

```bash
# Kiro 統合の確認
test -f .kiro/settings/rules/oss-evaluation.md && echo "✅ oss-evaluation.md installed"
test -f .kiro/settings/templates/specs/research.md && echo "✅ research.md template installed"

# スタンドアロン利用の確認
test -f .github/prompts/prior-art-check.prompt.md && echo "✅ prompt installed"
```

---

## アップデート

### 方法 A: リポジトリ
```bash
cd /tmp/prior-art
git pull origin main
# 再度コピー
```

### 方法 B: npm
```bash
npm upgrade @ma2tani/prior-art-investigation
npm run setup:prior-art-ja
```

### 方法 C: スタンドアロン
```bash
# ファイルを再ダウンロード
```

---

## トラブルシューティング

**Q: `.kiro/settings/` ディレクトリが存在しない**

A: Kiro SDD を初期化してください
```bash
mkdir -p .kiro/settings/{rules,templates/specs}
git add .kiro/settings/
git commit -m "chore: init .kiro directory"
```

**Q: `npm run setup:prior-art-ja` でファイルが見つからない**

A: `node_modules/` が最新か確認
```bash
npm install
npm run setup:prior-art-ja
```

**Q: 複数言語を同時に使いたい**

A: 両方コピーしてください（ファイル競合はありません）
```bash
npm run setup:prior-art-ja && npm run setup:prior-art-en
# または手動で両方コピー
```

---

## 次のステップ

セットアップ完了後：

1. [日本語ガイド](../docs/ja/setup-checklist.md)
2. [English guide](../docs/en/setup-checklist.md)
3. チームで `research.md` テンプレートを使用開始

---

質問やフィードバック → GitHub Issues: https://github.com/ma2tani/prior-art-investigation/issues
