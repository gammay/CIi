
# sync sleep
sleep 30

# install tomcat 7
sudo apt-get -y install tomcat7 

# install mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv XXXX
 echo 'deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org

