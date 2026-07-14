#set page(
  paper: "a4",
  margin: (x: 3cm, y: 3.5cm),
  
  header: context {
    let page-num = counter(page).get().first()
    if page-num > 2 {
      let elems = query(heading.where(level: 1))
      if elems.len() > 0 {
        let current-chapter = elems.last().body
        grid(align(left)[#text(size: 9pt, fill: rgb("#888888"))[计算机软硬件演化编年史]])
        v(-0.4em)
        line(length: 100%, stroke: 0.5pt + rgb("#e5e7eb"))
      }
    }
  },
  
  footer: context {
    let page-num = counter(page).get().first()
    if page-num > 2 {
      let display-num = page-num - 2
      align(center)[
        #text(size: 9pt, fill: rgb("#9ca3af"))[#display-num]
      ]
    }
  },
)

#set text(
  font: ("Inter", "Noto Sans SC", "Source Han Sans SC"),
  size: 10.5pt,
  fill: rgb("#1f2937"),
)

#set par(
  justify: true,
  leading: 0.8em,
  spacing: 1.5em,
)
#show heading: it => {
  let color = if it.level == 1 { rgb("#111827") } else { rgb("#374151") }
  let size = (1.8em, 1.4em, 1.15em, 1em).at(it.level - 1, default: 1em)
  
  set text(fill: color, weight: "bold")
  block(
    above: 2em,
    below: 1em,
    sticky: true,
  )[
    #it.body
    #if it.level == 1 {
      v(0.4em)
      line(length: 100%, stroke: 1pt + rgb("#f3f4f6"))
    }
  ]
}

#show link: set text(fill: rgb("#1d4ed8"))

#show raw: set text(
  font: ("Fira Code", "JetBrains Mono", "Source Han Sans HW SC", "Consolas"),
  size: 9pt,
)

#show raw.where(block: true): it => {
  block(
    fill: rgb("#f8fafc"),
    inset: 12pt,
    radius: 6pt,
    width: 100%,
    stroke: 1pt + rgb("#e2e8f0"),
    it,
  )
}

#show raw.where(block: false): it => {
  box(
    fill: rgb("#f1f5f9"),
    inset: (x: 4pt, y: 0pt),
    outset: (y: 3pt),
    radius: 3pt,
    baseline: 0%,
    it,
  )
}