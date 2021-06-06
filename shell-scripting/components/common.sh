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

FIX_APP_PERMISSION() {
  HEAD "Fixing app permissions to app content" &>>/tmp/roboshop.log
  chown roboshop:roboshop /home/roboshop -R
}

INSTALL_APPLICATION() {
HEAD "Downloading the $1 application from git hub"
curl -s -L -o /tmp/$1.zip "https://github.com/roboshop-devops-project/$1/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Unzipping the Catalogue application"
cd /home/roboshop && rm -rf $1 && unzip -o /tmp/$1.zip &>>/tmp/roboshop.log && mv $1-main $1
STAT $?

HEAD "Installing the nodejs dependent application"
cd /home/roboshop/$1 && npm install --unsafe-perm &>>/tmp/roboshop.log
STAT $?

}
