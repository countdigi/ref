# Linux/UNIX Reference Sheet

# Misc

We should also enable SWAP memory on this droplet, at least 2GB:

    dd if=/dev/zero of=/swap bs=1024 count=2097152
    mkswap /swap && chown root. /swap && chmod 0600 /swap && swapon /swap
    echo /swap swap swap defaults 0 0 >> /etc/fstab
    echo vm.swappiness = 0 >> /etc/sysctl.conf && sysctl -p


# Listing extended attributes of a file.
  lsattr # (chattr to modify)

# Startup
  chkconfig --list | chkconfig --add |chkconfig --del | chkconfig --level {level}

# Processes
  $ ps axww | grep cron
  $ ps aux | grep 'ss[h]'   # Find all ssh pids without the grep pid
  $ pgrep -l sshd           # Find the PIDs of processes by (part of) name
  $ fuser -va 22/tcp        # List processes using port 22 (Linux)
  $ fuser -va /home         # List processes accessing the /home partition

# Signals/Kill
  $ kill -s TERM 4712        # same as kill -15 4712
  $ killall -1 httpd         # Kill HUP processes by exact name
  $ pkill -9 http            # Kill TERM processes by (part of) name
  $ pkill -TERM -u www       # Kill TERM processes owned by www
  $ fuser -k -TERM -m /home  # Kill every process accessing /home (to umount)

  1   HUP (hang up)
  2   INT (interrupt)
  3   QUIT (quit)
  9   KILL (non-catchable, non-ignorable kill)
  15  TERM (software termination signal)

# LVM
  . http://tldp.org/HOWTO/LVM-HOWTO/
  $ lvdisplay
  $ vgdisplay

# Disks
  $ hdparm -I /dev/sda    # information about the IDE/ATA disk (Linux)
  $ fdisk /dev/sda        # Display and manipulate the partition table
  $ smartctl -a /dev/sda  # Display the disk SMART info
  $ time dd if=/dev/ad4s3c of=/dev/null bs=1024k count=1000
  $ time dd if=/dev/zero bs=1024k count=1000 of=/home/1Gb.file
  $ hdparm -tT /dev/hda

# CD/ROM / LOFS / SWAP / TMPFS
  $ mount -t auto /dev/cdrom /mnt/cdrom    # typical cdrom mount command
  $ mount /dev/hdc  -t iso9660 -r /cdrom   # typical IDE
  $ mount /dev/scd0 -t iso9660 -r /cdrom   # typical SCSI cdrom
  $ mount /dev/sdc0 -t ntfs-3g /windows    # typical SCSI
  $ mount -t iso9660 -o loop file.iso /mnt # Mount a CD image
  $ mount -t ext3 -o loop file.img /mnt    # Mount an image with ext3 fs
  $ dd if=/dev/zero of=/swap2gb bs=1024k count=2000
  $ mkswap /swap2gb                    # create the swap area
  $ swapon /swap2gb                    # activate the swap. It now in use
  $ swapoff /swap2gb                   # when done deactivate the swap
  $ rm /swap2gb
  $ mount -t tmpfs -osize=64m tmpfs /ramdisk # Creata a ram disk

# IP / Routing
  $ ifconfig eth0 192.168.50.254 netmask 255.255.255.0       # First IP
  $ ifconfig eth0:0 192.168.51.254 netmask 255.255.255.0     # Second IP
  $ ifconfig eth0 hw ether 00:01:02:03:04:05              # Change MAC

  $ route add -net 192.168.20.0 netmask 255.255.255.0 gw 192.168.16.254
  $ route add -net 192.168.20.0 netmask 255.255.255.0 dev eth0
  $ route add default gw 192.168.51.254
  $ route delete -net 192.168.20.0 netmask 255.255.255.0

  $ netstat -an | grep LISTEN
  $ socklist                      # Linux display list of open sockets
  $ netstat -anp --udp --tcp | grep LISTEN        # Linux
  $ netstat -tup                  # List active connections to/from system
  $ netstat -tupl                      # List listening ports from system

  $ iptables -L -n -v                  # For status
  $ iptables -P INPUT       ACCEPT     # Open everything
  $ iptables -P FORWARD     ACCEPT
  $ iptables -P OUTPUT      ACCEPT
  $ iptables -Z    # Zero the packet and byte counters in all chains
  $ iptables -F    # Flush all chains
  $ iptables -X    # Delete all chains
  $ cat /proc/sys/net/ipv4/ip_forward  # Check IP forward 0=off, 1=on
  $ echo 1 > /proc/sys/net/ipv4/ip_forward \
    # to permanently set, edit /etc/sysctl.conf with "net.ipv4.ip_forward = 1"
  $ iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE  # to activate NAT
  $ iptables -t nat -A PREROUTING -p tcp -d 78.31.70.238 --dport 20022 \
      -j DNAT \ --to 192.168.16.44:22 # Forward 20022 to internal IP port ssh
  $ iptables -t nat -A PREROUTING -p tcp -d 78.31.70.238 --dport 993:995 \
      -j DNAT --to 192.168.16.254:993-995 # Forward of range 993-995
  $ iptables -L -t nat            # Check NAT status

