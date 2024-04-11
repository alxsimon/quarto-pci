#import "@preview/superb-pci:0.1.0": *

#show: pci.with(
$if(title)$
  title: [$title$],
$endif$
$if(by-author)$
authors: (
  $for(by-author)$
  (
    name: "$it.name.literal$",
    $if(it.orcid)$
    orcid: "$it.orcid$",
    $endif$
    $if(it.affiliations)$
    affiliations: [$for(it.affiliations)$$it.id$$sep$,$endfor$],
    $endif$
  ),
  $endfor$
),
$endif$
$if(by-affiliation)$
  affiliations: (
    $for(by-affiliation)$
      (id: [$it.id$], name: "$it.name$"),
    $endfor$
  ),
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(doi)$
  doi: "$doi$",
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

