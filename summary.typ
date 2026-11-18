// arXiv:2411.11581v3 (25 Nov 2024) の発表用要約。
// 模式図や説明例は原論文の実測値・直接引用と区別して表示する。
#set document(title: "OASIS 論文要約", author: "中村晴")
#let accent = rgb("237744")
#let ink = rgb("26342d")
#set text(lang: "ja", font: ("Noto Sans JP", "Yu Gothic", "Arial"), size: 19pt, fill: ink)
#set page(
  paper: "presentation-16-9",
  margin: (top: 30pt, bottom: 47pt, left: 42pt, right: 42pt),
  footer-descent: 8pt,
  background: image("assets/bg.png", width: 100%, height: 100%, fit: "cover"),
  footer: context {
    set par(leading: 0pt, spacing: 0pt)
    if counter(page).get().first() > 1 {
      line(length: 100%, stroke: 0.5pt + gray)
      v(4pt)
      grid(columns: (1fr, auto),
        text(9pt)[工業英語 論文要約 / OASIS / arXiv:2411.11581v3],
        text(11pt)[#(counter(page).get().first() - 1)],
      )
    }
  },
)
#set par(leading: 0.6em)
#set list(marker: text("・", accent), spacing: 12pt)
#set table(stroke: 0.5pt + gray, inset: 9pt)
#show heading: it => {
  set text(accent, size: if it.level == 1 { 27pt } else { 21pt })
  it
}
#let note(body) = text(size: 11pt, fill: rgb("59665e"), body)
#let card(title, body) = block(
  width: 100%, inset: 13pt, radius: 5pt,
  fill: white, stroke: 0.6pt + accent.lighten(55%),
)[
  #text(17pt, weight: "bold", fill: accent, title)
  #v(7pt)
  #text(17pt, body)
]
#let takeaway(body) = block(width: 100%, inset: 11pt, radius: 4pt, fill: accent.lighten(91%))[
  #text(18pt, weight: "bold", body)
]
#let paper-eq(label, formula) = block(
  width: 100%, inset: (x: 12pt, y: 7pt), radius: 4pt,
  fill: white, stroke: 0.5pt + accent.lighten(65%),
)[
  #grid(columns: (1fr, 85pt), align: (center, horizon), gutter: 8pt,
    text(22pt, formula),
    text(11pt, fill: accent, label),
  )
]
#let tree-node(x, y, label) = place(top + left, dx: x, dy: y)[
  #block(width: 64pt, height: 26pt, inset: 3pt, radius: 4pt,
    fill: accent.lighten(91%), stroke: 0.7pt + accent)[
    #align(center + horizon)[#text(15pt, label)]
  ]
]
#let propagation-tree = block(width: 300pt, height: 150pt)[
  #place(top + left)[#line(start: (150pt, 26pt), end: (80pt, 60pt), stroke: 1pt + accent)]
  #place(top + left)[#line(start: (150pt, 26pt), end: (240pt, 60pt), stroke: 1pt + accent)]
  #place(top + left)[#line(start: (80pt, 86pt), end: (40pt, 120pt), stroke: 1pt + accent)]
  #place(top + left)[#line(start: (80pt, 86pt), end: (120pt, 120pt), stroke: 1pt + accent)]
  #place(top + left)[#line(start: (240pt, 86pt), end: (240pt, 120pt), stroke: 1pt + accent)]
  #tree-node(118pt, 0pt, [元投稿])
  #tree-node(48pt, 60pt, [A])
  #tree-node(208pt, 60pt, [B])
  #tree-node(8pt, 120pt, [C])
  #tree-node(88pt, 120pt, [D])
  #tree-node(208pt, 120pt, [E])
]
#let slide(section, title, ref, body) = {
  pagebreak()
  text(10pt, fill: accent, weight: "bold", section)
  v(1pt)
  heading(level: 1, title)
  body
  if ref != none {
    v(1fr)
    note[原論文: #ref]
  }
}

