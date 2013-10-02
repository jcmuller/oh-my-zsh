alias gpr="git pull --rebase"
alias gprnf="git pull --rebase --no-ff"

alias rc="rails c"

# CP aliases
alias cpnginx="sudo nginx -c /web/challengepost/config/nginx/nginx.conf"
alias cpapp="nohup bundle exec unicorn_rails -c config/unicorn/unicorn.rb &"
alias resque-workers="COUNT=2 QUEUE=* bundle exec rake resque:workers &"

alias HEAD="lwp-request -m head"
alias GET="lwp-request -m get"
alias POST="lwp-request -m post"
