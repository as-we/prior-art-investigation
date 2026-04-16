# 先行技術調査フレームワーク

コードを書く前に、機能の概念名・既存パターン・OSS を素早く特定する。

**[English](../en/README.md)**

---

## 何ができるか

SDD（仕様駆動開発）を使えば、やりたいことベースで要件定義・設計・実装を進められます。

たとえば：
> 「LLM で推論理由を出力させて、その結果を使って小さい ML モデルを学習させたい」

この一文だけで開発は進みます。**ただし、このやり方には盲点があります。**

「知識蒸留（Knowledge Distillation）」という確立した研究分野がすでに存在し、10年以上の論文・OSS・失敗事例の蓄積があります。それを知らないまま実装を進めると、既存の成果を自分で再発明することになります。「自分で考えた」と思い込んだまま。

**このフレームワークは、設計を始める前にその盲点を埋めます。**

```
@prior-art-investigation full LLM の出力を使って小さい ML モデルを学習させたい
```

返ってくる情報：

- **技術名** — 「知識蒸留（Knowledge Distillation）」（2015年 Hinton らが提案した既存研究）
- **研究発展の流れ** — モデル圧縮 → ニューラルネット蒸留 → 2023年以降は LLM 蒸留が急増
- **既存 OSS** — DistilBERT、LLaMA-Factory、Hugging Face transformers など、評価マトリクス付き
- **よくある落とし穴** — 教師データの品質依存、バイアス継承、訓練不安定性

---

## 使い方

| モード | 使いどき | 返ってくるもの |
|--------|----------|---------------|
| `minimal` | 設計前の初期チェック | 技術名 + 簡易 OSS リスト + リスクフラグ |
| `full` | アーキテクチャ決定・新規サブシステム設計 | 研究系譜 + OSS マトリクス + トレードオフ + 失敗モード |
| `selector` | どちらか迷ったとき | minimal か full に自動振り分け |

<details>
<summary><strong>例：full モード出力</strong></summary>

**入力**: `@prior-art-investigation full LLM の出力を使って小さい ML モデルを学習させたい`

**出力**:

**技術名**: 知識蒸留（Knowledge Distillation）

