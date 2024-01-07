#! /bin/sh

IN=$1
qpdf --decrypt --remove-restrictions --split-pages $IN split_%d.pdf
for i in split_*.pdf; do
    convert -density 600x600 $i -background white -alpha remove -alpha off ${i%.*}.png && gimp ${i%.*}.png && convert -compress jpeg -quality 80 ${i%.*}.png ${i%.*}_redacted.pdf
done
qpdf --empty --pages *_redacted.pdf -- $(echo ${IN#.*/} | sed 's/\.pdf/_redacted\.pdf/')
