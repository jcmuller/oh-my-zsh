# Disclaimer: it should work in bash as is. It was developed on zsh, though
# (hence the filename)
# By: Juan C. Muller, ChallengePost, 2011

# CP aliases
alias cpnginx="sudo nginx -c /web/challengepost/config/nginx/nginx.conf"
alias cpapp="nohup bundle exec unicorn_rails -c config/unicorn/unicorn.rb &"
alias resque-workers="COUNT=2 QUEUE=* bundle exec rake resque:workers &"

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
    PREFIX="Checking for "
  else
    PREFIX="             "
  fi
  printf "$PREFIX %-12s [${txtred}down${txtrst}]\n" $1
}

__cpprocess() {
  echo $(cat log/unicorn_$(pwd | sed -e 's/.*\///').pid)
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

  echo "\nChecking for specific services...\n"
  for i in challengepost challenges home
  do
    echo "Checking for ${i}"

    file="/web/$i/log/unicorn_${i}.pid"
    if [[ -e "${file}" ]]
    then
      pid=$(cat ${file})
      if [[ -n "`ps -o pid= -p $pid`" ]]
      then
        __it_is_up "unicorn..." 1
      else
        __it_is_down "unicorn..." 1
        down+="${i}:unicorn"
      fi
    else
      __it_is_down "unicorn..." 1
      down+="${i}:unicorn"
    fi

    file="/web/$i/config/sunspot.yml"
    if [[ -e "$file" ]]
    then
      port=$(sed -ne '/development:/,/^\s*$/p' $file | fgrep "port: " | head -1 | sed -e 's/port: //' -e 's/ //g')
      port="-Djetty.port=$port"
      if [[ -n "`ps -eo pid=,command= | fgrep -- $port | fgrep -ve fgrep`" ]]
      then
        __it_is_up "solr..." 1
      else
        __it_is_down "solr..." 1
        down+="${i}:solr"
      fi
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