#align(center + horizon)[
  #text(14pt, fill: accent)[工業英語 / 論文紹介]
  #v(12pt)
  #text(40pt, weight: "bold", fill: accent)[OASIS]
  #v(8pt)
  #text(23pt, weight: "bold")[100万のAIエージェントで、SNSを模擬する]
  #v(18pt)
  #text(15pt)[
    Open Agent Social Interaction\
    Simulations with One Million Agents
  ]
  #v(24pt)
  #align(right)[#text(17pt)[f22123 5J-30 中村晴]]
]

#slide[01 / 研究の問い][AIの集団は、SNSの社会現象を再現できるか][要旨、§1、§3][
  #takeaway[OASISは、利用者同士の交流をLLMで模擬する研究基盤。]
  #v(13pt)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 14pt,
    card([仕組みをつくる], [推薦・投稿・フォローを組み合わせ、XやReddit型の環境を構成する。]),
    card([現実と比べる], [情報の広がり方や、他者の評価に影響される行動を調べる。]),
    card([人数を増やす], [数百人の実験から100万規模まで、集団の変化を観測する。]),
  )
  #v(10pt)
  #note[LLM（大規模言語モデル）を用いたエージェントが、それぞれ利用者役を演じる。]
]

#slide[01 / 背景][なぜ、SNSをコンピュータ上で模擬するのか][§1、付録B.3][
  - デマの拡散や意見の偏りは、投稿の内容だけでなく、推薦やフォロー関係、多数の利用者の反応から生まれる。
  - 実際のSNSでは、条件をそろえて大勢の利用者に繰り返し実験することが難しい。
  #v(8pt)
  #grid(columns: (1fr, auto, 1fr), gutter: 12pt,
    card([条件を設定], [誰が参加するか\
      どの投稿を見せるか\
      どの行動を許すか]),
    align(center + horizon)[#text(28pt, fill: accent)[→]],
    card([集団の変化を観測], [投稿はどこまで広がるか\
      意見はどう変わるか\
      人数で結果が変わるか]),
  )
  #v(8pt)
  #note[エージェントベースモデル（ABM）：個々の主体の行動と相互作用から、集団の変化を調べるモデル。]
]

#slide[01 / 提案の位置づけ][新規性は、人数とSNSの仕組みを一緒に扱うこと][§1、表1][
  #set text(size: 17pt)
  #table(columns: (1fr, 2.8fr),
    table.header([*着眼点*], [*OASISが用意したもの*]),
    [汎用性], [推薦方式や行動を切り替え、異なるSNS・実験設定に対応する。],
    [社会的な環境], [投稿と評価だけでなく、交流で変わるフォロー関係も管理する。],
    [規模の拡大], [最大100万エージェントを扱い、人数による結果の違いを調べる。],
  )
  #v(13pt)
  - 先行研究にも100万規模のシステムはある。人数だけで「初めて」とする主張ではない。
  - 特定の場面に特化したSNS研究の仕組みを、より広い実験に使えるよう統合した点が重要。
]

#slide[02 / 仕組み][1人のエージェントは、何を見て何をするか][§2.1、§2.4、付録D.1][
  #grid(columns: (1fr, auto, 1fr, auto, 1fr), gutter: 9pt,
    card([自分についての情報], [プロフィール\
      興味・性格\
      過去の行動と記憶]),
    align(center + horizon)[#text(23pt)[＋]],
    card([SNSで見える情報], [推薦された投稿\
      コメント\
      いいね・低評価の数]),
    align(center + horizon)[#text(23pt)[→]],
    card([LLMが行動を生成], [投稿・再投稿\
      コメント・評価\
      フォロー・何もしない]),
  )
  #v(16pt)
  - 行動とその理由を生成し、結果をSNS環境に反映する。
  - 行動は全体で21種類。各実験では、目的に合うものを選んで使う。
  #v(8pt)
  #note[上図は仕組みの説明。エージェントモジュールはCAMELを基盤とする。]
]

