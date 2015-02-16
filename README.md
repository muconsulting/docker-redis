# Redis Dockerfile

A Dockerfile that produces a Docker Image for [Redis](http://redis.io/).

## Redis version

The `master` branch currently hosts Redis 2.8.

Different versions of Redis are located at the github repo [branches](https://github.com/muconsulting/docker-redis/branches).

## Usage

### Build the image

To create the image `muconsulting/redis`, execute the following command on the `docker-redis` folder:

```
$ docker build -t muconsulting/redis .
```

### Run the image

To run the image and bind to host port 6379:

```
$ docker run -d --name redis -p 6379:6379 muconsulting/redis
```

The first time you run your container, a new random password will be generated. To get the password,
check the logs of the container by running:

```
docker logs <CONTAINER_ID>
```

You will see an output like the following:

```
========================================================================
Redis Password: "xxxxxxxxxx"
========================================================================
```

#### Credentials

If you want to preset credentials instead of a random generated ones, you can set the following environment variables:

* `REDIS_PASSWORD` to set a specific password

```
$ docker run -d \
    --name redis \
    -p 6379:6379 \
    -e REDIS_PASSWORD=mypassword \
    muconsulting/redis
```

#### Extra arguments

When you run the container, it will start the Redis server without any arguments. If you want to pass any arguments,
just add them to the `run` command:

```
$ docker run -d --name redis -p 6379:6379 muconsulting/redis --loglevel debug
```

#### Persistent data

The Redis server is configured to store data in the `/data` directory inside the container. You can map the
container's `/data` volume to a volume on the host so the data becomes independent of the running container:

```
$ mkdir -p /tmp/redis
$ docker run -d \
    --name redis \
    -p 6379:6379 \
    -v /tmp/redis:/data \
    muconsulting/redis
```

There are also additional volumes at:

* `/etc/redis` which exposes Redis's configuration

## Copyright

Copyright (c) 2015 Sylvain Gibier. See [LICENSE](https://github.com/muconsulting/docker-redis/blob/master/LICENSE) for details.
