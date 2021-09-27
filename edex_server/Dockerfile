FROM centos:7
MAINTAINER "Rio McMahon" <rmcmahon@ucar.edu>
RUN yum -y update; yum clean all
RUN yum install httpd -y

ENV HOME /root
ENV WORKDIR /root

# install AWIPS pre-reqs
RUN yum -y install sudo wget perl less rsync

# do awips install
RUN wget https://www.unidata.ucar.edu/software/awips2/awips_install.sh \
    && chmod 755 awips_install.sh \
    && sudo ./awips_install.sh --edex

# install conda per https://phoenixnap.com/kb/how-to-install-anaconda-centos-7
RUN cd /tmp \
    && curl -O https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh \
    && bash Anaconda3-2021.05-Linux-x86_64.sh -b \
    && echo 'export PATH=/root/anaconda3/bin:$PATH' >> /root/.bashrc
# need to init conda then "bounce shell" for it to take effect before creating env
RUN . /root/.bashrc \
    && conda init bash
RUN . /root/.bashrc \
    && conda create --name grpc_env -y python=3.9 \
    && conda activate grpc_env \ 
    && pip install pygcdm

# load in config files
COPY /edex_server/etc/ldmd.conf /awips2/ldm/etc/ldmd.conf
COPY /edex_server/etc/setup.env /awips2/edex/bin/setup.env
COPY /edex_server/etc/edexServiceList /etc/rc.d/init.d/edexServiceList
COPY /edex_server/etc/registry.xml /awips2/ldm/etc/registry.xml

COPY /edex_server/etc/pqact.conf /awips2/ldm/etc/pqact.conf
COPY /edex_server/etc/test.sh /tmp/test.sh
RUN chmod 755 /tmp/test.sh

# fix yum since awips install breaks it per
# https://www.unidata.ucar.edu/support/help/MailArchives/awips/msg00365.html
RUN export LD_LIBRARY_PATH=/usr/lib:/lib:/usr/lib64:/lib64

# create empty network file
RUN touch /etc/sysconfig/network

# cleanup awips_install script
RUN rm awips_install.sh

# start container by running systemd
CMD ["/usr/sbin/init"]
