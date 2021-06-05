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

CREATE_ROBOSHOP_USER() {
HEAD "Add RoboShop App User\t\t"
  id roboshop &>>/tmp/roboshop.log
  if [ $? -eq 0 ]; then
    echo User is already there, So Skipping the User creation &>>/tmp/roboshop.log
    STAT $?
  else
    useradd roboshop &>>/tmp/roboshop.log
    STAT $?
  fi
}