# セットアップガイド

Prior Art Investigation Framework のインストール方法を、使いたいツールに応じて選んでください。

**ジャンプ**: [VS Code Agent Skills](#a-vs-code-copilot-chat--agent-skills) | [自動検知フック](#b-自動検知フックvs-code--userpromptsubmit) | [Claude Desktop](#c-claude-desktopmcpサーバー) | [Kiro IDE](#d-kiro-ide--フックパーソナリティ) | [VS Code カスタムエージェント](#e-vs-codeカスタムエージェントプロジェクト単位) | [GitHub SpecKit](#f-github-speckit-extension) | [Claude Code](#g-claude-code)

---

## クイックスタート（推奨）

```bash
git clone https://github.com/as-we/prior-art-investigation
cd prior-art-investigation
make install
```

これだけで **第1層（Agent Skills）+ 第2層（自動検知フック）** が両方インストールされます。

---

## A. VS Code Copilot Chat — Agent Skills

### インストール

```bash
make install-skills
```

または手動：

```bash
# 全プラットフォーム共通
mkdir -p ~/.copilot/skills/prior-art
cp .github/skills/prior-art/SKILL.md ~/.copilot/skills/prior-art/SKILL.md
```

VS Code を再起動して反映。

### 使い方

Copilot Chat にスラッシュコマンドで入力：

```
/prior-art minimal  API のレート制限を実装したい
/prior-art full     分散キャッシュのアーキテクチャを設計したい
/prior-art selector ← どちらか迷ったとき、自動振り分け
```

> 日本語で回答が必要な場合は以下のように入力：  
> ```
> /prior-art full LLMを使った知識蒸留の設計 (回答は日本語で)
> ```

### GitHub SpecKit との連携

SpecKit ワークフローでは、各フェーズの**前**に手動で実行します：

| SpecKit フェーズ | 実行するコマンド | モード |
|----------------|----------------|--------|
| `speckit.specify` の前（要件定義） | `/prior-art minimal #web <トピック>` | MINIMAL（Q1+Q6） |
| `speckit.plan` の前（設計） | `/prior-art full #web <トピック>` | FULL（Q1–Q8） |

`#web` を付けると最新の OSS リリース状況をライブ取得できます。自動フックはないため、フェーズを開始する前に手動で呼び出してください。

### トラブルシューティング

| 症状 | 対処 |
|------|------|
| エージェントが表示されない | ファイルのコピー確認 → VS Code を完全再起動 |
| エラーが返る | Copilot Chat を最新版に更新 |

---

## B. 自動検知フック（VS Code / UserPromptSubmit）

### インストール

```bash
make install-hook
```

VS Code 設定に追加：

```json
"chat.hookFilesLocations": { "~/.copilot/hooks": true }
```

### 動作

設計・実装に関係するプロンプトを送ると、自動でリマインダーが1行挿入されます：

> 💡 Prior art check recommended: this looks like a design or implementation decision...

フックは `~/.copilot/hooks/` に配置されるため、**プロジェクトのファイルを汚しません**。

### アンインストール

```bash
make uninstall
# または手動
rm ~/.copilot/hooks/prior-art-detect.json
rm ~/.copilot/hooks/scripts/prior-art-detect.sh
```

---

## C. Claude Desktop（MCP サーバー）

### インストール

`~/.claude/claude_desktop_config.json`（Windows: `%APPDATA%\Claude\claude_desktop_config.json`）に追加：

```json
{
  "mcpServers": {
    "prior-art": {
      "command": "python3",
      "args": ["/path/to/prior-art-investigation/mcp/server_lite.py"]
    }
  }
}
```

Claude Desktop を再起動。

### 使えるツール

| ツール | 用途 |
|--------|------|
| `load_minimal` | Q1+Q6 のみ — 要件定義フェーズ向け |
| `load_full` | Q1-Q8 全体 — 設計フェーズ向け |
| `load_selector` | 自動振り分け |

### トラブルシューティング

```bash
# Python パスの確認
which python3

# サーバーが単体で起動するか確認
python3 /path/to/prior-art-investigation/mcp/server_lite.py

# ファイル権限確認
chmod +x /path/to/prior-art-investigation/mcp/server_lite.py
```

Claude Desktop ログ（macOS: Console.app で「Claude」検索）も確認してください。

---

## D. Kiro IDE — フック・パーソナリティ

```bash
cp -r .kiro/hooks /your-project/.kiro/
cp -r .kiro/personalities /your-project/.kiro/
```

要件定義（`/kiro-spec-requirements`）・設計（`/kiro-spec-design`）フェーズで自動的に先行技術調査が実行されます。

### パーソナリティ一覧

パーソナリティは「**どの観点から調査するか**」を切り替える設定です。フェーズによってデフォルトが異なります。

| パーソナリティ | 得意な調査 | Kiro デフォルトフェーズ |
|--------------|-----------|----------------------|
| `startup-hunter` | 市場検証・競合分析・スタートアップ動向 | 要件定義（`/kiro-spec-requirements`） |
| `tech-auditor` | 技術的深度・アーキテクチャ・エンジニアリングBP | 設計（`/kiro-spec-design`） |
| `researcher` | 学術論文・引用・既存研究 | — |
| `patent-search` | IP リスク・特許景観・先行技術クレーム | — |
| `team-internal` | 社内ナレッジ・既存ドキュメント・社内パターン | — |
| `platform-expert` | IDE・ランタイムのネイティブ API・SDK 機能。プラットフォームが既に持つ機能の再発明を防ぐ | — |

### パーソナリティの変更

**フックの設定ファイルを編集する**（`.kiro/hooks/*.json`）:

```json
// .kiro/hooks/prior-art-requirements.json
{
  "phase": "requirements",
  "personality": "researcher",   // ← ここを変更
  "trigger": "after_kiro_spec_requirements"
}
```

**環境変数で一時的に上書き**:

```bash
PRIOR_ART_PERSONALITY=patent-search kiro spec requirements
```

### カスタムパーソナリティの作成

`.kiro/personalities/` に JSON ファイルを追加するだけで使えます：

```json
// .kiro/personalities/security-auditor.json
{
  "name": "security-auditor",
  "label": "Security Auditor",
  "description": "Focus on known vulnerabilities, CVEs, and security patterns",
  "questions": [
    "Are there known CVEs or vulnerabilities in this approach?",
    "What security patterns already exist for this problem?",
    "Are there OWASP guidelines relevant here?"
  ],
  "web_sources": ["GitHub", "NIST NVD", "OWASP", "CVE Database"]
}
```

---

## E. VS Code カスタムエージェント（プロジェクト単位）

チームでリポジトリに設定を含めたい場合：

```bash
mkdir -p .github/agents
cp path/to/prior-art-investigation/.github/agents/prior-art.agent.md .github/agents/
```

Copilot Chat のエージェントドロップダウンから **Prior Art Investigation** を選択。

---

## F. GitHub SpecKit Extension

[GitHub SpecKit](https://github.com/speckit-ai/specify)（`specify` CLI）を使っているチーム向け。フックで自動トリガーされます。

| SpecKit フェーズ | フック | 調査深度 |
|----------------|------|---------|
| `speckit.specify` | `before_specify` | Minimal（Q1 + Q6） |
| `speckit.plan` | `before_plan` | Full（7問 + OSS マトリックス） |
| `speckit.tasks` | `before_tasks` | So-What（Q7のみ） |

すべてのフックは `optional: true` — スキップしてもワークフローは継続されます。

### インストール

```bash
# Option 1: specify CLI 経由
specify extension add https://github.com/as-we/prior-art-investigation

# Option 2: 手動コピー
mkdir -p .specify/extensions/prior-art-investigation
cp -r speckit/ .specify/extensions/prior-art-investigation/
```

### フック登録

`.specify/extensions.yml` に追記（`speckit/extensions.yml.sample` 参照）：

```yaml
hooks:
  before_specify:
    - extension: prior-art-investigation
      command: prior-art-minimal
      enabled: true
      optional: true
  before_plan:
    - extension: prior-art-investigation
      command: prior-art-full
      enabled: true
      optional: true
  before_tasks:
    - extension: prior-art-investigation
      command: prior-art-sowhat
      enabled: true
      optional: true
```

### 手動実行

```
/prior-art minimal  APIレートリミッターを実装したい
/prior-art full     分散キャッシュ層を設計したい
/prior-art sowhat   ← タスクが先行技術調査を反映しているか確認
```

---

## G. Claude Code

Claude Code はプロジェクトルートの `CLAUDE.md` を常駐指示として自動読み込みします。提供のスニペットを追記することで、各フェーズで自動的に prior art チェックが発動します。

### インストール

```bash
# ルールファイルをコピー
cp .kiro/settings/rules/oss-evaluation.md /your-project/.kiro/settings/rules/

# CLAUDE.md スニペットを確認・追記
cat claude-code/CLAUDE.md.snippet  # 内容確認後、CLAUDE.md に追記
```

### 動作

| フェーズ | トリガー | 調査深度 |
|---------|---------|---------|
| 要件定義 / Spec | CLAUDE.md による自動 | Minimal（Q1 + Q6） |
| 設計 / Plan | CLAUDE.md による自動 | Full（7問 + OSS マトリックス） |
| タスク生成 | CLAUDE.md による自動 | So-What（Q7） |

### 手動実行

```
# Spec フェーズ（minimal）
[機能]について prior art チェックを行ってください。Q1（第一原理）とQ6（反転）を使用し、結果を research.md に記録してください。

# Plan フェーズ（full）
[機能]について完全な prior art 調査を行ってください。7問すべてを適用し、OSSマトリックスを作成してください。

# Tasks フェーズ（So-What）
tasks.md を確認し、各タスクが先行技術調査結果を反映しているかチェックしてください。
```

---

## 調査の内容について

Q1〜Q8 の詳細（各質問の意図・サンプル出力）は [QUESTIONS.md](./QUESTIONS.md) を参照してください。