#slide[02 / 全体像][「見る → 行動する → 環境が変わる」を繰り返す][§2.1-2.6、図2][
  #grid(columns: (1fr, auto, 1fr, auto, 1fr), gutter: 10pt,
    card([① 環境サーバー], [利用者・投稿・評価・関係・履歴をデータベースで管理]),
    align(center + horizon)[#text(25pt)[→]],
    card([② 推薦システム], [誰に、どの投稿を見せるかを選ぶ]),
    align(center + horizon)[#text(25pt)[→]],
    card([③ エージェント], [見た内容と記憶を基に、行動と理由を生成]),
  )
  #align(center)[#text(16pt, fill: accent)[← 投稿・評価・フォロー関係などを更新 ←]]
  #v(13pt)
  #grid(columns: (1fr, 1fr), gutter: 14pt,
    card([④ 時間管理エンジン], [いつ、誰を活動させるかを決める。]),
    card([⑤ 大規模推論システム], [多数のLLMへの要求を非同期に処理する。]),
  )
]

#slide[02 / 推薦][推薦方式を変えると、目に入る情報が変わる][§2.3、付録D.3 式(2)-(5)][
  #set text(size: 17pt)
  #table(columns: (1fr, 1.8fr, 1.8fr),
    table.header([*環境*], [*投稿を選ぶ主な手掛かり*], [*実装の考え方*]),
    [X型], [フォロー関係、興味、投稿の新しさ、発信者の影響力], [フォロー内は人気度で順位付け。フォロー外は興味などから選ぶ。],
    [Reddit型], [高評価・低評価の数、投稿時刻], [hot score（人気度スコア）で順位付けする。],
  )
  #v(12pt)
  X型のフォロー外の推薦では、次の積でスコアを求める。
  $ "Score" = R times F times S $
  #text(15pt)[$R$：投稿の新しさ　$F$：フォロワー数に基づく係数　$S$：興味の類似度]
  #v(8pt)
  #note[興味の類似度にはTwHIN-BERTによる文章のベクトル表現を使う。現実の推薦全体を再現したものではない。]
]

#slide[02 / 推薦の数式①][X型：新しさ・発信者・興味を掛け合わせる][付録D.3 式(2)-(5)、PDF p.26][
  #set text(size: 16pt)
  #set par(leading: 0.4em, spacing: 6pt)
  #paper-eq([原論文 式(2)], $ "Score" = R times F times S $)
  #v(3pt)
  #grid(columns: (1.8fr, 1fr), gutter: 10pt, align: horizon,
    paper-eq([式(3)], $ R = ln(frac(271.8 - (t_"current" - t_"created"), 100)) $),
    [*新しさ*：現在時刻 $t_"current"$ と投稿時刻 $t_"created"$ の差を使う。],
    paper-eq([式(4)], $ F = max(1, log_1000("fan count" + 1)) $),
    [*発信者*：fan countは、投稿者のフォロワー数。],
    paper-eq([式(5)], $ S = op("cosine similarity")(E_p, E_u) $),
    [*興味*：$E_p$ は投稿、$E_u$ はプロフィールと最近の投稿のベクトル表現。],
  )
  #v(7pt)
  #note[定数と記号は原式どおり。式(3)の説明では、時刻差の単位や古い投稿の扱いは明示されていない。]
]

#slide[02 / 推薦の数式②][Reddit型：得票差と投稿時刻から人気度を計算する][§2.3 式(1)、PDF p.5][
  #set par(leading: 0.4em, spacing: 6pt)
  #paper-eq([原論文 式(1)], $
    h = log_10(max(abs(u-d), 1)) + op("sign")(u-d) dot frac(t-t_0, 45000)
  $)
  #v(10pt)
  #set text(size: 17pt)
  #table(columns: (1fr, 2.5fr), inset: 7pt,
    table.header([*記号*], [*意味*]),
    [$h$], [hot score（人気度スコア）],
    [$u$, $d$], [高評価数、低評価数],
    [$t$, $t_0$], [投稿時刻（Unix時刻・秒）、基準時刻 $t_0 = 1134028003$],
    [$op("sign")(u-d)$], [得票差が負なら −1、0なら0、正なら1を返す符号関数],
  )
  #v(10pt)
  #takeaway[得票差の大きさと符号・投稿時刻を組み合わせ、$h$ の上位 $k$ 件を推薦候補にする。]
  #v(6pt)
  #note[式は論文v3の記載どおり。$k$ は実験ごとに設定する。]
]

