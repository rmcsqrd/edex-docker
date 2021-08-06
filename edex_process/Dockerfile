FROM python:3.9
MAINTAINER "Rio McMahon" <rmcmahon@ucar.edu>

# install gRPC stuff
RUN python -m pip install --upgrade pip
RUN python -m pip install grpcio
RUN python -m pip install grpcio-tools

# get proto files and generate code
RUN mkdir -p /grpc/ucar/gcdm/

ENV GRID=gcdm_grid
ENV NETCDF=gcdm_netcdf
ENV SERVER=gcdm_server 

RUN curl https://raw.githubusercontent.com/Unidata/netcdf-java/develop/gcdm/src/main/proto/ucar/gcdm/gcdm_grid.proto -L -o /grpc/ucar/gcdm/gcdm_grid.proto
RUN curl https://raw.githubusercontent.com/Unidata/netcdf-java/develop/gcdm/src/main/proto/ucar/gcdm/gcdm_netcdf.proto -L -o /grpc/ucar/gcdm/gcdm_netcdf.proto
RUN curl https://raw.githubusercontent.com/Unidata/netcdf-java/develop/gcdm/src/main/proto/ucar/gcdm/gcdm_server.proto -L -o /grpc/ucar/gcdm/gcdm_server.proto

RUN python -m grpc_tools.protoc -I/grpc/ --python_out=/grpc --grpc_python_out=/grpc /grpc/ucar/gcdm/gcdm_netcdf.proto
RUN python -m grpc_tools.protoc -I/grpc/ --python_out=/grpc --grpc_python_out=/grpc /grpc/ucar/gcdm/gcdm_grid.proto
RUN python -m grpc_tools.protoc -I/grpc/ --python_out=/grpc --grpc_python_out=/grpc /grpc/ucar/gcdm/gcdm_server.proto

