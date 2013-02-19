alias GET="lwp-request -m get"
alias HEAD="lwp-request -m head"
alias POST="lwp-request -m post"

alias b="nocorrect bundle"
alias be="b exec"
alias bec="be cucumber"
alias ber="be rspec"
alias bes="be spork"
alias besc="bes cucumber"
alias besr="bes rspec"
alias bi="b install"
alias biall='for i in /web/*; do (echo "$i:"; cd $i && (b check || b)); done'
alias bu="b update"
alias bum="bu models"
alias bumall='for i in /web/*; do (echo "$i:"; cd $i && bum); done'

alias gitl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an, %cr)%Creset'\'' --abbrev-commit --date=relative'
alias gitls='gitl --max-count=5'
alias gpr="git pull --rebase"
alias gprall='for i in /web/*; do (echo "$i:"; cd $i && gpr); done'
alias gprnf="gpr --no-ff"
alias grm="git ls-files --deleted | xargs git rm"
alias gs='git status'
alias gst='gs'
alias push='git push'
alias gcv='git commit -v'
alias gca='gcv -a'

alias spork="nocorrect spork"
alias rspec="nocorrect rspec"

alias rc="rails c"

alias zeus="nocorrect zeus"
alias z="zeus"
alias zs="z server"
alias zc="z console"
alias zr="z rake"
alias zs="z rspec"
