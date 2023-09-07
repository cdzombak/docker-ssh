# docker-ssh

A simple docker container that runs SSH.

## Build (Makefile)

`make build` will build the Docker image `ssh:latest` on your local machine.

(Run `make help` for a complete list of available targets.)

## Run (Docker)

After building your image, run it using a Docker command like:

```shell
docker run --name "ssh" -p 2222:22 -d -t ssh:latest
```

## Run (docker-compose)

A sample `docker-compose.yml` file is included in the repo. After building your image, run it with docker-compose via:

```shell
docker-compose up -d
```

## Find the root user password

```shell
docker logs <container name> | grep 'root login password'
```

## Login as the root user

```shell
ssh root@localhost -p 2222
```

## Add a non-root user by default

Customize your checkout's `setup.sh` to add a non-root user by default. Their password will not change each time the container starts.

## Customize login message

Customize your checkout's `my-motd` file to print custom content when a user logs into the container.

## License

Unknown: this is based on https://github.com/kartoza/docker-ssh and includes work by @timlinux, and I can't find any mention of license attached to the original works.

## Author

- Chris Dzombak (https://github.com/cdzombak)
- Based on https://github.com/kartoza/docker-ssh
- Includes work by https://github.com/timlinux
