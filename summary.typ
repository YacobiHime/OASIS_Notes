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
    #image("assets/bg.png", width: 100%, height: 100%, fit: "cover")
  ],
  margin: (
    top: 50pt,
    bottom: 50pt,
  ),
  numbering: "1",
  number-align: right,
)

#set text(
  size: 18pt,
)

#show heading: it => {
  set text(green.lighten(-30%), size: 32pt - 4pt * it.level)
  it
}

#set list(marker: text("・", green.lighten(-40%)), spacing: 20pt)

#place(center)[
  #v(100pt)
  = #"論文要約\n「OASIS: Open Agent Social Interaction Simulations with One Million Agents」"
  #v(20pt)
  #align(right)[
    #text(20pt)[学籍番号 名前]
  ]
]

#pagebreak()

= Reference

#bibliography("ref.bib", title: none)

#pagebreak()

= Abstract

- 従来のシナリオ特化型・小規模なLLMエージェントシミュレータの課題を解決するシステムの提案
- X（旧Twitter）やRedditなどの多様なSNSを再現可能な、汎用的かつ拡張性の高いシミュレータ「OASIS」を開発
- 最大100万人規模のLLMエージェントによる大規模な社会相互作用のシミュレーションを実現
- 情報拡散、集団極性化、同調現象（ハード効果）などの現実世界の社会現象を忠実に再現可能

#pagebreak()

= Methods

- 本論文の提案手法「OASIS」は、現実のSNS構造に基づいた5つの主要な構成要素から成り立つ
  - Environment Server: ユーザー情報、投稿、関係性を管理するデータベース
  - RecSys (推薦システム): エージェントの興味や流行に基づく情報選別
  - Agent Module: CAMELを土台とした、記憶と行動（21種類）を制御する部分
  - Time Engine: 現実の活動確率に基づく時間管理と作動
  - Scalable Inferencer: 大規模推論を可能にする非同期処理・GPU管理システム

#align(center)[
  #rect(width: 80%, height: 180pt, fill: luma(240), stroke: 1pt + gray)[
    #align(center + horizon)[
      #text(fill: gray)[図2: OASISの処理の流れ (画像省略)]
    ]
  ]
]

#pagebreak()

== Scalable Design (大規模化への工夫)

- 大規模なエージェントを動作させるための2つの重要な工夫
- Scalable Inference (大規模推論システム)
  - 非同期メッセージキューとスレッドセーフな辞書を用いた通信経路により、並行要求を処理
  - GPUリソースを管理し、推論要求を効率的に分散
- Large-scale User Generation (大規模ユーザー生成)
  - 人口統計データ（年齢、性格など）と興味関心に基づくネットワーク生成モデルを組み合わせ、最大100万人のユーザーを生成
  - 中心的なユーザーと一般ユーザーを結びつけ、スケールフリーなネットワーク特性を維持

#pagebreak()

= Experiments

検証の対象は、Xにおける情報拡散とRedditにおける同調現象、および大規模環境での偽情報拡散

== Information Propagation in X (情報拡散と集団極性化)
- 現実のXのデータセット（Twitter15/16）を使用し、情報伝播の規模と深さを比較
- ジレンマに対するエージェントの意見変化を観察し、集団極性化を評価

== Herd Effect in Reddit (同調現象)
- 現実のRedditコメントを使用し、「初期に低評価」「初期に高評価」などの条件下での反応を評価
- 反事実（偽情報）に対するエージェントの反論度合い（Disagree Score）を測定

#pagebreak()

= Results

== Xの基盤での結果
- 情報拡散の規模（Scale）と最大幅（Max Breadth）は現実世界の傾向を正確に再現
- 議論を重ねるごとに意見が極端になる「集団極性化」を確認（特に安全制限のないモデルで顕著）

== Redditの基盤での結果
- エージェントは人間よりも、初期の低評価に流されやすい（同調現象が強い）傾向がある

== Agent数の規模による影響 (Scale Effect)
- 人数が増えるほど（196人 → 数万人）、意見の多様性が増し、より役立つ回答が得られる
- 反事実に対する同調現象は少人数では起きないが、1万人規模になると明確に発生し、集団による自己修正の動きも現れる

#pagebreak()

= Results (1 Million Agents Simulation)

100万人規模での公式ニュースと偽情報（Misinformation）の拡散比較

- 偽情報の影響力は公式ニュースよりも一貫して大きい
- どちらも初期に爆発的に関連投稿が増えるが、時間経過で減少する
- 偽情報に関する投稿は後半になっても高い活動水準を維持し、持続的な影響力を持つ
- シミュレーションの過程で、エージェント間に新たな集団（クラスタ）が形成される現象を確認

#align(center)[
  #rect(width: 80%, height: 150pt, fill: luma(240), stroke: 1pt + gray)[
    #align(center + horizon)[
      #text(fill: gray)[図9: 偽情報と公式ニュースの拡散比較 (画像省略)]
    ]
  ]
]

#pagebreak()

= Ablation Studies

OASISの各構成要素の有効性を評価

- RecSys (推薦システム) の有無
  - 推薦システムがないと情報の拡散が著しく阻害され、シミュレーションが成立しにくくなる
- 埋め込みモデルの比較
  - 一般的な手法よりも、SNSに特化したTwHIN-BERTの方が適切な推薦が可能
- Temporal Feature (時間的特徴) の検証
  - 現実に基づく活動確率（時間帯ごとの活発さ）を除外すると、現実世界の伝播の傾向を正確に再現できなくなる

#pagebreak()

= Limitation & Conclusion

- OASISは様々な基盤に適応可能で、100万人規模の相互作用を支える強力な道具である
- 提案手法の限界
  - 推薦システムは高度な模倣であり、協調フィルタリングのような複雑な計算手法は未実装（現実との差異の一因）
  - ブックマーク、投げ銭、ライブ配信などの機能は未対応
  - 文章情報のみの環境であり、画像や動画の複合的な情報は未対応
  - 100万人規模のシミュレーションには数日を要するため、推論とデータベース効率の最適化が今後の課題

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
