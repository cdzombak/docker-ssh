FROM ubuntu:jammy
MAINTAINER Chris Dzombak <chris@dzombak.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl

RUN echo "deb http://archive.ubuntu.com/ubuntu jammy main universe" > /etc/apt/sources.list
RUN apt-get -y update
# socat can be used to proxy an external port and make it look like it is local
RUN apt-get -y install ca-certificates socat openssh-server supervisor rpl pwgen
RUN mkdir /var/run/sshd
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf

EXPOSE 22

# Ubuntu by default only allows non-password-based root login.
# We disable that but also create an .ssh dir so you can copy in your key.
# NOTE: This is not a robust setup security-wise, and consequently
# we recommend against exposing this container publicly.
RUN rpl "PermitRootLogin without-password" "PermitRootLogin yes" /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN chmod o-rwx /root/.ssh

# Run any additional tasks here that are too tedious to put in this dockerfile directly.
ADD setup.sh /setup.sh
RUN chmod 0700 /setup.sh
RUN /setup.sh
RUN rm /setup.sh

# Called on container start - will run supervisor.
ADD start.sh /start.sh
RUN chmod 0700 /start.sh
CMD /start.sh
