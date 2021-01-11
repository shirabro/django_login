FROM centos:7
RUN yum -y update; yum clean all
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
RUN yum install -y  python3
RUN yum install -y which python3-devel gcc-gfortran.x86_64 gcc-c++-4.8.3-9.el7.x86_64 g++

RUN yum -y install python3-{pip,zmq} gcc-c++ freetype-devel

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-term
RUN yum update -y && yum -y install openssh openssh-server openssh-clients sudo initscripts

RUN echo 'root:1234' | chpasswd
RUN rm -fr /var/run/nologin

WORKDIR /django_login
COPY . /django_login/
RUN pip3 install -r requirements.txt
