FROM centos:7
MAINTAINER "Rio McMahon" <rmcmahon@ucar.edu>
RUN yum -y update; yum clean all
RUN yum install httpd -y

ENV HOME /root
ENV WORKDIR /root

# install pre-reqs
RUN yum -y install sudo
RUN yum -y install wget
RUN yum -y install perl
RUN yum -y install less
RUN yum -y install rsync

# do awips install
RUN wget https://www.unidata.ucar.edu/software/awips2/awips_install.sh
RUN chmod 755 awips_install.sh
RUN sudo ./awips_install.sh --edex

# load in config files
COPY etc/ldmd.conf /awips2/ldm/etc/ldmd.conf
COPY etc/setup.env /awips2/edex/bin/setup.env
COPY etc/edexServiceList /etc/rc.d/init.d/edexServiceList
COPY etc/registry.xml /awips2/ldm/etc/registry.xml

# fix yum since awips install breaks it per
# https://www.unidata.ucar.edu/support/help/MailArchives/awips/msg00365.html
RUN export LD_LIBRARY_PATH=/usr/lib:/lib:/usr/lib64:/lib64

# create empty network file
RUN touch /etc/sysconfig/network

# start container by running systemd
CMD ["/usr/sbin/init"]