#slide[02 / 時間と規模][100万人が、毎回いっせいに動くわけではない][§2.5-2.6、§3.5、付録E][
  - 時間帯ごとの活動確率を24個の値で持ち、活動するエージェントを確率的に選ぶ。実データや設定値から活動の偏りを表す。
  - 基本設定では、1ステップを模擬時間の3分とする。ステップ内の投稿順を扱うため、実時間を倍率で写す別設定もある。
  #v(7pt)
  #grid(columns: (1fr, 1fr), gutter: 14pt,
    card([多様な利用者を準備], [実データ由来の中心ユーザーと、人口分布や興味などを基に生成した利用者を組み合わせる。]),
    card([計算処理を分担], [環境・エージェント・推論を分離する。非同期通信とGPUへの要求の振り分けで大規模化する。]),
  )
]

#slide[02 / 活動確率の数式][時間帯別の活動頻度を、活動確率に変換する][付録E.1 式(6)、PDF p.27][
  #set par(leading: 0.4em, spacing: 6pt)
  #set list(spacing: 8pt)
  #paper-eq([原論文 式(6)], $ P_(i j) = frac(f_(i j), max_k(f_(k j))) $)
  #v(10pt)
  #set text(size: 17pt)
  - $i$ は利用者、$j$ は1日の中の時間帯を表す。
  - $f_(i j)$ は利用者 $i$ の時間帯 $j$ における活動頻度。分母は、*同じ時間帯*における全利用者の活動頻度の最大値。
  - 分母が正なら、$P_(i j)$ は0から1の値になる。この確率を24時間帯分用意して、活動を制御する。
  #v(6pt)
  #card([説明用の計算例], [ある時間帯の活動頻度が3、同じ時間帯での最大頻度が12なら、活動確率は $3/12 = 0.25$。])
  #v(7pt)
  #note[24時間分の確率の合計を1にする定義ではない。実験によっては、履歴の代わりに指定した確率を使う。]
]

#slide[02 / 実行コスト][対応できる人数と、計算にかかる時間は別][§4.1、表2、付録H][
  #set text(size: 17pt)
  集団極性化の設定で報告された性能：
  #v(7pt)
  #table(columns: (1.6fr, 1fr, 1fr, 1fr),
    table.header([*利用者数*], [*1万人*], [*10万人*], [*100万人*]),
    [実時間／ステップ], [0.2時間], [3.0時間], [18.0時間],
    [A100 GPU数], [2台], [5台], [27台],
  )
  #v(14pt)
  - 推薦用にA100を1台使い、複数GPUでvLLMによるLLM推論を実行する。
  - 模擬時間で数分の変化でも、実際の計算には長時間かかる。大規模な実験には、計算資源と日単位の時間が必要になる。
]

#slide[03 / 実験の地図][3つの問いで、結果を読む][§3.2-3.5][
  #set text(size: 17pt)
  #table(columns: (1.1fr, 1.5fr, 2.1fr),
    table.header([*問い*], [*対象*], [*比較するもの*]),
    [現実に近いか], [情報拡散・極性化・同調], [実データとのずれ、議論前後の変化、人間の先行研究との差],
    [人数で変わるか], [X型の議論、Reddit型の反事実投稿], [意見の多様性・有用性、否定的評価への同調],
    [100万人ではどうか], [真／偽とした情報の拡散], [関連投稿の増え方、フォロー関係の変化],
  )
  #v(14pt)
  #takeaway[現実との比較と、AI集団の中で起きる現象の観測を分けて読む。]
  #v(8pt)
  #note[主な基盤モデルはLlama-3-8B-Instruct。評価にはGPT-4o-miniやGPT-4oも使用する。]
]

#slide[03 / 現実の再現①][情報拡散は「何人に、何段階で広がったか」で測る][§3.2、付録F.2][
  #grid(columns: (1fr, 1.15fr), gutter: 22pt,
    [
      #card([伝播の模式図], [#propagation-tree])
      #note[説明用。上から下へ伝播し、各点は異なる利用者とする。]
    ],
    [
      *Scale（規模）*\
      参加した利用者数。この例では6人。
      #v(8pt)
      *Depth（深さ）*\
      元投稿からの最大の段数。この例では2。
      #v(8pt)
      *Max breadth（最大幅）*\
      同じ段にいる人数の最大値。この例では3人。
    ],
  )
  #v(12pt)
  #text(16pt)[Twitter15/16の198事例（9分野、各100-700人）を使い、3指標の時間変化を実データと比較する。]
]

