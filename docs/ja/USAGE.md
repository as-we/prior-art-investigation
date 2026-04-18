# 使い方ガイド — AI 先行技術調査

設計前に「この概念は既に名前がある」「使える OSS がある」「失敗パターンが分かっている」ことを確認できます。

---

## どのツールを使っていますか？

| ツール | 自動実行 | 手動実行 | セクション |
|--------|---------|---------|-----------|
| **VS Code + GitHub Copilot** | リマインダー通知（opt-in で実調査） | `/prior-art` スラッシュコマンド | [→ A](#a-vs-code--github-copilot) |
| **Kiro IDE** | SDD フェーズで自動発火 | エージェントドロップダウン選択 | [→ B](#b-kiro-ide) |
| **Claude Desktop** | なし | MCP ツール呼び出し | [→ C](#c-claude-desktop) |

> **調査モードについて**  
> `MINIMAL`（Q1+Q6）: 要件フェーズ向け。「本質的な問題か」「失敗リスクは何か」を5〜10分で確認。  
> `FULL`（Q1〜Q8）: 設計フェーズ向け。概念名・OSS比較・アーキテクチャ推奨・プラットフォームネイティブ機能まで20〜40分で確認。

---

## A. VS Code + GitHub Copilot

### インストール（1回だけ）

```bash
git clone https://github.com/as-we/prior-art-investigation
cd prior-art-investigation
make install
```

これだけで以下の2つがセットアップされます：
- **Agent Skills** — Copilot Chat で `/prior-art` スラッシュコマンドを任意のプロジェクトで呼び出せる
- **UserPromptSubmit フック** — 設計・アーキテクチャに関係するプロンプトに自動でリマインダーを挿入

VS Code 設定にフックを有効化：
```json
"chat.hookFilesLocations": { "~/.copilot/hooks": true }
```

---

### 自動実行 1 — プロンプト監視リマインダー（常時、インストール後）

「設計」「アーキテクチャ」「実装したい」などのキーワードを含むプロンプトを送ると、自動で1行挿入されます：

> 💡 Prior art check recommended: this looks like a design or implementation decision. Before building, consider running: `/prior-art full <topic>`

**特徴**: LLM 不使用・シェルスクリプトによる判定。トークン消費なし。

---

### 自動実行 2 — SDD フェーズ連動（opt-in）

cc-sdd の `/kiro-spec-requirements` や `/kiro-spec-design` セッション終了後に**実際の調査を自動実行**させるには、プロジェクトの `.kiro/hooks/` ファイルを有効化します。

```bash
# プロジェクトの .kiro/hooks/ をコピー（初回のみ）
cp -r path/to/prior-art-investigation/.kiro/hooks /your-project/.kiro/

# 有効化
jq '.enabled = true' .kiro/hooks/prior-art-requirements.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-requirements.kiro.hook
jq '.enabled = true' .kiro/hooks/prior-art-design.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-design.kiro.hook
```

- `/kiro-spec-requirements` 終了 → `requirements.md` の変更を検知 → **MINIMAL 調査（Q1+Q6）**
- `/kiro-spec-design` 終了 → `design.md` の変更を検知 → **FULL 調査（Q1〜Q8）**

出力先: `.tmp/[TICKET-XXX]/prior-art-requirements.md` / `prior-art-design.md`

---

### 自動実行の on/off 制御

**無効化**（リファクタリング・既知の実装など調査不要なとき）:
```bash
jq '.enabled = false' .kiro/hooks/prior-art-requirements.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-requirements.kiro.hook
jq '.enabled = false' .kiro/hooks/prior-art-design.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-design.kiro.hook
```

**リマインダーフックだけ無効化**:
```bash
make uninstall
# または
rm ~/.copilot/hooks/prior-art-detect.json ~/.copilot/hooks/scripts/prior-art-detect.sh
```

> `jq` が未インストールの場合: `brew install jq`

---

### 手動実行

Copilot Chat にスラッシュコマンドで入力：

```
/prior-art minimal  API のレート制限を設計したい
/prior-art full     LLM を使った知識蒸留アーキテクチャを設計したい
/prior-art selector ← MINIMAL / FULL を自動判定
```

**spec ファイル未変更の場合**も、調査トピックを添えて実行できます。

**いつ使う**:
- 自動実行のタイミングと関係なく調査したいとき
- 実装中に新しい OSS を採用検討したいとき
- 特定の技術をピンポイントで確認したいとき

---

## B. Kiro IDE

### インストール（1回だけ）

```bash
# フックとパーソナリティをプロジェクトにコピー
cp -r path/to/prior-art-investigation/.kiro/hooks /your-project/.kiro/
cp -r path/to/prior-art-investigation/.kiro/personalities /your-project/.kiro/

# エージェントをコピー（手動実行用）
mkdir -p .github/agents
cp path/to/prior-art-investigation/.github/agents/prior-art.agent.md .github/agents/
```

---

### 自動実行 — SDD フェーズ連動

Kiro IDE では SDD コマンドと連動して**自動的に調査が発火**します。追加設定不要。

| Kiro コマンド | 発火タイミング | 調査モード | デフォルト設定 |
|-------------|------------|----------|------------|
| `/kiro-spec-requirements` | セッション終了 + `requirements.md` 変更検知 | MINIMAL（Q1+Q6） | `personality: startup-hunter` |
| `/kiro-spec-design` | セッション終了 + `design.md` 変更検知 | FULL（Q1〜Q8） | `personality: tech-auditor` |

出力先: `.tmp/[TICKET-XXX]/prior-art-requirements.md` / `prior-art-design.md`

---

### 自動実行の on/off 制御

`.kiro/hooks/*.kiro.hook` の `enabled` フラグで制御します：

**無効化**（リファクタリング・保守作業など）:
```bash
jq '.enabled = false' .kiro/hooks/prior-art-requirements.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-requirements.kiro.hook
jq '.enabled = false' .kiro/hooks/prior-art-design.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-design.kiro.hook
```

**有効化**:
```bash
jq '.enabled = true' .kiro/hooks/prior-art-requirements.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-requirements.kiro.hook
jq '.enabled = true' .kiro/hooks/prior-art-design.kiro.hook > /tmp/h.tmp \
  && mv /tmp/h.tmp .kiro/hooks/prior-art-design.kiro.hook
```

**パーソナリティを変更する場合**（どの観点で調査するか）:
```json
// .kiro/hooks/prior-art-requirements.kiro.hook
{
  "personality": "researcher"   // startup-hunter / tech-auditor / researcher / patent-search / team-internal / platform-expert
}
```

→ パーソナリティ詳細: [SETUP.md § パーソナリティの変更](./SETUP.md#パーソナリティの変更)

---

### 手動実行

Kiro のエージェントドロップダウン（チャット上部）から **Prior Art Investigation** を選んで、調査トピックを入力：

```
minimal  新しいキャッシュ戦略を検討している
full     分散トレーシングのアーキテクチャを設計したい
selector ← MINIMAL / FULL を自動判定
```

または Kiro で Agent Skills が利用可能な場合は `/prior-art` スラッシュコマンドも使えます。

---

## C. Claude Desktop

### インストール（1回だけ）

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

---

### 自動実行について

Claude Desktop には SDD フェーズとの自動連動機能はありません。手動でツールを呼び出してください。

---

### 手動実行

Claude のチャットで以下の MCP ツールを呼び出します：

| ツール | 用途 |
|--------|------|
| `load_minimal` | MINIMAL 調査（Q1+Q6）— 要件フェーズ、素早く確認したいとき |
| `load_full` | FULL 調査（Q1〜Q8）— 設計フェーズ、深く掘り下げたいとき |
| `load_selector` | 自動で MINIMAL / FULL を振り分け |

**使い方の例**:
```
load_full で「LLM を使った知識蒸留アーキテクチャ」を調査して
```

---

## 調査結果の読み方

### MINIMAL 出力（Q1+Q6）

- **Q1 First Principles**: 解こうとしている問題は正しく定義されているか。根本原因を解いているか
- **Q6 Inversion**: 6ヶ月後にこれが失敗するとしたら何が原因か。進む前に検証すべきこと

### FULL 出力（Q1〜Q8）

Q1・Q6 に加えて:
- **Q2**: 技術名・アーキテクチャパターン・研究系譜
- **Q3**: 解法の選択肢一覧とトレードオフ
- **Q4**: OSS 評価マトリクス（ライセンス・メンテナー・更新頻度・適合ユースケース）
- **Q5**: Build vs. Adopt の推奨と根拠
- **Q7**: 優先度付きの次のアクション
- **Q8**: ターゲットプラットフォームのネイティブ機能確認（再発明の防止）

> ⚠️ **注意 — LLM 学習カットオフ**: LLM の学習カットオフ以降の情報は含まれません。出力末尾の「手動確認チェックリスト」で公式ドキュメントの最新情報（GitHub Releases・Changelog）を必ず補完してください。過去6〜12ヶ月の更新は特に要注意です。

→ [Q1〜Q8 詳細解説](./QUESTIONS.md)

---

## スキップしてよい場面

| 場面 | 判断 |
|------|------|
| 保守・リファクタリング | スキップ可。新しい概念なし |
| 既によく知っている技術領域 | スキップ可 |
| 新規の外部サービス・OSS 採用 | 実行推奨（Q4 + Q8） |
| 新しいアーキテクチャパターンの採用 | 実行推奨（FULL） |
| ゼロイチ・新規サブシステム | 実行推奨（FULL） |
