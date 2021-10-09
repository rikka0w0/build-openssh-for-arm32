#!/bin/ash

# Change these to match your setep:
# Binaries
wget $binsvr/openssh/ssh -O /usr/bin/ssh
chmod +x /usr/bin/ssh
wget $binsvr/openssh/sftp -O /usr/bin/sftp
chmod +x /usr/bin/sftp
wget $binsvr/openssh/ssh-keygen -O /usr/bin/ssh-keygen
chmod +x /usr/bin/ssh-keygen
wget $binsvr/openssh/sshd -O /usr/sbin/sshd
chmod +x /usr/sbin/sshd
wget $binsvr/openssh/sftp-server -O /usr/lib/sftp-server
chmod +x /usr/lib/sftp-server

# Configs and AutoRun
mkdir -p /etc/ssh
wget $binsvr/arm_ssh_cfg/sshd_config -O /etc/ssh/sshd_config
wget $binsvr/arm_ssh_cfg/sshd_init_d -O /etc/init.d/sshd.sh
chmod +x /etc/init.d/sshd.sh

# Create Folders and Add your PubKey (for password-less login)
mkdir /etc/ssh/empty
mkdir -p ~/.ssh
echo $pubkey >> ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys
