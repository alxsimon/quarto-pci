$if(citations)$
$if(bibliographystyle)$
#set bibliography(
  style: "$bibliographystyle$",
)
$else$
#set bibliography(
  style: "peer-community-journal-pci_Zotero.csl"
)
$endif$
$if(bibliography)$
#[
  #set par(first-line-indent: 0pt)
  #set block(spacing: .65em)
  #bibliography(
    $for(bibliography)$"$bibliography$"$sep$,$endfor$,
    title: "References",
  )
]
$endif$
$endif$
