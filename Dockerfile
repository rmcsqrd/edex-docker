FROM centos:7
MAINTAINER "Rio McMahon" <rmcmahon@ucar.edu>
RUN yum -y update; yum clean all
RUN yum install httpd -y

# install pre-reqs
RUN yum -y install sudo
RUN yum -y install wget
RUN yum -y install perl

# do awips install
RUN wget https://www.unidata.ucar.edu/software/awips2/awips_install.sh
RUN chmod 755 awips_install.sh
RUN sudo ./awips_install.sh --edex

# fix yum since awips install breaks it per
# https://www.unidata.ucar.edu/support/help/MailArchives/awips/msg00365.html
RUN export LD_LIBRARY_PATH=/usr/lib:/lib:/usr/lib64:/lib64

# create empty network file
RUN touch /etc/sysconfig/network

# start container by running systemd
CMD ["/usr/sbin/init"]
