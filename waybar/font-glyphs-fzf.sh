#!/usr/bin/env sh

set -eu

font_path=$(fc-match -f '%{file}\n' 'JetBrains Mono')

fc-query -f '%{charset}\n' "$font_path" |
awk '
function emit(cp,   s) {
  if (cp < 32 || cp == 127) return
  s = sprintf("%c", cp)
  if (!(cp in seen)) {
    seen[cp] = 1
    printf "%04X %s\n", cp, s
  }
}
{
  for (i = 1; i <= NF; i++) {
    split($i, r, "-")
    start = strtonum("0x" r[1])
    end = (length(r) > 1) ? strtonum("0x" r[2]) : start
    for (cp = start; cp <= end; cp++) emit(cp)
  }
}' |
fzf --prompt='glyph> ' --with-nth=2.. --preview 'printf "\n%s\n\n" {2}'
