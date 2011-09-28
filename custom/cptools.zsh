# Disclaimer: it should work in bash as is. It was developed on zsh, though
# (hence the filename)
# By: Juan C. Muller, ChallengePost, 2011

# CP aliases
alias cpnginx="sudo nginx -c /web/challengepost/config/nginx/nginx.conf"
alias cpapp="nohup bundle exec unicorn_rails -c config/unicorn/unicorn.rb &"
alias resque-workers="COUNT=2 QUEUE=* bundle exec rake resque:workers &"

# Pseudo private help functions

__it_is_up() {
  echo " [\e[0;32mup\e[0;37m]"
}

__it_is_down() {
  echo " [\e[0;31mdown\e[0;37m]"
}

__cpprocess() {
  echo $(cat log/unicorn_$(pwd | sed -e 's/.*\///').pid)
}

# Utils

# Check the status of all our utils. Solr and unicorn are app specific
cpcheckstatus() {
  utils=(nginx memcached redis mysql)
  down=()

  for i in $utils
  do
    echo -n "Checking for $i..."
    if [[ -n "`ps -eo pid=,command= | fgrep -e \"$i\" | fgrep -ve fgrep`" ]]
    then
      __it_is_up
    else
      __it_is_down
      down+=$i
    fi
  done

  for i in challengepost challenges home
  do
    echo "Checking for ${i}"

    echo -n "  unicorn..."
    file="/web/$i/log/unicorn_${i}.pid"
    if [[ -e "${file}" ]]
    then
      pid=$(cat ${file})
      if [[ -n "`ps -o pid= -p $pid`" ]]
      then
        __it_is_up
      else
        __it_is_down
        down+="${i}:unicorn"
      fi
    else
      __it_is_down
      down+="${i}:unicorn"
    fi

    echo -n "  solr..."
    file="/web/$i/config/sunspot.yml"
    if [[ -e "$file" ]]
    then
      # This is assuming that the first port entry belongs to the development
      # environment
      port=$(fgrep "port:" $file | head -1 | sed -e 's/port: //' -e 's/ //g')
      port="-Djetty.port=$port"
      if [[ -n "`ps -eo pid=,command= | fgrep -- $port | fgrep -ve fgrep`" ]]
      then
        __it_is_up
      else
        __it_is_down
        down+="${i}:solr"
      fi
    else
      __it_is_down
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

