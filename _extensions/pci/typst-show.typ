#import "@preview/superb-pci:0.1.0": *

#show: pci.with(
$if(title)$
  title: [$title$],
$endif$
$if(author)$
  authors: (
    $for(author)$
      (
        name: "$it$",
           
      ),
    $endfor$
  ),
$endif$

$if(by-author)$
authors: (
  $for(by-author)$
  (
    name: "$it.name.literal$",
    orcid: "$it.orcid$",
    affiliations: "$for(it.affiliations/first)$it.id,$endfor$",
  )$sep$,
  $endfor$
),
$endif$
$if(by-affiliation)$
  affiliations: (
    $for(by-affiliation)$
      (id: "$it.ref$", name: "$it.name$")$sep$
    $endfor$
  ),
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(doi)$
  doi: "$doi$"
$endif$
$if(keywords)$
  keywords: (
    $for(keywords)$
      "$it$",
    $endfor$
  ),
$endif$
$if(correspondence)$
  correspondence: "$correspondence$",
$endif$
$if(section-numbering)$
  numbered_sections: $section-numbering$,
$endif$
$if(bibliography)$
  bibliography: bibliography("$bibliography$"),
$endif$
$if(pcj)$
  pcj: $pcj$,
$endif$
)

