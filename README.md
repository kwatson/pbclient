# Proxmox Backup Client in a Container

This was built to run on an unraid server, so here are some specific setup steps for that.

### Setup
SSH into unraid and perform the following:

```bash
mkdir -p /mnt/user/appdata/pbclient && chown nobody:nousers /mnt/user/appdata/pbclient
```

### Create the encryption key
```bash
docker run --rm -i -v /mnt/user/appdata/pbclient:/config kwatson/pbclient:latest proxmox-backup-client key create /config/client.key --kdf none
```

### Perform a backup

You can use the userscripts application to setup a recurring schedule for this.

* `docs.pxar:/data` is a friendly name for the unraid share, and `/data` is where it's mounted in the container
* `unraid@pbs\!unraid-agent` is the API username
* `PBS_PASSWORD` is your api token
* `--backup-id unraid-docs` is a friendly name that's displayed under Content in the proxmox backup UI. Without this, it would default to the hostname of the container, which is different after each run.
* `MYPBS` is the ip or url to your proxmox backup server
* `DATASTORE` is the name of your datastore

```bash
docker run --rm \
      -v /mnt/user/appdata/pbclient:/config \
      -v /mnt/user/Docs:/data \
      -e PBS_PASSWORD=CHANGEME \
      -e PBS_REPOSITORY=unraid@pbs\!unraid-agent@MYPBS:DATASTORE \
      kwatson/pbclient:latest proxmox-backup-client backup docs.pxar:/data --keyfile /config/client.key --backup-id unraid-docs
```
