FROM node:7.6
MAINTAINER anand.anand84@gmail.com
# Update and install necessary componnets
RUN apt-get update
RUN apt-get -y install xvfb
RUN apt-get -y install wget
## Install JAVA
RUN \
echo "===> add webupd8 repository..."  && \
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
apt-get update  && \
\
\
echo "===> install Java"  && \
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
\
\
echo "===> clean up..."  && \
rm -rf /var/cache/oracle-jdk8-installer  && \
apt-get clean  && \
rm -rf /var/lib/apt/lists/*

## Install Google Chrome
# RUN cd /tmp  && \
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
# dpkg -i google-chrome-stable_current_amd64.deb && \
# apt-get -y -f install

RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

COPY ./cmd.sh src/
COPY ./testfile.js src/
RUN chmod +x src/cmd.sh
RUN chmod -R 777 src/

RUN cd src/
## Install Selenium server
RUN npm install -g selenium-standalone && \
npm install -g webdriverio

#WORKDIR src/
#CMD ["./cmd.sh"]