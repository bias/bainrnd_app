#!/usr/bin/env bash
for d in app/views/*; do
  for f in $d/*.erb; do 
    #command echo -e "html2haml $f |> $d/$(basename "$f" .erb).haml"
    #command html2haml $f |> $(basename "$f" .erb).haml 
    command echo -e "rm $f"
    command rm $f 
  done
done
