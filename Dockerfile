# Fetch ubuntu 16.04 LTS docker image
FROM ubuntu:16.04

#Make a copy of ubuntu apt repository before modifying it. 
RUN mv /etc/apt/sources.list /sources.list
#Now change the default ubuntu apt repositry, which is VERY slow, to another mirror that is much faster. It assumes the host already has created a sources.list.
COPY sources.list /etc/apt/sources.list

#uncomment this line to find the fastest ubuntu repository at the time. Probably overkill, so disabling for now
#Note that this functionality is untested and might need debugging a bit.

# Update apt, and install Java + curl + wget on your ubuntu image.
RUN \
  apt-get update && \
  apt-get install -y curl vim wget maven expect git zip unzip openssh-server && \
  apt-get install -y openjdk-8-jdk 

RUN \
  apt-get install -y python && \
  apt-get install -y python-pip

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# Download and setup Apache Storm
RUN curl -s "http://mirrors.advancedhosters.com/apache/storm/apache-storm-1.0.6/apache-storm-1.0.6.tar.gz" | tar -xz -C /usr/local/
RUN ln -s /usr/local/apache-storm-1.0.6 /usr/local/storm


ENV STORM_HOME /usr/local/storm
ENV PATH="/usr/local/storm/bin:${PATH}"

# Make vim nice
RUN echo "set background=dark" >> ~/.vimrc


#for MP4 python version
RUN echo | ssh-keygen -P '' 
RUN touch /root/.ssh/config 
RUN cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
COPY sshd_config /etc/ssh/sshd_config 
COPY postsetup.sh /etc/ssh/postsetup.sh
RUN bash /etc/ssh/postsetup.sh
RUN service ssh start && ssh -o StrictHostKeyChecking=no root@localhost
RUN PATH="/usr/local/storm/bin:${PATH}"
