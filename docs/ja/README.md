# 先行技術調査フレームワーク

コードを書く前に、機能の概念名・既存パターン・OSS を素早く特定する。

**[English](../../README.md)**

---

## 何ができるか

SDD（仕様駆動開発）を使えば、やりたいことベースで要件定義・設計・実装を進められます。

たとえば：
> 「LLM で推論理由を出力させて、その結果を使って小さい ML モデルを学習させたい」

この一文だけで開発は進みます。**ただし、このやり方には盲点があります。**

「知識蒸留（Knowledge Distillation）」という確立した研究分野がすでに存在し、10年以上の論文・OSS・失敗事例の蓄積があります。それを知らないまま実装を進めると、既存の成果を自分で再発明することになります。「自分で考えた」と思い込んだまま。

**このフレームワークは、設計を始める前にその盲点を埋めます。**

```
/prior-art full LLM の出力を使って小さい ML モデルを学習させたい
```

返ってくる情報：

- **技術名** — 「知識蒸留（Knowledge Distillation）」（2015年 Hinton らが提案した既存研究）
- **研究発展の流れ** — モデル圧縮 → ニューラルネット蒸留 → 2023年以降は LLM 蒸留が急増
- **既存 OSS** — DistilBERT、LLaMA-Factory、Hugging Face transformers など、評価マトリクス付き
- **よくある落とし穴** — 教師データの品質依存、バイアス継承、訓練不安定性

---

## OSS・技術選定にも使える

研究概念だけが対象ではありません。ML システムを構築していなくても役に立ちます。

**OCR / PDF ライブラリの選定** — Tesseract vs EasyOCR vs クラウド API を1行も統合コードを書く前に評価する。精度ベンチマーク・ライセンスの種類・メンテナンス状態を一次情報から返します。

**プログラミング言語・ランタイムの技術判断** — スタックに制約がある場合（非同期モデル・エコシステム成熟度・WASM 対応など）、Stack Overflow の意見ではなく実際のポストモーテムや RFC に基づいたトレードオフを返します。

**新しい依存関係を追加する前の判断全般** — 評価基準はプロンプトで自由に調整できます。根底にある問いは常に同じです：

> *これにコミットする前に、何を知っておく必要があるか？*

- このライブラリの作者は個人か組織か？（長期メンテナンスのシグナル）
- 最後のコミットはいつか？（健全性のシグナル）
- ライセンスの種類は？（法的リスク — MIT/Apache = Tier 1、GPL = Tier 3、AGPL = 採用不可）
- 近い代替ツール2つと比べてどうか？

---

## モードと出力

| モード | フェーズ | 時間 | 返ってくるもの |
|--------|---------|------|--------------|
| `minimal` | 要件定義 / Spec | 約5分 | 技術名 + 簡易 OSS リスト + リスクフラグ（Q1+Q6） |
| `full` | 設計 / Plan | 約20分 | 研究系譜 + OSS マトリクス + トレードオフ + 失敗モード（Q1–Q7） |
| `sowhat` | タスク生成 | 約2分 | 先行技術調査を踏まえて変更すべきタスク（Q7のみ） |
| `selector` | どこでも | — | minimal か full に自動振り分け |

**調査結果は記録される。** 各調査は `research.md` に書き出されます — 将来のチームメンバー（または将来の自分）が何を検討してなぜその判断をしたかを確認できます：

```
## Named Concept
| フィールド     | 値                                                     |
|----------------|--------------------------------------------------------|
| 概念名         | 知識蒸留（Knowledge Distillation）                      |
| 初出           | 2015年 / Hinton ら、NeurIPS                              |
| 成熟度         | ✅ 本番利用可能                                          |
| 設計への影響   | 温度スケーリング使用; LLM ラベルの品質ゲートを追加       |

## OSS Decision
| パッケージ      | ライセンス  | 最終更新  | 判定                              |
|----------------|------------|-----------|-----------------------------------|
| HF transformers | Apache-2.0 | 活発      | ✅ 採用                            |
| LLaMA-Factory   | Apache-2.0 | 活発      | ❌ このユースケースにはオーバースペック |
```

**入力**: `/prior-art full LLM の出力を使って小さい ML モデルを学習させたい`

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

## SDD フレームワーク統合

フェーズに応じた深度で**自動的に**実行されます — 手動トリガー不要。

| フェーズ | 深度 | 質問 | 自動トリガー対応フレームワーク |
|---------|------|------|--------------------------|
| 要件定義 / Spec | Minimal | Q1 + Q6 | SpecKit `before_specify`、Kiro `requirements` フック、Claude Code CLAUDE.md |
| 設計 / Plan | Full | Q1–Q7 | SpecKit `before_plan`、Kiro `design` フック、Claude Code CLAUDE.md |
| タスク | So-What | Q7のみ | SpecKit `before_tasks`、Claude Code CLAUDE.md |

**GitHub SpecKit**（VS Code + GitHub Copilot）:
```bash
specify extension add https://github.com/as-we/prior-art-investigation
```
`before_specify`・`before_plan`・`before_tasks` フックが自動登録されます。

**Kiro SDD**: `.kiro/hooks/` をプロジェクトにコピー — 要件・設計フェーズで自動発火。

**Claude Code**: `claude-code/CLAUDE.md.snippet` を `CLAUDE.md` に追記 — 各フェーズで自動的に発動。

**スタンドアロン**（任意の IDE）: `/prior-art` スラッシュコマンドまたはプロンプトファイルを手動で使用。

→ 詳細なセットアップ手順: [セットアップガイド](./SETUP.md)

---

## クイックスタート

```bash
git clone https://github.com/as-we/prior-art-investigation
cd prior-art-investigation
make install
```

**1回だけ実行すれば全プロジェクトで有効。** VS Code + Copilot Chat で `/prior-art` が使えるようになります。`#web` を付けると学習カットオフを突破したライブ検索で調査できます。

- 詳細なセットアップ（SpecKit / Kiro / Claude Code / Claude Desktop）→ [セットアップガイド](./SETUP.md)
- 使い方・調査結果の読み方・スキップ判断 → [使い方ガイド](./USAGE.md)

---

**バージョン**: 1.1.1 | **ライセンス**: MIT

---

## ドキュメント

| | 日本語 | English |
|-|---------|--------|
| 概要 | [docs/ja/README.md](./README.md) | [README.md](../../README.md) |
| 使い方ガイド（SDD ワークフロー） | [docs/ja/USAGE.md](./USAGE.md) | [docs/en/USAGE.md](../en/USAGE.md) |
| セットアップガイド（インストール） | [docs/ja/SETUP.md](./SETUP.md) | [docs/en/SETUP.md](../en/SETUP.md) |
| Q1-Q8 解説 | [docs/ja/QUESTIONS.md](./QUESTIONS.md) | [docs/en/QUESTIONS.md](../en/QUESTIONS.md) |

---

## ライセンス

MIT

- **GitHub**: https://github.com/as-we/prior-art-investigation
- **Release**: https://github.com/as-we/prior-art-investigation/releases/tag/v1.1.1
