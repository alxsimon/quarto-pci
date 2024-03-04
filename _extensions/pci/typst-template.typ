
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  volume: "",
  doi: "",
  cols: 1,
  margin: (x: 15mm, y: 15mm),
  paper: "a4",
  lang: "en",
  region: "US",
  font: "Open Sans",
  fontsize: 10.5pt,
  bib_file: none,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
    // Configuration
  set document(
    title: title,
    author: authors.join(", "),
  )
  set page(
    paper: paper,
    margin: margin,
  )
  set text(
    font: font,
    size: fontsize,
    lang: lang,
    region: region,
    hyphenate: false,
  )
  set par(
    justify: true,
  )

  set heading(numbering: "1.")

  show heading.where(level: 1): it => [
    #set align(center)
    #set text(size: 12pt)
    #block(above: 2em, below: 1em)[
      #if it.numbering != none {counter(heading).display() }#it.body
    ]
  ]
  show heading.where(level: 2): it => [
    #set text(size: 10.5pt)
    #block(above: 2em)[
      #if it.numbering != none {counter(heading).display() }#it.body
    ]
  ]
  show heading.where(level: 3): it => [
    #set text(size: 10.5pt, style: "italic", weight: "regular")
    #block(above: 2em)[
      #if it.numbering != none {counter(heading).display() }#it.body
    ]
  ]

  show link: set text(fill: blue)

  // Figure settings
  // set figure.caption(position: top)
  show figure: set block(width: 80%)
  show figure.caption: it => [
    // #block(width: 80%)[
      #set align(left)
      *#it.supplement #it.counter.display(it.numbering)* -- #it.body
    // ]
  ]

  set bibliography(title: "References")
  
  // usefull functions
  let display_authors(authors) = {
    set text(size: 16pt)
    // Display the authors list.
    // let names = authors.map(author => author.name)
    let author-string = if authors.len() == 2 {
      authors.join(" and ")
    } else {
      authors.join(", ", last: ", and ")
    }
    author-string
  }

  let display_abstract(abstract) = {
      text(size: 20pt, weight: "bold")[Abstract]
      linebreak()
      if abstract == none {
        lorem(200)
      } else {
        abstract
      }
  }

  let generate_header(authors) = {
    let header_authors = if authors.len() == 1 {
      authors.first()
    } else if authors.len() == 2 {
      authors.join(" and ")
    } else {
      authors.first() + " et al."
    }
    layout(sizes => {
      align(center,
        block(width: sizes.width + 40pt)[
          #set text(blue)
          #header_authors
          #h(1fr)
          #counter(page).display()
          #box(line(length: 100%, stroke: .5pt + blue))
        ])
    })
  }

  let generate_footer(volume, doi) = {
    layout(sizes => {
      align(center,
        block(width: sizes.width + 40pt)[
          #box(line(length: 100%, stroke: .5pt + blue))
          #set text(blue)
          Peer Community Journal, #volume
          #h(1fr)
          #link(doi)
        ])
    })
  }

  // =========================
  // Document

  image("pci_logos/logo_PDF_evolbiol.jpg", width: 100%)
  v(1cm)

  table(
    align: (right, left),
    column-gutter: 10mm,
    columns: (5cm, 1fr),
    stroke: none,
    inset: 0pt,
    [
      #set par(justify: false) 
      #set text(9pt)
      *Research article*
      #v(5mm)
      *Published*\
      2024-01-01
      #v(5mm)
      *Cite as*\
      #lorem(30)
      #v(5mm)
      *Correspondence*\
      #link("mailto:foobar@barfoo.com")[foobar\@barfoo.com]
      #v(5mm)
      *Peer-review*\
      Peer reviewed and recommended by PCIXXX
      #v(5mm)
      #image("CC_logos/by.svg", width: 40%)
      This article is licensed under the Creative Commons Attribution 4.0 License.
    ],
    [
      #text(size: 20pt, weight: "bold")[
        #title
      ]

      #display_authors(authors)

      #text(size: 14pt)[#volume]

      #text(size: 12pt)[#link(doi)]

      #display_abstract(abstract)
    ]
  )
  
  pagebreak()
  set page(
    margin: 1in,
    header: generate_header(authors),
    footer: generate_footer(volume, doi),
  )
  set par(first-line-indent: 4mm)
  doc

  // Display bibliography.
  // if bib_file != none {
  //   set par(first-line-indent: 0pt)
  //   set block(spacing: .65em)
  //   bibliography(
  //     bib_file,
  //     title: "References",
  //     style: "peer-community-journal-pci_Zotero.csl",
  //   )
  // }
  // show bibliography()
}
  // set page(
  //   paper: paper,
  //   margin: margin,
  //   numbering: "1",
  // )
  // set par(justify: true)
  // set text(lang: lang,
  //          region: region,
  //          font: font,
  //          size: fontsize)
  // set heading(numbering: sectionnumbering)

  // if title != none {
  //   align(center)[#block(inset: 2em)[
  //     #text(weight: "bold", size: 1.5em)[#title]
  //   ]]
  // }

  // if authors != none {
  //   let count = authors.len()
  //   let ncols = calc.min(count, 3)
  //   grid(
  //     columns: (1fr,) * ncols,
  //     row-gutter: 1.5em,
  //     ..authors.map(author =>
  //         align(center)[
  //           #author.name \
  //           #author.affiliation \
  //           #author.email
  //         ]
  //     )
  //   )
  // }

  // if date != none {
  //   align(center)[#block(inset: 1em)[
  //     #date
  //   ]]
  // }

  // if abstract != none {
  //   block(inset: 2em)[
  //   #text(weight: "semibold")[Abstract] #h(1em) #abstract
  //   ]
  // }

  // if toc {
  //   block(above: 0em, below: 2em)[
  //   #outline(
  //     title: auto,
  //     depth: none
  //   );
  //   ]
  // }

  // if cols == 1 {
  //   doc
  // } else {
  //   columns(cols, doc)
  // }
// }
