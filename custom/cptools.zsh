__it_is_up() {
  echo " [\e[0;32mup\e[0;37m]"
}

__it_is_down() {
  echo " [\e[0;31mdown\e[0;37m]"
}

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

    utils=(solr)

    for j in $utils
    do
      echo -n "  ${j}..."
      if [[ -n "`ps -eo pid=,command= | fgrep -e \"$i\" | fgrep -e \"$j\" | fgrep -ve fgrep`" ]]
      then
        __it_is_up
      else
        __it_is_down
        down+="${i}:${j}"
      fi
    done

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
  done

  [[ -n $down ]] && echo "\nUtils down: $down"
}

cprestart() {
  kill -USR2 $(ps -ef | grep -i 'unicorn_rails master' | awk 'NR==1 {print $2}')
}

cpstop () {
  kill $(ps -ef | grep -i 'unicorn_rails master' | awk 'NR==1 {print $2}')
}

