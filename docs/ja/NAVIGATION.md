# ナビゲーション＆クイックスタート

**先行技術調査フレームワーク**へようこそ — コード作成前に概念名、既存パターン、OSS を特定するためのフレームワークです。

---

## 🎯 クイックスタート（2分）

### ステップ 1: エントリーポイントを選択

- **VS Code を使用中？** → [Agent Skills セットアップ](./AGENT-SKILLS-SETUP.md)
- **Claude Desktop を使用中？** → [MCP セットアップ](./MCP-SETUP.md)
- **学習中？** → [SELECTOR で開始](./github/prompts/selector.prompt.md)
- **npm を使用中？** → [INSTALL.md](./INSTALL.md)

### ステップ 2: パスを選択

```
機能を開始する前？
├─ 5-10 分利用可能 → MINIMAL プロンプト実行
├─ 20-40 分利用可能 → FULL プロンプト実行
└─ 不明不明？ → SELECTOR を実行する
```

---

## 📚 完全なナビゲーション

###  新規ユーザー向け

| リソース | 目的 | 時間 | 最適用途 |
|---------|------|------|---------|
| [SELECTOR](./github/prompts/selector.prompt.md) | 最適プロンプトへの自動ルーティング | 1 分 | 開始 |
| [MINIMAL](./github/prompts/minimal.prompt.md) | クイック検証（Q1+Q6） | 5-10 分 | 要件定義フェーズ |
| [FULL](./github/prompts/full.prompt.md) | 深層調査（Q1-Q7） | 20-40 分 | 設計フェーズ |
| [研究テンプレート](./templates/research.md) | 調査結果を記録 | - | 結果記録 |

### ツールセットアップ向け

