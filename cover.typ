#place(top + left, dx: -3cm, dy: -3.5cm)[
  #rect(width: 210mm, height: 12pt, fill: rgb("#1d4ed8"))
]

#align(left + horizon)[
  #text(fill: rgb("#1d4ed8"), weight: "bold", size: 14pt)[
    TECHNICAL GUIDE
  ]
  #v(1em)
  #text(size: 44pt, weight: "bold", fill: rgb("#111827"))[
    计算机软硬件演化编年史
  ]
  #v(0.5em)
  #text(size: 18pt, fill: rgb("#4b5563"))[
    追溯微架构、操作系统、编译器与异构计算的协同演进
  ]
  #v(2em)
  #line(length: 20%, stroke: 2pt + rgb("#e5e7eb"))
]

#align(bottom + left)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 2em,
    row-gutter: 1em,
    [#text(weight: "bold")[版本]], [#text(fill: rgb("#374151"))[v1.0.0]],
  )
  #v(1.5cm)
  #text(size: 9pt, fill: rgb("#9ca3af"))[
    © 2026 Shengxin Pei. Licensed under CC BY-NC-SA 4.0
  ]
]