#slide[03 / 情報拡散の評価式][実データとのずれを、正規化RMSEで測る][付録F.2.1 式(7)と直後の毎分誤差、PDF p.31][
  #set par(leading: 0.4em, spacing: 6pt)
  #set list(spacing: 8pt)
  #paper-eq([原論文 式(7)], $
    "Normalized RMSE" = frac(
      sqrt(frac(1,n) sum_(i=1)^n (y_"simu"^i - y_"real"^i)^2),
      y_"real"^n
    )
  $)
  #v(9pt)
  #set text(size: 17pt)
  - $y_"simu"^i$、$y_"real"^i$：$i$ 分時点のシミュレーション値と実測値。規模・深さ・最大幅をそれぞれ評価する。
  - $n$：観測終了の分時刻。分母 $y_"real"^n$ は*最終時刻の実測値*。毎分の誤差を二乗平均して平方根を取り、この値で割る。
  #v(6pt)
  #text(16pt)[各分の比較では、次の正規化した絶対誤差も用いる。]
  #paper-eq([原論文 番号なし], $ frac(abs(y_"simu"^i - y_"real"^i), y_"real"^n) $)
  #v(7pt)
  #note[小さいほど実データに近い。約30％という報告値は、この正規化誤差の尺度で読む。]
]

#slide[03 / 現実の再現①・結果][広がる規模は近いが、伝播の深さは不足した][§3.2、§3.3.1 Finding 1、図4][
  #grid(columns: (1fr, 1.8fr), gutter: 20pt,
    card([正規化RMSE], [#text(33pt, weight: "bold", fill: accent)[約30％]\
      実データとの時系列のずれとして報告]),
    [
      #set text(size: 17pt)
      #table(columns: (1fr, 1.8fr),
        table.header([*指標*], [*平均曲線での傾向*]),
        [規模・最大幅], [現実と目立つ偏りがない],
        [深さ], [現実より小さい],
      )
    ],
  )
  #v(12pt)
  - 著者らは、推薦やプロフィールの単純化により、中間の利用者を介した伝播を捉えにくいと考察している。
  #note[正規化RMSEは「正答率」ではない。また平均曲線では、事例ごとの過大・過小評価が相殺される可能性がある。]
]

#slide[03 / 現実の再現②][議論をすると、慎重な意見がさらに強まった][§3.3.1 Finding 2、図5、付録F.3][
  #text(18pt)[議題：作家Helenは、失敗の危険を冒して新しい小説に挑戦すべきか。]
  #v(9pt)
  #grid(columns: (1fr, auto, 1fr), gutter: 14pt,
    card([議論前：慎重な立場], [「十分な見込みがあるなら、挑戦を検討したい」]),
    align(center + horizon)[#text(28pt)[→]],
    card([議論後：より強い慎重論], [「危険を避ける方がよい」という助言が強まる傾向]),
  )
  #note[上の発言は傾向を説明するための言い換えであり、実験の直接引用ではない。]
  #v(9pt)
  #set text(size: 17pt)
  - 196人・80ステップ。10ステップごとに、GPT-4o-miniが初期の意見との極端さを比較する。
  - 安全上の制約を除いたモデルで、より強い極性化が見られた。
  #takeaway[集団極性化：似た考えの人々が、交流後に同じ方向へさらに極端になること。]
]

