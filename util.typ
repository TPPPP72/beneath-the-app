
#let chapter-divider-page(
  chapter-num: "",
  chapter-title: "",
  time-period: "",
  core-conflict: "",
  font: ("Inter", "Noto Sans SC", "Source Han Sans SC"),
) = {
  page(
    header: none,
    margin: (x: 3.2cm, y: 4.5cm),
  )[
    #set text(font: font, lang: "zh")
    #set par(first-line-indent: (amount: 0em, all: true),)
    
    #align(horizon)[
      #block(width: 100%)[
        #text(
          size: 11pt,
          weight: "bold",
          fill: rgb("#6b7280"),
          tracking: 0.15em,
        )[#upper(chapter-num)]
        
        #v(1.4em)
        
        #grid(
          columns: (4pt, 1fr),
          gutter: 18pt,
          rect(width: 4pt, height: 2.2em, fill: rgb("#1d4ed8"), radius: 2pt),
          align(left + horizon)[
            #text(
              size: 23pt,
              weight: "bold",
              fill: rgb("#111827"),
            )[#chapter-title]
          ],
        )
        
        #v(1em)
        
        #text(
          size: 11.5pt,
          fill: rgb("#4b5563"),
          weight: "medium",
        )[#time-period]
        
        #v(4.5em)
        
        #rect(
          width: 100%,
          fill: rgb("#f8fafc"),
          stroke: (left: 3pt + rgb("#1d4ed8")),
          inset: (x: 22pt, y: 18pt),
          radius: (right: 4pt),
        )[
          #text(
            size: 9.5pt,
            weight: "bold",
            fill: rgb("#1d4ed8"),
            tracking: 0.12em,
          )[核心矛盾]
          
          #v(0.9em)
          
          #set par(leading: 0.65em)
          #text(
            size: 10.5pt,
            fill: rgb("#334155"),
            weight: "regular",
          )[#core-conflict]
        ]
      ]
    ]
  ]
}