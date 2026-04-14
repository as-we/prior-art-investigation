# 先行技術調査フレームワーク

コードを書く前に、機能の概念名・既存パターン・OSS を素早く特定する。

**[English](../en/README.md)**

---

## 何ができるか

参考コード・前例がない状態でゼロから開始するとき、すでに存在する概念や OSS を見落としやすい。

このフレームワークは、実装を始める **前に** AI エージェントを使って調査し、以下を返します：

- **正確な概念名** — 「自動更新キャッシュ」→「Cache-Aside パターン」のように業界標準の名称を特定
- **既存の OSS** — 単なるリストではなく、トレードオフを含めた評価マトリクス
- **研究系譜** — その考え方がどこから生まれて、どう発展したか、どの論文が検証したか
- **よくある落とし穴** — アーキテクチャ確定前に、何が壊れやすいかを把握

使用するタイミングは **要件定義・設計フェーズの冒頭**。

| モード | 使いどき | 時間 | トークン |
|--------|----------|------|---------|
| `minimal` | 要件定義フェーズ（概念名 + 軽量調査） | 5-10 分 | ~150 |
| `full` | 設計フェーズ（研究系譜・評価マトリクス・トレードオフ） | 20-40 分 | ~500 |
| `selector` | フェーズが不明（自動ルーティング） | 1-2 分 | ~100 |

<details>
<summary><strong>出力例（full モード）</strong></summary>

**入力**: `@prior-art-investigation full マイクロサービス間で分散ロックが必要`

**出力**:

**概念名**: Distributed Mutex / 分散ロック

> この問題は適切にスコープされています。「分散ロック」という用語は、Lamport の 1978年の論文（論理時計）から始まり、Google の Chubby ロックサービス（2006年）を通じて発展し、アプリケーション開発者向けには Redis ベースの実装で一般的になりました。

**研究系譜**:
| 年 | マイルストーン |
|----|---|
| 1978 | Lamport — 論理時計、順序理論の基礎 |
| 2006 | Google Chubby — 本番環境初の分散ロックサービス |
| 2016 | Redlock アルゴリズム（Antirez） — Redis 用分散ロック |
| 2016 | Martin Kleppmann の批判 — クロック斜度（Clock Skew）下での安全性懸念 |
| 2023 | etcd RAFT ベースリース — k8s 周辺では標準に |

**OSS 評価マトリクス**:
| ツール | 一貫性 | 運用複雑度 | 用途 |
|------|-------|--------|------|
| Redis + Redlock | ⚠️ 厳密ではない | 低 | レイテンシ最優先、稀な失敗許容 |
| etcd リース | ✅ 強い（RAFT） | 中 | Kubernetes 周辺、インフラレベル |
| ZooKeeper | ✅ 強い | 高 | JVM エコシステム、既存 ZK 利用者 |
| PostgreSQL 助言ロック | ✅ 強い | 低 | 既に Postgres 運用中、シンプルケース |

**推奨**: 既に Postgres を使用している場合は助言ロック。真の分散合意が必要な場合は etcd。特に理由がない限り Redlock は避ける。

**よくある落とし穴**:
- クロック斜度により、Redlock の TTL 仮定が無効化される
- ロック保持者がクラッシュ → ハートビート/フェンシングトークンが必要
- 再入可能ロック（reentrant lock）要件は複雑性を増す（ほとんどの実装が対応していない）

</details>

---

## 使い方

### A. VS Code Copilot — セットアップ不要

`.instructions.md` を Agent Skills フォルダにコピーして VS Code を再起動：

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

### B. Claude Desktop (MCP) — 5 分

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

### C. Kiro SDD — フック・パーソナリティをコピー

```bash
cp -r .kiro/hooks /your-project/.kiro/
cp -r .kiro/personalities /your-project/.kiro/
```

要件定義・設計フェーズで先行技術調査が自動的に実行される。

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

---

## カスタマイズ

### 質問フレームワーク（Q1〜Q7）

`minimal` は Q1（第一原理）+ Q6（反転リスク）のみ使用。  
`full` は Q1〜Q7 の全質問を使用。

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