#slide[03 / 現実の再現③][最初の1票で、その後の評価は変わるか][§3.3.2、図6、付録F.4.1（得点の式は番号なし、PDF p.34）][
  #set text(size: 17pt)
  #set par(leading: 0.4em, spacing: 5pt)
  #set list(spacing: 8pt)
  #text(17pt)[Reddit型環境：実コメント116,932件、生成した3,600人、40ステップ。]
  #v(7pt)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
    card([初期高評価群], [高評価を1件付ける]),
    card([対照群], [初期評価を付けない]),
    card([初期低評価群], [低評価を1件付ける]),
  )
  #v(7pt)
  #paper-eq([原論文 番号なし], $ S_i = U_i - D_i $)
  #note[$S_i$：項目 $i$ の得点。$U_i$：高評価数、$D_i$：低評価数。得点は負にもなる。]
  - コメント得点の平均と95％信頼区間を、人間の先行研究と比較した。
  - 初期高評価群は人間と近いが、初期低評価群ではLLMの得点が低い。否定的な評価への追随が強かった。
  #note[同調現象とは、他者の評価を見て自分の判断もそれに近づくこと。]
]

#slide[04 / 人数による変化①][X型の議論では、意見の多様性と有用性が増した][§3.4.1、図7、付録F.3.3][
  #align(center)[#text(26pt, weight: "bold", fill: accent)[196人 → 10,196人 → 100,196人]]
  #v(18pt)
  - 30ステップの議論後、各条件に共通する*196人の中心ユーザー*の意見を集めて比較する。
  - 人数が増えると、中心ユーザーから得られる意見が多様になり、LLMによる比較で有用性も高くなる傾向が示された。
  #v(8pt)
  #takeaway[周囲の参加者が増えると、同じ利用者の出す意見も変わる。]
  #v(9pt)
  #note[有用性はLLMによる評価。参加人数を増やせば、どの課題でも必ず質が上がると保証する結果ではない。]
]

#slide[04 / 人数による変化②・設定][反事実の投稿では、「何に同調するか」が重要][§3.4.2、付録F.4.1-F.4.2][
  #text(18pt)[通常コメントの実験とは別に、事実に反する投稿への反応を調べる。]
  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    card([実験条件], [100人・1,000人・10,000人で30ステップ。投稿を初期高評価1件・低評価1件・評価なしの3群に分ける。]),
    card([測るのはコメントの反対度], [GPT-4oがDisagree scoreを評価。\
      *1：投稿を信じて賛同*\
      *10：投稿を信じず反対*]),
  )
  #v(12pt)
  #takeaway[この実験では、反対度が高いほど、事実に反する内容を否定している。]
  #v(8pt)
  #note[人数とともに投入投稿数・推薦候補数も変更している点に注意する（本要約の補足）。]
]

#slide[04 / 人数による変化②・結果][低評価への同調が、誤りの否定を強めた][§3.4.2 Finding 5、図8、付録F.4.3・図16][
  #set text(size: 17pt)
  #table(columns: (1fr, 2.7fr),
    table.header([*条件*], [*観測された傾向*]),
    [小規模], [初期高評価・低評価・対照の3群で、反対度の差はほぼ見られない。],
    [1万人規模], [初期低評価群で反対度が高くなる。大規模条件では反対度の上昇も見られる。],
  )
  #v(14pt)
  #align(center)[#text(21pt, weight: "bold", fill: accent)[投稿への低評価 → 否定的な反応への追随 → 反事実への反対]]
  #v(13pt)
  - 著者らは、集団で誤りを指摘する*自己修正*の傾向と解釈する。
  - 同調と自己修正は、この条件では同時に起こり得る。集団が常に正しい結論へ向かうことを保証するものではない。
  #note[矢印は結果の解釈を説明する模式図であり、個々の利用者の因果経路を直接測定したものではない。]
]

#slide[05 / 100万人の観測][偽情報の方が、広く議論された][§3.5、図9-10、付録G][
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    card([設定], [X型環境に100万人を配置。技術・健康・教育・娯楽の4分野で、論文が真／偽とした情報を有名アカウントから発信する。]),
    card([観測], [偽情報の方が広く拡散した。新しいフォロー関係の可視化では、孤立した集団が生まれる傾向も見られた。]),
  )
  #v(13pt)
  - 活動確率は中心ユーザー0.1、一般ユーザー0.01。関連投稿数とフォロー関係の時間変化を追う。
  #v(7pt)
  #note[「真／偽」は実験上のラベル。拡散の深さや外部意見の遮断まで定量的に確認した実験ではない。]
]