> この技術は 10 年以上の歴史があります。元々はモデル圧縮手法（[Hinton ら 2015年](https://arxiv.org/abs/1503.02531)「Distilling the Knowledge in a Neural Network」）だったのが、[DistilBERT](https://arxiv.org/abs/1910.01108)（2019年）、[MiniLM](https://arxiv.org/abs/2002.10957)（2021年）を経て、2023年から LLM 応用が爆発的に増えました。核心は：小さいモデルが大きいモデルの出力 + 推論を学ぶと、計算量 10% で性能 90% を達成できるということ。

**研究系譜**:
| 年 | 論文 | 重要な洞察 |
|----|------|----------|
| 2015 | Hinton ら ["Distilling the Knowledge in a Neural Network"](https://arxiv.org/abs/1503.02531) | 温度付きソフトマックスで知識転移が可能 |
| 2019 | Sanh ら ["DistilBERT"](https://arxiv.org/abs/1910.01108) | BERT スケールの蒸留が実用的 |
| 2021 | Wang ら ["MiniLM"](https://arxiv.org/abs/2002.10957) | 層間マッチングで小モデルが改善 |
| 2023 | Li ら ["Distilling Step-by-Step"](https://arxiv.org/abs/2212.10071) | LLM の推論プロセス自体を蒸留可能 |
| 2024 | Zheng ら ["LLaMA-Factory"](https://arxiv.org/abs/2403.13372) | 本番対応蒸留パイプライン |

**OSS 評価マトリクス**:
| ツール | ライセンス | メンテナー | 更新頻度 | データ準備 | 向いてる用途 | ソース |
|------|----------|----------|---------|----------|------------|------|
| Hugging Face transformers | Apache-2.0 | Hugging Face（組織） | 活発（毎週） | 低 | 標準 BERT スケール蒸留 | [GitHub](https://github.com/huggingface/transformers) |
| LLaMA-Factory | Apache-2.0 | HKUST / 清華大学（学術組織） | 活発（毎月） | 中 | LLM 蒸留エンドツーエンド | [GitHub](https://github.com/hiyouga/LLaMA-Factory) |
| 論文提供コード | 様々 | 個人研究者 | 停滞気味 | 高 | 研究・カスタムアーキテクチャ | [arXiv](https://arxiv.org/abs/2212.10071) |

**よくある落とし穴**:
- **教師バイアス**: 小モデルが教師の誤りとバイアスを引き継ぐ
- **データ品質**: 推論ラベルの質がなければ蒸留は失敗
- **訓練不安定**: 温度調整と損失加重が敏感
- **検証必須**: 直接訓練とA/Bテストで常に比較

</details>

---

## 使い方

### A. VS Code カスタムエージェント — セットアップ不要（推奨）

> 必要なもの: VS Code + GitHub Copilot Chat

このリポジトリに含まれる `.github/agents/prior-art.agent.md` は **VS Code カスタムエージェント** ファイルです（VS Code 1.99 / 2025年4月導入、2026年4月スキーマ更新）。

**このリポジトリで使う場合** — チャットのドロップダウンから選ぶだけ：

1. Copilot Chat を開く（`⌃⌘I`）
2. エージェントセレクター → **Prior Art Investigation** を選択
3. `git diff HEAD` を自動確認し、spec ファイルが変更されていれば調査を実行

**自分のプロジェクトで使う場合** — エージェントファイルをコピー：

```bash
mkdir -p .github/agents
cp path/to/prior-art-investigation/.github/agents/prior-art.agent.md .github/agents/
```

Copilot Chat のドロップダウンから **Prior Art Investigation** を選択するだけ。

> **注意**: `.chatmode.md` は旧形式（廃止済み）です。VS Code 1.99+ は `.github/agents/*.agent.md` を使用します。古い `.chatmode.md` があれば名前を変更してください。

---

### B. VS Code Agent Skills（ワークスペース横断）— 2 分

**この方法は複数プロジェクトをまたいで使いたい場合**に向いています。`.instructions.md` を Agent Skills フォルダにコピーして VS Code を再起動：

```bash
# macOS
cp .instructions.md \
  ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/agent-skills/prior-art-investigation.md

# Linux
cp .instructions.md \
  ~/.config/Code/User/globalStorage/github.copilot-chat/agent-skills/prior-art-investigation.md
```

Copilot Chat で使う：

```
@prior-art-investigation minimal リアルタイム検索機能を設計したい
```

→ [詳細セットアップ](./AGENT-SKILLS-SETUP.md)

---

### C. Claude Desktop (MCP) — 5 分

`claude_desktop_config.json` に追加：

```json
{
  "mcpServers": {
    "prior-art-investigation": {
      "command": "python3",
      "args": ["/path/to/prior-art-investigation/mcp/server_lite.py"]
    }
  }
}
```

Claude Desktop を再起動 → ツール `load_minimal` / `load_full` / `load_selector` が使用可能。

→ [詳細セットアップ](./MCP-SETUP.md)

---

### D. Kiro SDD — フック・パーソナリティをコピー

```bash
cp -r .kiro/hooks /your-project/.kiro/
cp -r .kiro/personalities /your-project/.kiro/
```

要件定義・設計フェーズで先行技術調査が自動的に実行される。

#### VS Code Copilot Chat: フック形式と無効化

`.kiro/hooks/` ディレクトリには **Kiro IDE** 形式（`enabled` フラグ付き JSON）と **VS Code** 形式（`agentStop` トリガー付き `.kiro.hook`）の両方が含まれてます。

**VS Code セットアップ**（`.json` ではなく `.kiro.hook` をコピー）:
```bash
cp .kiro/hooks/*.kiro.hook /your-project/.kiro/hooks/
```

フックは**デフォルトで無効**（`"enabled": false`）です。有効化するには：
```bash
# 要件フックを有効化:
# .kiro/hooks/prior-art-requirements.kiro.hook を開く
# "enabled": false を "enabled": true に変更

# 設計フックを有効化:
# .kiro/hooks/prior-art-design.kiro.hook を開く
# "enabled": false を "enabled": true に変更
```

> **推奨**: ファイル編集不要の [VS Code カスタムエージェント](#a-vs-code-カスタムエージェント--セットアップ不要推奨) をご利用ください。調査が必要なときだけエージェントを切り替えるだけです。

#### GitHub Copilot Cloud Agent（ブラウザ版）— 別スキーマ

**VS Code** と **GitHub Copilot Cloud Agent**（copilot.github.com）は `.github/hooks/` を共有しますが、スキーマが非互換です：

| 項目 | VS Code | GitHub Cloud Agent |
|------|---------|-------------------|
| `version` | 不要 | `1` 必須 |
| イベント名のケース | PascalCase（`UserPromptSubmit`）| camelCase（`userPromptSubmitted`）|
| スクリプトキー | `command` / `osx` / `linux` | `bash` / `powershell` |
| タイムアウトキー | `timeout` | `timeoutSec` |
| `agentStop` 相当 | `"Stop"` | `"sessionEnd"` |

このフレームワークの `.kiro.hook` ファイルは **VS Code Copilot Chat 向け**に最適化されています。Cloud Agent ユーザーは別スキーマのフックファイルが必要です。参考: [VS Code hooks ドキュメント](https://code.visualstudio.com/docs/copilot/copilot-extensibility-overview) / [GitHub Cloud Agent hooks ドキュメント](https://docs.github.com/en/copilot/reference/hooks-configuration)。

---

## オプション：フック実行の制御

**推奨**: [VS Code カスタムエージェント](#a-vs-code-カスタムエージェント--セットアップ不要推奨) を使ってください。調査が必要なときだけドロップダウンからエージェントを切り替えるだけで、ファイル編集は不要です。

**レガシーフック方式**（ファイルベースのフックを使いたい場合）：

先行技術調査のたびにトークン消費が増えます。フックは**デフォルトで無効**になっており、プロジェクトごとに有効化できます。

### フックを有効にする
1. `.kiro/hooks/prior-art-requirements.kiro.hook` を開く
2. `"enabled": false` → `"enabled": true` に変更
3. `.kiro/hooks/prior-art-design.kiro.hook` も同様に変更

### 有効にすべき場面
- **ゼロイチ・新規開発** — 未知の領域、発見価値が高い
- **大型アーキテクチャ決定** — 新しいサブシステム、新規依存関係の選定
- **技術選定** — OSS オプション間の比較検討

### 無効のままでよい場面
- **保守・リファクタリング** — 既存コード、新しい概念なし
- **既知のパターン** — すでに十分な知識がある
- **トークン予算制約** — 複数の調査を並列実行中

---

## パーソナリティ一覧（Kiro SDD 用）

調査の観点をパーソナリティで切り替える：

| パーソナリティ | 得意な調査 |
|--------------|-----------|
| `researcher` | 学術論文・引用・既存研究 |
| `startup-hunter` | 市場検証・競合分析・スタートアップ動向 |
| `tech-auditor` | 技術的深度・アーキテクチャ・エンジニアリングベストプラクティス |
| `patent-search` | IP リスク・特許景観・先行技術クレーム |
| `team-internal` | 社内ナレッジ・既存ドキュメント・社内パターン |
| `platform-expert` | IDE・ランタイムのネイティブ API・プラットフォームフック・SDK 機能 — プラットフォームが既に持つ機能の再発明を防ぐ |

---

## カスタマイズ

### 質問フレームワーク（Q1〜Q7）

`minimal` は Q1（第一原理）+ Q6（反転リスク）のみ使用。  
`full` は Q1〜Q8 の全質問を使用。Q8 はプラットフォームネイティブ機能の調査（IDE・SDK・ランタイムが既に持つ機能の確認）。

質問の内容は `.instructions.md` または `.instructions.ja.md` を直接編集して変更できる。

### パーソナリティのカスタマイズ

`.kiro/personalities/` 内の JSON ファイルを編集する：

```json
{
  "name": "my-custom",
  "label": "My Custom Researcher",
  "description": "Focus on ...",
  "questions": ["What ...?", "Are there ...?"]
}
```

---

**バージョン**: 1.0.0 | **ライセンス**: MIT

---

## ドキュメント

セットアップガイド（言語別）：

| | 日本語 | English |
|-|---------|--------|
| VS Code セットアップ | [AGENT-SKILLS-SETUP.md](./AGENT-SKILLS-SETUP.md) | [docs/en/AGENT-SKILLS-SETUP.md](../en/AGENT-SKILLS-SETUP.md) |
| Claude セットアップ | [MCP-SETUP.md](./MCP-SETUP.md) | [docs/en/MCP-SETUP.md](../en/MCP-SETUP.md) |

---

## ライセンス

MIT

- **GitHub**: https://github.com/as-we/prior-art-investigation
- **Release**: https://github.com/as-we/prior-art-investigation/releases/tag/v1.0.0
