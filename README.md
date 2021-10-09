# build-openssh-for-arm32
This repo contains scripts necessary for building OpenSSH server and client for armv7l (use soft floating)
If you have an arm board (root), it is convenient to login/transfer-data by ssh.

## 1. Setup Toolchain
* `host`: Ubuntu 20.04, also tested on Ubuntu 16.04 docker image
* Install Cross GCC Toolchain
```
sudo apt install wget curl xz-utils
cd /opt
sudo wget https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/arm-linux-gnueabi/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabi.tar.xz
sudo tar -xf gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabi.tar.xz
sudo rm gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabi.tar.xz	# Delete the archieve to save some disk space
```
Install utilities:
```
sudo apt install git make cmake binutils
```

## 2. Clone this Repo
```
cd ~
git clone https://github.com/rikka0w0/build-openssh-for-arm32.git
cd build-openssh-for-arm32
chmod +x *.sh
```
### Downloaded Relevant Libraries
* `zlib` (1.2.11)
* `openssl` (1.0.2k)
* `openssh` (7.2p2)
See `url.txt`, zlib and openssl match the version shipped with MR1100 firmware, so they don't need to be copied to the device.

## 3. Build Binaries
```
./run.sh
```
OpenSSH binaries can be found in the `openssh` folder.

## 4. Upload to MR1100
* 1. You need to gain root access and use telnet to start a root shell, see MR1100_ROOT.md or (this)[https://medium.com/@michael_58691/gaining-root-privileges-on-a-netgear-m1-mobile-router-mr1100-c769525d67d1].
* 2. Edit `arm_ssh_deploy.sh` according to you setup.
* 3. Run `python -m SimpleHTTPServer` or `python3 -m http.server` on the host machine.
* 4. Run following command on the MR1100 shell:  
```
cd ~
wget http://YOURIP:8000/arm_ssh_deploy.sh
chmod +x arm_ssh_deploy.sh
./arm_ssh_deploy.sh
rm arm_ssh_deploy.sh
```
This script is downloaded to the MR1100 shell, upon running, it downloads binaries and configs,
fix permissions and generate host key for sshd.

The default sshd_config is in arm_ssh_cfg and it will be copied to `/etc/ssh` on the MR1100 device.
By default, it will only allow lan users to login with password(by default, oelinux123 for root), the others
have to use pubkey.

## 5. Start the SSHD server
```
# Run on startup
update-rc.d sshd.sh defaults

# Start
/etc/init.d/sshd.sh start

# Stop
/etc/init.d/sshd.sh stop

# Disable autorun on startup
update-rc.d -f sshd.sh remove
```

## 6. Try to Communicate with Your Board by SSH
```
#login
$ ssh root@your-board-ip -i path-to-your-private-key

#ssh-tunnel
$ ssh root@localhost -i path-to-your-private-key

#scp (bilateral)
$ scp -r file/directory root@your-board-ip:path-on-board -i path-to-your-private-key
$ scp -r root@your-board-ip:file/directory-on-board path-on-host -i path-to-your-private-key
$ scp -P host-port -r file/directory -S path-to-your-board-ssh host-name@host-ip:host-path
```

Enjoy it!
