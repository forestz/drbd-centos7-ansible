resource data {
    startup {
        wfc-timeout 30;
        outdated-wfc-timeout 20;
        degr-wfc-timeout 30;
    }
    net {
        protocol C;
        cram-hmac-alg sha1;
        shared-secret "Secret Password for DRBD";
    }
    disk {
        resync-rate 100M;
    }
    syncer {
        rate 100M;
        verify-alg sha1;
    }
    on node-01 {
        volume 0 {
            device minor 1;
            disk /dev/sdb;
            meta-disk internal;
        }
        address 192.168.32.11:7789;
    }
    on node-02 {
        volume 0 {
            device minor 1;
            disk /dev/sdb;
            meta-disk internal;
        }
        address 192.168.32.12:7789;
    }
}