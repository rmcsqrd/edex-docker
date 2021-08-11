FROM python:3.9
MAINTAINER "Rio McMahon" <rmcmahon@ucar.edu>

# install gRPC stuff
COPY ./common/grpcio_init.sh /tmp/grpcio_init.sh
RUN chmod 755 /tmp/grpcio_init.sh
RUN /tmp/grpcio_init.sh