| プラットフォーム | ガイド | セットアップ時間 | 継続作業 |
|------------|--------|------------|---------|
| VS Code Copilot | [Agent Skills セットアップ](./AGENT-SKILLS-SETUP.md) | 2 分 | コピー/貼り付け |
| Claude Desktop | [MCP セットアップ](./MCP-SETUP.md) | 5 分 | サーバー統合（v1.1+） |
| npm パッケージ | [INSTALL.md](./INSTALL.md) | 3 分 | プロンプトをインポート |
| GitHub raw | [Raw URL](https://github.com/ma2tani/prior-art-investigation) | 1 分 | curl/wget |

### 詳細リファレンス向け

| ドキュメント | 目的 | 対象 |
|-----------|------|------|
| [OSS 評価フレームワーク](./kiro/settings/rules/oss-evaluation.md) | フェーズ A/B — 概念命名と OSS 選択ルール | アーキテクト |
| [研究テンプレート](./templates/research.md) | 構造化された記録フォーマット | 全員 |
| [README.md](./README.md) | プロジェクト概要 | 意思決定者 |

### 統合向け

| 統合 | ステータス | リンク |
|------|----------|--------|
| **Kiro SDD** | ✅ フル対応 | [MCP-SETUP.md](./MCP-SETUP.md#kiro-sdd-integration) 参照 |
| **Agent Skills** | ✅ 対応 | [Agent Skills セットアップ](./AGENT-SKILLS-SETUP.md) |
| **MCP サーバー** | ⏳ v1.1 予定 | [MCP-SETUP.md](./MCP-SETUP.md#option-3-mcp-server-wrapper-future--v110) |
| **Docker** | ⏳ v1.1 予定 | [MCP-SETUP.md#roadmap](./MCP-SETUP.md#roadmap) |

---

## 🔍 ユースケース

### ケース 1: 「機能を作るべき？」

1. 読む: [MINIMAL プロンプト](./github/prompts/minimal.prompt.md)
2. 答える: Q1（本当の問題？）+ Q6（何が失敗する？）
3. 記録: [研究テンプレート](./templates/research.md)
4. 時間: 5-10 分 | コスト: ~150 トークン

---

### ケース 2: 「新しいサブシステムを設計したい」

1. 開始: [SELECTOR](./github/prompts/selector.prompt.md) → FULL へルーティング
2. 実行: [FULL プロンプト](./github/prompts/full.prompt.md)（7 つの質問すべて）
3. マップ: OSS エコシステムオプション
4. 記録: [研究テンプレート](./templates/research.md)
5. 時間: 20-40 分 | コスト: ~500 トークン

---

### ケース 3: 「Kiro SDD を使用している」

1. フェーズ 1（要件定義）: [MINIMAL](./github/prompts/minimal.prompt.md)
2. フェーズ 2-3（設計）: [FULL](./github/prompts/full.prompt.md)
3. フェーズ 4（タスク）: Task Router（coming v1.2）
4. 保存: `.kiro/specs/FEATURE/docs/research.md`
5. 合計: ~725 トークン | 時間: 45-60 分

---

## 📋 決定ツリー：どのプロンプト？

```
開始
│
├─ ≥20 分利用可能？
│  ├─ いいえ  → MINIMAL 使用（5-10 分）
│  └─ はい ──────────────┐
│
└─ 重要なアーキテクチャ決定？
   ├─ はい → FULL 使用（20-40 分）
   └─ いいえ  → MINIMAL 使用
```

**不明？** [SELECTOR](./github/prompts/selector.prompt.md) を実行してください — ガイドします！

---

## 🔗 外部リンク

### 先行技術について詳しく
- [Wikipedia: Prior Art](https://ja.wikipedia.org/wiki/先行技術)
- [特許について | 先行技術](https://www.jpo.go.jp/)

### GitHub Copilot / VS Code
- [VS Code Copilot Chat](https://code.visualstudio.com/docs/copilot/chat/copilot-chat)
- [Copilot Agents](https://code.visualstudio.com/docs/copilot/agents/overview)

### Model Context Protocol
- [MCP ドキュメント](https://modelcontextprotocol.io/)
- [MCP レジストリ](https://registry.modelcontextprotocol.io/)

### Kiro 仕様駆動開発
- プロジェクトの `.kiro/` フォルダ参照

---

## 📊 機能マトリックス

| 機能 | v1.0.0 | v1.1.0 | v1.2.0 |
|------|--------|--------|--------|
| **SELECTOR プロンプト** | ✅ | ✅ | ✅ |
| **MINIMAL/FULL プロンプト** | ✅ | ✅ | ✅ |
| **研究テンプレート** | ✅ | ✅ | ✅ |
| **npm 配布** | ✅ | ✅ | ✅ |
| **双言語（EN/JA）** | ✅ | ✅ | ✅ |
| **MCP サーバー ラッパー** | - | ⏳ | ✅ |
| **Agent Skills テンプレート** | - | - | ⏳ |
| **Docker コンテナ** | - | ⏳ | ✅ |
| **Smithery レジストリ** | - | - | ✅ |

---

## ❓ よくある質問

### 初心者は何から始めるべき？

→ [SELECTOR](./github/prompts/selector.prompt.md) を読んでください。適切なプロンプトへルーティングします。

### コーディングなしで使用できる？

→ はい！すべてのプロンプトは Markdown で、任意のチャットインターフェース（Claude Desktop、VS Code、ChatGPT など）で動作します。

### コストは？

→ トークン使用量はプロンプトによって異なります：
- **MINIMAL**: ~150 トークン（5-10 分）
- **FULL**: ~500 トークン（20-40 分）
- **Kiro 合計**: ~725 トークン（45-60 分）

### 私のエディターで対応している？

→ [ツールセットアップテーブル](#ツールセットアップ向け) を確認してください。 リスト にない場合は、プロンプトを手動でコピー/貼り付けできます。

### 貢献するには？

→ [CONTRIBUTING.md](./CONTRIBUTING.md) ガイドラインを参照してください。

---

## 🎓 学習パス

**初心者（30 分）**
1. 読む: [README.md](./README.md)
2. 実行: [SELECTOR](./github/prompts/selector.prompt.md)
3. 実行: [MINIMAL](./github/prompts/minimal.prompt.md)

**中級者（1 時間）**
1. レビュー: [MINIMAL](./github/prompts/minimal.prompt.md) 結果
2. 実行: [FULL](./github/prompts/full.prompt.md)
3. 学習: [OSS 評価フレームワーク](./kiro/settings/rules/oss-evaluation.md)

**上級者（2+ 時間）**
1. プロジェクトと統合（Agent Skills / MCP）
2. チーム エージェント作成（[Agent Skills セットアップ](./AGENT-SKILLS-SETUP.md) 参照）
3. Kiro SDD へ接続（[MCP-SETUP.md](./MCP-SETUP.md#kiro-sdd-integration) 参照）

---

## 🆘 ヘルプが必要？

- **質問？** → [GitHub Discussions](https://github.com/ma2tani/prior-art-investigation/discussions)
- **バグ発見？** → [GitHub Issues](https://github.com/ma2tani/prior-art-investigation/issues)
- **簡単な質問？** → [README.md FAQ](./README.md#faq)

---

**最後のアップデート**: 2026年4月  
**バージョン**: 1.0.0  
**ライセンス**: MIT
