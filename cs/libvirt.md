# ref/libvirt.md

- `virsh console <domain>` - to exit: # Ctrl+] or Ctrl+5
- `virsh snapshot-create-as ${guest} ${tag:-base}`
- `virsh snapshot-revert ${guest} ${tag:-base}`
- `virsh snapshot-list ${guest}`
- `qemu-img create -f qcow2 -o preallocation=metadata /kvm/${guest}.qcow2 ${disk:-8192}`
- `virsh vol-create-as --pool kvm-general --name hdp-admin.qcow2 --prealloc-metadata --format qcow2 --capacity 32G`
- `virsh destroy ${guest}; virsh undefine --remove-all-storage --snapshots-metadata ${guest}`

- List all virtual domains: `virsh list --all`



install:

    sudo yum install -y libvirt
    sudo yum install -y polkit-gnome # for remote client and vagrant-libvirt connectivity

pxe-boot:

    virt-install \
      --connect qemu:///system \
      --name=${guest} \
      --pxe \
      --network=bridge:br0,mac=${mac} \
      --ram=${mem} \
      --vcpus=${cpus:-2} \
      --os-type=linux \
      --os-variant=rhel7 \
      --noautoconsole \
      --disk path=/kvm/${guest}.qcow2,format=qcow2 && virsh console ${guest}

access:

    sudo /bin/bash -c "
      cat <<EOF > /etc/polkit-1/localauthority/50-local.d/90-site-remote-access.pkla
      [libvirt Management Access]
      Identity=unix-user:$LOGNAME
      Action=org.libvirt.unix.manage
      ResultAny=yes
      ResultInactive=yes
      ResultActive=yes
      EOF
    "

    (cd /; /usr/bin/nohup /usr/libexec/polkit-gnome-authentication-agent-1 &>/dev/null & disown -h;)