# Samba Mount
  $ smbclient -U user -I 192.168.16.229 -L //smbshare/    # List the shares
  $ mount -t smbfs -o username=winuser //smbserver/myshare /mnt/smbshare
  $ mount -t cifs -o username=winuser,password=winpwd \
      //192.168.16.229/myshare /mnt/share

# Create and burn an ISO Image
# Commands: cdrecord, dvdrecord, growisofs, dvd+rw-tools
  $ dd if=/dev/hdc of=/tmp/mycd.iso bs=2048 conv=notrunc
  $ mkisofs -J -L -r -V TITLE -o imagefile.iso /path/to/dir
  $ dd bs=1k if=imagefile.nrg of=imagefile.iso skip=300 # convert nero to iso
  $ bchunk imagefile.bin imagefile.cue imagefile.iso # convert cue to iso

  # Simplest make iso command (rock ridge extension with long names and perms)
    mkisofs -r /home/foo > /tmp/home-foo.iso


# tcpdump
  $ tcpdump -nl -i bge0 not port ssh and src \(192.168.16.121 or 192.168.16.54\)
  $ tcpdump -n -i eth1 net 192.168.16.121  # select to/from a single IP
  $ tcpdump -n -i eth1 net 192.168.16.0/24 # select traffic to/from a network
  $ tcpdump -l > dump && tail -f dump      # Buffered output
  $ tcpdump -i rl0 -w traffic.rl0      # Write traffic headers in binary file
  $ tcpdump -i rl0 -s 0 -w traffic.rl0 # Write traffic + payload in binary file
  $ tcpdump -r traffic.rl0             # Read from file (also for ethereal
  $ tcpdump port 80                    # The two classic commands
  $ tcpdump host google.com
  $ tcpdump -i eth0 -X port \(110 or 143\) # Check if pop or imap is secure
  $ tcpdump -n -i eth0 icmp                # Only catch pings
  $ tcpdump -i eth0 -s 0 -A port 80 | grep GET # -s 0 full packet, -A for ASCII
    # Aditional important options:
    . -A     Print each packets in clear text (without header)
    . -X     Print packets in hex and ASCII
    . -l     Make stdout line buffered
    . -D     Print all interfaces available

# netcat
  $ tar -cf - -C VIDEO_TS . | nc -l -p 4444     # Serve tar folder on port 4444
  $ nc 192.168.1.1 4444 | tar xpf - -C VIDEO_TS # Pull the file on port 4444
  $ cat largefile | nc -l 5678       # Server a single file
  $ nc 192.168.1.1 5678 > largefile  # Pull the single file
  $ dd if=/dev/da0 | nc -l 4444      # Server partition image
  $ nc 192.168.1.1 4444 | dd of=/dev/da0  # Pull partition to clone
  $ nc 192.168.1.1 4444 | dd of=da0.img   # Pull partition to file
  $ while true; do nc -l -p 80 < unixtoolbox.xhtml; done # emergency webserver

# openssl
  $ openssl aes-128-cbc -salt -in file -out file.aes
  $ openssl aes-128-cbc -d -salt -in file.aes -out file
  $ tar -zcf - directory | \
      openssl aes-128-cbc -salt -out directory.tar.gz.aes    # Encrypt
  $ openssl aes-128-cbc -d -salt -in directory.tar.gz.aes \
      | tar -xz                                              # Decrypt

# GPG
  $ gpg -c file                        # Encrypt file with password
  $ gpg file.gpg                       # Decrypt file (optionally -o otherfile)
  $ gpg --gen-key                                 # Generate a key
  $ gpg --armor --output pubkey.txt --export NAME # Generate ASCII key
  $ gpg --send-keys NAME --keyserver hkp://subkeys.pgp.net # or mit
  $ gpg --import key.asc
  $ gpg --search-keys 'joe@themoon.com' --keyserver hkp://subkeys.pgp.net
  $ gpg --encrypt --recipient 'myfriend@his.isp.net' foo.txt
  $ gpg --output foo.txt --decrypt foo.txt.gpg
  $ gpg --list-keys               # list public keys and see the KEYIDS \
  $ gpg --gen-revoke 'Your Name'  # generate revocation certificate
  $ gpg --list-secret-keys        # list private keys
  $ gpg --delete-keys NAME        # delete a public key from local key ring
  $ gpg --delete-secret-key NAME  # delete a secret key from local key ring
  $ gpg --fingerprint KEYID       # Show the fingerprint of the key
  $ gpg --edit-key KEYID          # Edit key (e.g sign or add/del email)
  $ gpg -e -r 'Alice' file        # Encrypt the file for Alice.
  $ gpg -d file.gpg -o file       # Decrypt a file encrypted by Alice for you.
  # ~/.gnupg/pubring.gpg - Contains your public keys and all others imported
  # ~/.gnupg/secring.gpg - Can contain more than one private key
  # Common Options Summary
    -e encrypt data
    -d decrypt data
    -r NAME encrypt for recipient NAME (or 'Full Name' or 'email@domain')
    -a create ascii armored output of a key
    -o use as output file

