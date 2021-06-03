HEAD(){
  echo -n -e "\e[1m $1 \e[0m  \t \t"
}

STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m ---- Done \e[0m"
  else
      echo -e "\e[31m ----Failed \e[0m"
      echo -e "\e[31m Check the log for more details ... log file is /tmp/roboshop.log"
      exit 1
  fi
}