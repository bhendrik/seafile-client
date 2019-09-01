## About

- [Docker](https://docker.com/) is an open source project to pack, ship and run any Linux application in a lighter weight, faster container than a traditional virtual machine.

- Docker makes it much easier to deploy [a Seafile client (cli only)](https://github.com/haiwen/seafile-client) on your servers and keep it updated.

If you are not familiar with docker commands, please refer to [docker documentation](https://docs.docker.com/engine/reference/commandline/cli/).

### Getting Started

To run the seafile-client container (this assumes you are a member of the docker group, use sudo if not):

```sh
docker run -d --name seafile-client \
  -v /your/data/path:/data \
  -v /your/config/path:/home/sfuser/seafile-client/seafile-data \
  --restart unless-stopped \
  bhendrik/seafile-client:latest
```
This command will mount folder `/your/data/path` at the local server to the docker instance. You can find your libraries under this folder.

Your config is saved in `/your/config/path`, so with subsequent pulls you´ll retain your configured libraries.

Sync is running in the container as user sfuser with UID 1000 and GUID 1000, make sure the folder on your server can be written to it by the user on your server with UID 1000.

Once the container is started you can add a library to sync.

#### Adding a library

Once the container is running, you can add a library:
e.g.

```sh
docker exec -it seafile-client /bin/bash /sync.sh
```

```sh
Input new sync parameters
Library-ID: <Library-id>
Server-url: https://seafile.example.com
Library folder will be located under /data
Email-address: me@example.com
Enter password for user me@example.com :
Starting to download ...
Library <Library-id> will be downloaded to /data
# Name  Status  Progress
<Library-name>      downloading     0/0, 0.0KB/s

# Name  Status
```

If you go to your Seafile server and select your library, the Library-id is the numbered part after library (`https://seafile.example.com/library/5db2234a-2c24-4e45-8b08-a6d1e569333f/My%20Library/`)

e.g.

`5db2234a-2c24-4e45-8b08-a6d1e569333f`
#### checking sync status

```sh
docker exec -it seafile-client /bin/bash /status.sh
```

#### Tech info

Image uses phusion/baseimage (https://hub.docker.com/r/phusion/baseimage and https://github.com/phusion/baseimage-docker).
Seafile client deamon is started by copying `seaf.sh` to `/etc/service/seafile/run`

normally the client deamon is started with `seaf-cli start`, however this ends immediately.
By investigating the container when manually starting the client while in the container, you can find that the it starts a deamon (use `ps -aux` to check this).

 `seaf-daemon --daemon -c /home/sfuser/.ccnet -d /home/sfuser/seafile-client/seafile-data -w /home/sfuser/seafile-client/seafile`
 
When you remove the `--deamon` part from this it will run in the foreground, so this is used in the run file together with the `/sbin/setuser` utility to start it as the user sfuser.
The run file is started by `/etc/my_init`.
