FROM ubuntu:latest
ENV USER jenkins
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get install -y maven && \
    apt-get install -y git && \
    apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN useradd -m $USER
RUN adduser $USER sudo
RUN echo $USER:$USER | chpasswd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN service ssh restart
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
