#!/bin/bash

set -e

if [[ -d "/share" ]]; then
    echo "Found \"/share\", a samba server will be started..."
    NET="-net user,smb=/share -net nic,model=e1000"
else
    echo "Didn't find \"/share\", a samba server will *NOT* be started..."
    NET="-net user -net nic,model=e1000"
fi

[ -f "/overlay.qcow2" ] && rm /overlay.qcow2
qemu-img create -o "backing_file=$BASE,backing_fmt=$BASE_FORMAT" -f qcow2 /overlay.qcow2

echo "Starting qemu..."

qemu-system-x86_64 \
    -enable-kvm \
    -k "$KEYBOARD" \
    -name windows \
    -hda /overlay.qcow2 \
    -m "$MEMORY" \
    -vnc ":$VNC_DISPLAY" \
    -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
    -device usb-tablet \
    -monitor "tcp:0.0.0.0:$MONITOR_PORT,server,nowait" \
    -monitor vc \
    $NET \
    -cpu "$CPU" \
    -smp "$SMP"