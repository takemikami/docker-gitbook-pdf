FROM centos:centos7
RUN yum -y update

# install nodejs, calibre, japanese fonts
ARG NODEJS_VERSION=v9.3.0
RUN yum -y install wget \
 && yum -y groupinstall "X Window System" \
 && yum -y install xorg-x11-server-Xvfb libXcomposite ipa-gothic-fonts ipa-mincho-fonts ipa-pgothic-fonts ipa-pmincho-fonts \
 && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()" \
 && curl -o /tmp/node-${NODEJS_VERSION}-linux-x64.tar.gz http://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.gz \
 && cd /opt && tar zxf /tmp/node-${NODEJS_VERSION}-linux-x64.tar.gz \
 && ln -s /opt/node-${NODEJS_VERSION}-linux-x64/bin/node /usr/bin/node \
 && ln -s /opt/node-${NODEJS_VERSION}-linux-x64/bin/npm /usr/bin/npm \
 && npm install -g yarn \
 && ln -s /opt/node-${NODEJS_VERSION}-linux-x64/bin/yarn /usr/bin/yarn \
 && rm /tmp/node-${NODEJS_VERSION}-linux-x64.tar.gz
