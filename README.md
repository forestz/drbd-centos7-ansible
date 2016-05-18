
## Requirements

Mac OS X 10.10+ or Windows 9+ machine with a minimum of 8GB memory, 16GB is recommended.


### Tools to create a local environment

* Vagrant 1.8.1+ https://www.vagrantup.com/downloads.html
* VirtualBox 5.0+ https://www.virtualbox.org/
* Packer 0.8.6+ https://www.packer.io/downloads.html
* Ansible 1.9.4+ or 2.0.0.2+ http://docs.ansible.com/ansible/intro_installation.html


## Local developer machine (development)

### Create box using packer

    packer build centos-7.2.1511.json

### Create vms

    vagrant up

    vagrant ssh node-01
    
    vagrant ssh node-01

```

# on both nodes (this can be moved to ansible)

drbdadm create-md data
systemctl start drbd
drbdadm up data

# on primary only (node-01)
drbdadm primary --force data

# create a filesystem and mount it (on node-01)
mkfs -t ext3 /dev/drbd1
mkdir -p /mnt/data
mount -t ext3 -o noatime,nodiratime /dev/drbd1 /mnt/data

# failover (mannually)
# (on node-01)
umount /mnt/data
drbdadm secondary data

# (on node-02)
drbdadm primary data
mkdir -p /mnt/data
mount /dev/drbd1 /mnt/data
```