# OpenSSL and Certificates
  # /etc/ssl/openssl.cnf
    [ CA_default ]
    dir           = /usr/local/certs/CA       # Where everything is kept
    certs         = $dir/certs                # Where the issued certs are kept
    crl_dir       = $dir/crl                  # Where the issued crl are kept
    database      = $dir/index.txt            # database index file.
  $ mkdir -p /usr/local/certs/CA
  $ cd /usr/local/certs/CA
  $ mkdir certs crl newcerts private
  $ echo "01" > serial                        # Only if serial does not exist
  $ touch index.txt

  # Creating a certificate authority
  $ openssl req -new -x509 -days 730 -config /etc/ssl/openssl.cnf \
      -keyout CA/private/cakey.pem -out CA/cacert.pem

  # Creating a certificate signing request
  $ openssl req -new -keyout newkey.pem -out newreq.pem -config \
      /etc/ssl/openssl.cnf
  $ openssl req -nodes -new -keyout newkey.pem -out newreq.pem \
      -config /etc/ssl/openssl.cnf                # No encryption for the key

  # Sign the certificate
  $ cat newreq.pem newkey.pem > new.pem
  $ openssl ca -policy policy_anything -out servernamecert.pem \
     -config /etc/ssl/openssl.cnf -infiles new.pem
  $ mv newkey.pem servernamekey.pem

  # View certificate information
  $ openssl x509 -text -in servernamecert.pem  # View the certificate info
  $ openssl req -noout -text -in server.csr    # View the request info
  $ openssl s_client -connect cb.vu:443        # Check a web server certificate

# Find
  $ find . -type f ! -perm -444      # Find files not readable by all
  $ find . -type d ! -perm -111      # Find dirs not accessible by all
  $ find /home/user/ -cmin 10 -print # Files created or modified in the \
                                     # last 10 min.
  $ find . -name '*.[ch]' | xargs grep -E 'expr'
  $ find / -name "*.core" | xargs rm
  $ find / -name "*.core" -print -exec rm {} \;  # Other syntax
  $ find . \( -iname "*.png" -o -iname "*.jpg" \) -print \
      -exec tar -rf images.tar {} \;
  $ find . -type f -name "*.txt" ! -name README.txt -print
  $ find /var/ -size +10M -exec ls -lh {} \;     # Find large files > 10 MB
  $ find /var/ -size +10M -ls           # This is simpler
  $ find . -size +10M -size -50M -print
  $ find / -type f -user root -perm -4000 -exec ls -l {} \; \
     # Find files with SUID; those file are vulnerable and must be kept secure

# RPM
  $ rpm -qa  # list installed packages
  $ rpm -i   # install the package
  $ rpm -e   # remove the package
  $ rpm -qp --scripts filename.rpm # show scripts that run for package

# MySQL

  # Change root password
    $ /etc/init.d/mysql stop
    $ killall mysqld
    $ mysqld --skip-grant-tables
    $ mysqladmin -u root password 'newpasswd'
    $ /etc/init.d/mysql start

  # Create user and database
  $ mysql -u root mysql
  mysql> CREATE DATABASE bobdb;
  mysql> GRANT ALL ON *.* TO 'bob'@'%' IDENTIFIED BY 'pwd'; \
     # Use localhost instead of %
  mysql> DROP DATABASE bobdb;   # Delete database
  mysql> DROP USER bob;         # Delete user
  mysql> DELETE FROM mysql.user WHERE user='bob and host='hostname'; # Alt. command
  mysql> FLUSH PRIVILEGES;

  # Grant Remote Access
  $ mysql -u root mysql
  mysql> GRANT ALL ON bobdb.* TO bob@'xxx.xxx.xxx.xxx' IDENTIFIED BY 'PASSWORD';
  mysql> REVOKE GRANT OPTION ON foo.* FROM bar@'xxx.xxx.xxx.xxx';
  mysql> FLUSH PRIVILEGES; # Use 'hostname' or also '%' for full access

  # Backup and restore
  $ mysqldump -u root -psecret --add-drop-database dbname > dbname_sql.dump
  $ mysql -u root -psecret -D dbname < dbname_sql.dump
  # All Database
  $ mysqldump -u root -psecret --add-drop-database --all-databases > full.dump
  $ mysql -u root -psecret < full.dump

# Framebuffer on boot

  . Add this to the end of the "kernel" line in grub.conf:
  video=vesafb:ywrap,mtrr vga=0x374

# Mounting a CD ISO as a loopback device
  $ sudo mount -o loop,ro -t iso9660 ~/CUA360.SP1 /mnt/cdrom

# setup wireless access

Load wireless drivers:
    modprobe wlan_scan_sta
    modprobe ath_pci

Scan network:
    wlanconfig ath0 list scan
    iwlist ath0 scan

Associate AP by essid, mac, or any:
    iwconfig ath0 essid TPA
    iwconfig ath0 ap xx:xx:xx:xx:xx:xx
    iwconfig ath0 ap any

Request DHCP address:
    dhclient ath0
