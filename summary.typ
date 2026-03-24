#import "@preview/grayness:0.4.1": image-transparency

#set page(
  paper: "presentation-16-9",
  footer: context [
	#if counter(page).get().first() > 1 [
	  #align(center)[
		#line(length: 90%, stroke: 1pt + gray)
		#v(12pt, weak: true)
		#text(12pt)[
		  工業英語 論文要約「OASIS: Open Agent Social Interaction Simulations with One Million Agents」
		]
	  ]\
	  #place(
		bottom + right,
		dx: 15pt,
		dy: -15pt,
	  )[
		#text(size: 16pt, [#{ counter(page).get().first() - 1 }])
	  ]
	]
  ],
  background: [
	#image-transparency(
	  read("assets/bg.png", encoding: none),
	  alpha: 0.3,
	  width: 100%,
	  height: 100%,
	)
  ],
  margin: (
	top: 50pt,
	bottom: 50pt,
  ),
  numbering: "1",
  number-align: right,
)

#set text(
  font: "Hack Nerd Font",
  size: 18pt,
)

#show heading: it => {
  set text(green.lighten(-30%), size: 32pt - 4pt * it.level)
  it
}

#set list(marker: text("・", green.lighten(-40%)), spacing: 20pt)

#place(center)[
  #v(100pt)
  = #"論文要約
  「OASIS: Open Agent Social Interaction Simulations with One Million Agents」"
  #v(20pt)
  #align(right)[
	#text(20pt)[学籍番号 名前] // 必要に応じて書き換えてください
  ]
]

#pagebreak()

= Reference

#bibliography("ref.bib", title: none)

#pagebreak()

= Abstract

- 従来のシナリオ特化型・小規模なLLMエージェントシミュレータの課題を解決するシステムの提案 [cite: 59, 60]
- X（旧Twitter）やRedditなどの多様なSNSを再現可能な、汎用的かつ拡張性の高いシミュレータ「OASIS」を開発 [cite: 61, 64]
- 最大100万人規模のLLMエージェントによる大規模な社会相互作用のシミュレーションを実現 [cite: 63]
- 情報拡散、集団極性化、同調現象（ハード効果）などの現実世界の社会現象を忠実に再現可能 [cite: 65]

#pagebreak()

= Methods

- 本論文の提案手法「OASIS」は、現実のSNS構造に基づいた5つの主要コンポーネントから構成される [cite: 121]
  - Environment Server: ユーザー情報、投稿、関係性を管理するデータベース [cite: 202]
  - RecSys (推薦システム): エージェントの興味やトレンドに基づく情報フィルタリング [cite: 213, 216]
  - Agent Module: CAMELをベースとした、記憶と行動（21種類）を制御するモジュール [cite: 241, 246]
  - Time Engine: 現実の活動確率に基づく時間管理とアクティブ化 [cite: 254]
  - Scalable Inferencer: 大規模推論を可能にする非同期処理・GPU管理システム [cite: 263, 264]

#align(center)[
  // Figure 2: The workflow of OASIS を配置
  #image("assets/fig2_workflow.png", height: 200pt)
]

#pagebreak()

== Scalable Design (大規模化への工夫)

- 大規模なエージェントを動作させるための2つの重要な工夫 [cite: 261]
- Scalable Inference (スケーラブルな推論)
  - 非同期メッセージキューとスレッドセーフな辞書を用いた通信チャネルにより、並行リクエストを処理 [cite: 1013, 1014]
  - GPUリソースを管理し、推論リクエストを効率的に分散 [cite: 1019]
- Large-scale User Generation (大規模ユーザー生成)
  - 人口統計データ（年齢、性格など）と興味関心に基づくネットワーク生成モデルを組み合わせ、最大100万人のユーザーを生成 [cite: 266, 267]
  - コアユーザーと一般ユーザーをリンクさせ、スケールフリーなネットワーク特性を維持 [cite: 268]

#pagebreak()

= Experiments

