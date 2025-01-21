FROM ubuntu:16.04

RUN apt-get clean && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM dumb
ENV PYTHONIOENCODING=utf-8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git curl software-properties-common unzip 
RUN add-apt-repository -y ppa:jblgf0/python
RUN apt-get update && add-apt-repository -y ppa:deadsnakes/ppa && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3.6 python3.6-dev
RUN curl https://bootstrap.pypa.io/pip/3.6/get-pip.py | python3.6
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y libgtk-3-dev libboost-all-dev build-essential libffi-dev gnupg wget
RUN wget -qO - https://apt.kitware.com/keys/kitware-archive-latest.asc | apt-key add -
RUN add-apt-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y cmake
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y firefox
RUN git clone https://github.com/nearautumn/EagleEye.git
WORKDIR EagleEye
RUN pip3.6 install -r requirements.txt
RUN pip3.6 install --upgrade beautifulsoup4 html5lib spry
ADD https://github.com/mozilla/geckodriver/releases/download/v0.27.0/geckodriver-v0.27.0-linux64.tar.gz /EagleEye/geckodriver.tar.gz
RUN tar -xvf geckodriver.tar.gz
RUN mv geckodriver /usr/bin/geckodriver
RUN chmod +x /usr/bin/geckodriver
RUN rm -r /EagleEye/known/
ENTRYPOINT bash /entry.sh
