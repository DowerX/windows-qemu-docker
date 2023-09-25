#!/bin/bash

set -e

if [[ ! -f "$CUSTOM_SETUP_ISO" ]]; then
    echo "Custom setup ISO was not found at \"$CUSTOM_SETUP_ISO\", creating from \"$SETUP_ISO\" and \"$AUTOUNATTEND_XML\"..."
    mkdir /custom_setup && mount "$SETUP_ISO" /mnt && cp -r /mnt/* /custom_setup && umount /mnt
    cp "$AUTOUNATTEND_XML" /custom_setup
    mkisofs \
        -iso-level 4 \
        -l \
        -R \
        -udf \
        -D \
        -b boot/etfsboot.com \
        -no-emul-boot \
        -boot-load-size 8 \
        -hide boot.catalog \
        -allow-limited-size \
        -o "$CUSTOM_SETUP_ISO" \
        /custom_setup
    rm -rf /custom_setup
fi

if [[ -d "/share" ]]; then
    echo "Found \"/share\", a samba server will be started..."
    NET="-net user,smb=/share -net nic,model=e1000"
else
    echo "Didn't find \"/share\", a samba server will *NOT* be started..."
    NET="-net user -net nic,model=e1000"
fi

[ ! -f "$BASE" ] && echo "Creating base disk image at \"$BASE\" ($BASE_FORMAT, $BASE_SIZE)..." && qemu-img create -f "$BASE_FORMAT" "$BASE" "$BASE_SIZE"

echo "Starting qemu..."

{
    set +e
    while ! nc -z localhost $MONITOR_PORT; do   
        sleep 0.1
    done

    set -e
    for i in {1..10}; do
        echo "sendkey a"
        sleep 0.5
    done | nc -q 10 localhost $MONITOR_PORT > /dev/null
} & {
    qemu-system-x86_64 \
        -enable-kvm \
        -k "$KEYBOARD" \
        -name windows-install \
        -boot once=d \
        -drive "file=$CUSTOM_SETUP_ISO,index=0,media=cdrom,readonly=on" \
        -drive "file=$BASE,index=1,media=disk" \
        -m "$MEMORY" \
        -vnc ":$VNC_DISPLAY" \
        -device usb-ehci,id=usb-bus,bus=pci.0,addr=0x4 \
        -device usb-tablet \
        -monitor "tcp:0.0.0.0:$MONITOR_PORT,server,nowait" \
        -monitor vc \
        $NET \
        -cpu "$CPU" \
        -smp "$SMP"
}
