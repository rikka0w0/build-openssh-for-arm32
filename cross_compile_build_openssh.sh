#!/bin/bash

#. ./cross_compile_common.sh

function cross_compile_build_openssh() {
  target_os="arm"

  ssh_prefix="/usr"
  ssh_privsep_usr="root"
  ssh_privsep_path="/etc/ssh/empty"
  ssh_pid_dir="/etc/ssh"
  ssh_cfg_dir="/etc/ssh"

  zlib_arm_build_dir="$PWD/zlib/$cross_compile_build_dir"
  openssl_arm_build_dir="$PWD/openssl/$cross_compile_build_dir"

  pushd openssh
  [ -d $cross_compile_build_dir ] || ./configure \
    CC=${cross_compile_bin_prefix}gcc \
    --host=$target_os \
    --disable-strip \
    --disable-etc-default-login \
    --with-privsep-user=$ssh_privsep_usr \
    --with-privsep-path=$ssh_privsep_path \
    --with-pid-dir=$ssh_pid_dir \
    --with-zlib=$zlib_arm_build_dir \
    --with-ssl-dir=$openssl_arm_build_dir \
    --sysconfdir=$ssh_cfg_dir \
    --prefix=$ssh_prefix

  cross_compile_common_build 0 0 0

  popd
}

#cross_compile_build_openssh
