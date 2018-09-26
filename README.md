# EDEX Ingest Docker

[![Travis Status](https://travis-ci.org/Unidata/edex-docker.svg?branch=master)](https://travis-ci.org/Unidata/edex-docker)

This repository contains files necessary to build and run a Docker container for an AWIPS EDEX Data Server.

## Versions

- `unidata/edex-ingest:latest`
- `unidata/edex-ingest:18.1.1`

## Configuration

### Run Configuration with `docker-compose`

To run the EDEX Docker container, beyond a basic Docker setup, we recommend installing [docker-compose](https://docs.docker.com/compose/).

You can customize the default `docker-compose.yml` to decide:

-   which EDEX Ingest image version you want to run
-   which port will map to port `388` for the LDM

Two directory paths will be mounted outside the container with `docker-compose.yml`:

-   `etc/` to `/awips2/ldm/etc` to suppply the files `ldmd.conf` and `pqact.conf`
-   `bin/` to `/awips2/edex/bin` to supply the file `setup.env`

### LDM Configuration Files

In the `etc` directory, you will have to do the usual LDM configuration by editing:

-   `ldmd.conf`
-   `pqact.conf`

### Upstream Data Feed from Unidata or Elsewhere

The LDM operates on a push data model. You will have to find an institution who will agree to push you the data you are interested in. If you are part of the academic community please send a support email to `support-idd@unidata.ucar.edu` to discuss your LDM data requirements.

### Running EDEX Ingest

Once you have completed your `docker-compose.yml` setup, you can run the container with:

    docker-compose up -d edex-ingest

The output should be something like:

    Creating edex-ingest ... done

### Stopping EDEX Ingest

To stop this container:

    docker-compose stop

### Delete EDEX Ingest Container

To clean the slate and remove the container (not the image, the container):

    docker-compose rm -f

## Check What is Running

To verify that EDEX and the LDM are alive you can run `edex status` **inside** the container. To do that, run:

    docker exec edex-ingest edex status

which should look like:

    [edex status]
     qpid        :: running :: pid 22474
     EDEXingest  :: running :: pid 21860 31513
     EDEXgrib    :: running :: pid 21869 31630
     ldmadmin    :: running :: pid 22483

     edex (status|start|stop|setup|log|purge|qpid|users)

## Running Commands Inside the Container

1. You can enter the container with `docker exec -it edex-ingest  bash`. For example,

 ```bash
 $ docker exec -it edex-ingest bash
 [root@291c06984ded ~]$ edex log
 ```

2. Execute the command from outside the container with `docker exec edex-ingest <command>`. For example,

 ```bash
 docker exec edex-ingest edex log
 ```
## Updates

To update the container

```bash
docker pull unidata/edex-ingest:latest
docker-compose stop
docker-compose up -d edex-ingest
```

## Support

If you have a question or would like support for this EDEX Ingest Docker container, consider [submitting a GitHub issue](https://github.com/Unidata/edex-docker/issues). Alternatively, you may wish to start a discussion on the AWIPS Community mailing list: <awips2-users@unidata.ucar.edu>.

For general AWIPS questions, please see the [Unidata AWIPS page](https://www.unidata.ucar.edu/software/awips/).