#slide[06 / 仕組みの検証][推薦と活動時間を変えると、拡散も変わる][§4.2、付録C.2-C.3、図11-12][
  #set text(size: 17pt)
  #table(columns: (1.5fr, 2.7fr),
    table.header([*取り除く・入れ替えるもの*], [*結果*]),
    [推薦システムを除く], [多くの事例で伝播が早く止まる。密なフォロー関係を持つ集団では例外もある。],
    [埋め込みモデルを変える], [TwHIN-BERTと通常のBERTはMiniLMより良い結果。推薦で意味の関連を捉える例も示した。],
    [活動確率をすべて1にする], [活動が過剰になり、現実の拡散の時間変化を捉えにくくなる。],
  )
  #v(12pt)
  #takeaway[LLMの能力に加え、「誰が何を見るか」「いつ動くか」も結果を左右する。]
  #v(7pt)
  #note[198事例から選んだ28事例で検証。構成要素の役割を調べる、このような実験をアブレーション実験という。]
]

#slide[06 / 限界と解釈][このシミュレーションを、どこまで信じてよいか][§3.2-3.3、付録H-I][
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    card([現実との差], [プロフィールや推薦は単純化している。協調フィルタリングなどは未実装で、拡散の深さにもずれが残る。]),
    card([モデル・評価の影響], [人間と異なる同調も見られる。極性化・有用性・反対度の評価にはLLMを使っている。]),
  )
  #v(13pt)
  #set text(size: 17pt)
  - 対象はテキスト。画像・動画・音声の理解や、SNSのすべての行動には対応していない。
  - 実データの匿名化・同意・保護に配慮し、世論操作などへの悪用を防ぐ運用も必要。
  #takeaway[仮説を調べる研究基盤として有用。現実の世論予測に使うには、別途妥当性の検証が要る。]
]

#slide[07 / 結論][OASISから得られる3つの示唆][要旨、§3-5、付録H-I][
  #card([1　SNSの仕組みを含めて、AI同士の交流を調べられる], [推薦、行動、時間、関係網を組み合わせ、最大100万のエージェントに対応する。])
  #v(9pt)
  #card([2　人数を増やすと、少人数とは違う集団の傾向が現れる], [意見の多様性・有用性や、反事実投稿への同調・自己修正の傾向に違いが見られた。])
  #v(9pt)
  #card([3　人間との差も、実験の結果として読む必要がある], [一部の現実の傾向を再現できても、LLM集団をそのまま人間社会とみなすことはできない。])
]

#slide[参考文献][対象論文と、図・例の扱い][arXiv:2411.11581v3、25 Nov 2024][
  #set text(size: 16pt)
  #bibliography("ref.bib", title: none, full: true)
  #v(18pt)
  - 対象は2024年11月25日公開のv3。各ページ下部に、その版の節・図表番号を示した。
  - 数式は原論文の式(1)-(7)と番号のない評価式を掲載。式番号は原論文の番号を引き継いだ。
  - 図形で示した処理の流れや伝播は、本要約で作成した説明用の模式図。数値や実験結果と区別している。
  - 続く単語リストの例文は、OASISの内容に沿って作成した学習用の作例であり、論文の直接引用ではない。
]

// 例文は引用ではなく、OASISの内容に沿って作成した学習用の作例。
#let word-list = csv("words.csv")
#let word-rows = word-list.slice(1)
#let word-page-count = calc.ceil(word-rows.len() / 8)
#for start in range(0, word-rows.len(), step: 8) {
  slide([単語・表現], [単語リスト #(start / 8 + 1) / #word-page-count], none, [
    #set text(size: 11.5pt)
    #set par(leading: 0.45em)
    #text(10pt)[例文は学習用の作例であり、論文からの直接引用ではない。]
    #v(6pt)
    #table(
      columns: (25pt, 107pt, 108pt, 1fr, 1fr), inset: 5pt,
      fill: (x, y) => if y == 0 { green.lighten(85%) } else { white },
      table.header(..word-list.first().map(cell => strong(cell))),
      ..word-rows.slice(start, calc.min(start + 8, word-rows.len())).flatten(),
    )
  ])
}
