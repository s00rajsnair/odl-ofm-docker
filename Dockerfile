FROM gns3/ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y 
RUN apt install bash-completion software-properties-common sudo curl ssh git openjdk-8-jre nodejs npm grunt -y

COPY .bashrc /root/.bashrc

COPY OpenDaylight_Lithium /root/OpenDaylight_Lithium
COPY OFM /root/OFM

COPY sshd_config /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
RUN echo "root:controller" | chpasswd

ENTRYPOINT service ssh restart &&  cd /root && bash -i 
