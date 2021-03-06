# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=aaaaaaaaa
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=cancro
'; } # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

### begin ramdisk changes

backup_file default.prop
replace_line default.prop "ro.debuggable=1" "ro.debuggable=0"

backup_file init.qcom.usb.sh
sed -i -e '1h;2,$H;$!d;g' -re 's|then\n*[ \t]*setprop persist.sys.usb.config mtp,adb;?\n*[ \t]*else\n*[ \t]*setprop persist.sys.usb.config mtp,adb|then setprop persist.sys.usb.config mtp,adb; else setprop persist.sys.usb.config none|' init.qcom.usb.sh

### end ramdisk changes

write_boot;

## end install

