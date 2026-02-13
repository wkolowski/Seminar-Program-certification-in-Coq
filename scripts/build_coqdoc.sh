#!/bin/sh

# Build a HTML page from the Coq comments using coqdoc.
coqdoc src/*v                                        \
  -d docs                                            \
  --html                                             \
  --with-header assets/header.html                   \
  --with-footer assets/footer.html                   \
  --no-lib-name                                      \
  --lib-subtitles                                    \
  --parse-comments                                   \
  --no-index

# Move the necessary assets to docs/ and rename the generated page.
cp assets/* docs/
mv docs/Seminar.html docs/index.html