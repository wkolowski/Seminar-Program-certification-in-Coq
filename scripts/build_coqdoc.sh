#!/bin/sh

# Create a directory in which .v files will be post-processed
# for the purpose of making them jscoq-friendly.
cp -r src/ postprocessed/

#sed -E -i 's/\(\* begin hide \*\)\nProof\.\n(.|\n)*?\n\(\* end hide \*\)/Proof.\nAdmitted./g' $(find postprocessed -name "*.v")

#sed -E -i 's/\(\* ===>(.|\n)*?\*\)\n//g' $(find postprocessed -name "*.v")

# Regexes made manually in gedit, adapted to sed by Claude Sonnet 4.5
find postprocessed -name "*.v" -exec sed -i -E ':a;N;$!ba;s/\(\* begin hide \*\)\nProof\.\n([^\*]|\*[^)])*\n\(\* end hide \*\)/Proof.\nAdmitted./g' {} +

find postprocessed -name "*.v" -exec sed -i -E ':a;N;$!ba;s/\(\* ===>[^*]*(\*[^)][^*]*)*\*\)\n//g' {} +

# Build a HTML page from the Coq comments using coqdoc.
coqdoc postprocessed/*v                              \
  -d docs                                            \
  --html                                             \
  --with-footer assets/footer.html                   \
  --no-lib-name                                      \
  --lib-subtitles                                    \
  --parse-comments                                   \
  --no-index

cp assets/coqdoc.css docs/
mv docs/Seminar.html docs/index.html

rm -rf postprocessed/

