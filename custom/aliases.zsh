alias gpr="git pull --rebase"
alias gprnf="git pull --rebase --no-ff"
alias grm="git ls-files --deleted | xargs git rm"
alias gitl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an, %cr)%Creset'\'' --abbrev-commit --date=relative'
alias gitls='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an, %cr)%Creset'\'' --abbrev-commit --date=relative --max-count=5'

alias rc="rails c"

alias HEAD="lwp-request -m head"
alias GET="lwp-request -m get"
alias POST="lwp-request -m post"

alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

alias bumall='for i in /web/*; do (echo "$i:"; cd $i && bundle update models); done'
alias gprall='for i in /web/*; do (echo "$i:"; cd $i && gpr); done'
alias  biall='for i in /web/*; do (echo "$i:"; cd $i && (bundle check || bundle install)); done'