検証タスクは、Xにおける情報拡散とRedditにおける同調現象、および大規模環境での偽情報拡散 [cite: 278, 282, 528]

== Information Propagation in X (情報拡散と集団極性化)
- 現実のXのデータセット（Twitter15/16）を使用し、情報伝播の規模と深さを比較 [cite: 288, 301]
- ジレンマに対するエージェントの意見変化を観察し、集団極性化を評価 [cite: 408, 410]

== Herd Effect in Reddit (同調現象)
- 現実のRedditコメントを使用し、「初期に低評価(down-treated)」「初期に高評価(up-treated)」などの条件下での反応を評価 [cite: 295, 297]
- 反事実（偽情報）に対するエージェントの反論度合い（Disagree Score）を測定 [cite: 309]

#pagebreak()

= Results

== Xプラットフォームでの結果
- 情報拡散の規模（Scale）と最大幅（Max Breadth）は現実世界の傾向を正確に再現 [cite: 313]
- 議論を重ねるごとに意見が極端になる「集団極性化」を確認（特に安全制限のないモデルで顕著） [cite: 406, 416]

== Redditプラットフォームでの結果
- エージェントは人間よりも、初期の低評価に流されやすい（同調現象が強い）傾向がある [cite: 460, 463]

== Agent数の規模による影響 (Scale Effect)
- 人数が増えるほど（196人 → 数万人）、意見の多様性が増し、より役立つ回答が得られる [cite: 471, 472]
- 反事実に対する同調現象は少人数では起きないが、1万人規模になると明確に発生し、集団による自己修正の動きも現れる [cite: 503, 505, 507]

#pagebreak()

= Results (1 Million Agents Simulation)

100万人規模での公式ニュースと偽情報（Misinformation）の拡散比較 [cite: 528, 532]

- 偽情報の影響力は公式ニュースよりも一貫して大きい [cite: 539, 542]
- どちらも初期に爆発的に関連投稿が増えるが、時間経過で減少する [cite: 543, 544]
- 偽情報に関する投稿は後半になっても高い活動レベルを維持し、持続的な影響力を持つ [cite: 545]
- シミュレーションの過程で、エージェント間に新たなコミュニティ（クラスタ）が形成される現象を確認 [cite: 547, 548]

#align(center)[
  // Figure 9: 偽情報と公式ニュースの拡散比較グラフ を配置
  #image("assets/fig9_misinfo.png", height: 180pt)
]

#pagebreak()

= Ablation Studies

OASISの各コンポーネントの有効性を評価 [cite: 573]

- RecSys (推薦システム) の有無
  - 推薦システムがないと情報の拡散が著しく阻害され、シミュレーションが成立しにくくなる [cite: 575, 803]
- 埋め込みモデルの比較
  - 一般的なBERT等よりも、SNSに特化したTwHIN-BERTの方が適切な推薦が可能 [cite: 577, 804]
- Temporal Feature (時間的特徴) のアブレーション
  - 現実に基づく活動確率（時間帯ごとの活発さ）を除外すると、現実世界の伝播パターンを正確に再現できなくなる [cite: 578, 826]

#pagebreak()

= Limitation & Conclusion

- OASISは様々なプラットフォームに適応可能で、100万人規模の相互作用をサポートする強力なツールである [cite: 582, 583]
- 提案手法の限界
  - RecSys（推薦システム）はハイレベルな模倣であり、協調フィルタリングのような複雑なアルゴリズムは未実装（現実との差異の一因） [cite: 1451, 1453]
  - ブックマーク、投げ銭、ライブ配信などの機能は未対応 [cite: 1456]
  - テキストベースのみの環境であり、画像や動画のマルチモーダル機能は未サポート [cite: 1457]
  - 100万人規模のシミュレーションには数日を要するため、推論とデータベース効率の最適化が今後の課題 [cite: 1459, 1460]

#pagebreak()

= Word List

#let word_list = csv("words.csv")

#{
  set text(size: 12pt)
  table(
	columns: 5,
	..word_list.flatten(),
  )
}