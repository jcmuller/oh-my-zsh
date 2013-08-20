# Disclaimer: it should work in bash as is. It was developed on zsh, though
# (hence the filename)
# By: Juan C. Muller, ChallengePost, 2011

# CP aliases
alias cpnginx="sudo nginx -c /web/platform/config/nginx/nginx.conf"
alias cpapp="nohup bundle exec unicorn -c config/unicorn/unicorn.rb -D"
alias resque-workers="COUNT=2 QUEUE=* bundle exec rake resque:workers &"
alias cpstart=cpapp
alias ci="(cd ~platform; build/schedule_build build)"

# Colors
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtrst='\e[0m'    # Text Reset

# Pseudo private help functions
__it_is_up() {
  if [[ -z "$2" ]]
  then
    PREFIX="Checking for"
  else
    PREFIX="            "
  fi
  printf "$PREFIX %-12s [${txtgrn}up${txtrst}]\n" "$1"
}

__it_is_down() {
  if [[ -z "$2" ]]
  then
    PREFIX="Checking for"
  else
    PREFIX="            "
  fi
  printf "$PREFIX %-12s [${txtred}down${txtrst}]\n" $1
}

__cpprocess() {
  echo $(cat log/unicorn_$(pwd | sed -e 's/.*\///').pid)
}

__cpchecksolr() {
  file="/web/${1}/config/sunspot.yml"

  if [[ -e "$file" ]]
  then
    port=$(sed -ne '/development:/,/^\s*$/p' $file | fgrep "port: " | head -1 | sed -e 's/port: //' -e 's/ //g')
    port="-Djetty.port=$port"

    [[ -n "`ps -eo pid=,command= | fgrep -- $port | fgrep -ve fgrep`" ]] && echo true && return
  fi

  echo false
}

__cpcheckunicorn() {
  file="/web/$1/log/unicorn_${1}.pid"
  if [[ -e "${file}" ]]
  then
    pid=$(cat ${file})
    [[ -n "$(ps -o pid= -p $pid)" ]] && echo true && return
  fi

  echo false
}

# Utils

# Check the status of all our utils. Solr and unicorn are app specific
cpcheckstatus() {
  utils=(nginx memcached redis mysql)
  down=()

  echo "Checking for global services...\n"

  for i in $utils
  do
    if [[ -n "`ps -eo pid=,command= | fgrep -e \"$i\" | fgrep -ve fgrep`" ]]
    then
      __it_is_up "$i..."
    else
      __it_is_down "$i..."
      down+=$i
    fi
  done

  apps=(platform)

  echo "\nChecking for specific services...\n"
  for i in $apps
  do
    echo "Checking for ${i}"

    if [[ $(__cpcheckunicorn $i) == true ]]
    then
      __it_is_up "unicorn..." 1
    else
      __it_is_down "unicorn..." 1
      down+="${i}:unicorn"
    fi

    if [[ $(__cpchecksolr $i) == true ]]
    then
      __it_is_up "solr..." 1
    else
      __it_is_down "solr..." 1
      down+="${i}:solr"
    fi
  done

  [[ -n $down ]] && echo "\nUtils down: $down"
}

# Restart unicorn
cprestart() {
  cpstop
  sleep 5
  cpapp
}

# Stop unicorn
cpstop () {
  kill $(__cpprocess)
}

# Check if unicorn is running
cprunning () {
  ps -p $(__cpprocess)
}

