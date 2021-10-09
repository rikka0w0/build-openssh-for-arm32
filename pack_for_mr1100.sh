#!/bin/bash

tar_name="mr1100_root.tar.gz"
mr1100_root="mr1100_root"
usr_bin=$mr1100_root/usr/bin
usr_sbin=$mr1100_root/usr/sbin
usr_lib=$mr1100_root/usr/lib

rm -r $mr1100_root

mkdir -p $usr_bin
cp -v openssh/ssh $usr_bin
cp -v openssh/sftp $usr_bin
cp -v openssh/ssh-keygen $usr_bin
#cp -v openssh/scp $usr_bin

mkdir -p $usr_sbin
cp -v openssh/sshd $usr_sbin

mkdir -p $usr_lib
cp -v openssh/sftp-server $usr_lib

pushd $mr1100_root
tar -czf $tar_name --exclude=$tar_name .
wait
mv $tar_name ../
popd
