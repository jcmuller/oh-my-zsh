PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/Development/OSS/pianobar-scripts:/var/lib/gems/1.8/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/X11/sbin"
export PATH

#export EDITOR="mvim -f"
export EDITOR="/usr/local/bin/vim"
#export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
export NODE_PATH=/usr/local/lib/node

## Add /Applications to tab completion for "open -a" and "run", which is aliased to the former.
#if [ "`uname`" = "Darwin" ];
#then
#  compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
#  compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app ~/Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
#  alias run='open -a'
#fi

alias gs='git status' #You're welcome, Mr. Allison
alias push='git push' #You're welcome, Mr. Allison

