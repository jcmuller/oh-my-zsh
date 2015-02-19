## Add /Applications to tab completion for "open -a" and "run", which is aliased to the former.
#if [ "`uname`" = "Darwin" ];
#then
#  compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
#  compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app ~/Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
#  alias run='open -a'
#fi
export TERM=screen-256color
