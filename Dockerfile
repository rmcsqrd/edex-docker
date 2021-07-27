FROM centos:7
MAINTAINER "Rio McMahon" <rmcmahon@ucar.edu>
env HOME /root
env WORKDIR /root

RUN yum -y update; yum clean all
RUN yum install httpd -y

# install pre-reqs
RUN yum -y install sudo
RUN yum -y install wget
RUN yum -y install perl

# do awips install

COPY scripts/awips_install_local.sh ${WORKDIR}
RUN chmod 755 ${WORKDIR}/awips_install_local.sh
RUN sudo ${WORKDIR}/awips_install_local.sh --edex

# fix yum since awips install breaks it per
# https://www.unidata.ucar.edu/support/help/MailArchives/awips/msg00365.html
RUN export LD_LIBRARY_PATH=/usr/lib:/lib:/usr/lib64:/lib64

# create empty network file
RUN touch /etc/sysconfig/network

# start container by running systemd
CMD ["/usr/sbin/init"]
