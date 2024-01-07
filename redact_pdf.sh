#! /bin/sh

IN=$1
qpdf --decrypt --remove-restrictions --optimize-images --recompress-flate --compression-level=9 --split-pages $IN split_%d.pdf
for i in split_*.pdf; do
    convert -density 600x600 $i -alpha remove -alpha off ${i%.*}.png && gimp ${i%.*}.png && convert -compress jpeg -quality 75 ${i%.*}.png ${i%.*}_redacted.pdf
done
qpdf --empty --optimize-images --recompress-flate --compression-level=9 --pages *_redacted.pdf -- $(echo ${IN#.*/} | sed 's/\.pdf/_redacted\.pdf/')
