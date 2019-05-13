#!/sbin/sh

SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false
REPLACE="
"

print_modname() {
    local MOD_VERSION=""
    MOD_VERSION="$(cat "${$TMPDIR}/module.prop" | grep "version=")"
    MOD_VERSION=${MOD_VERSION#????????}
    ui_print "******************************"
    ui_print " MagiskBusyBox"
    ui_print " v${MOD_VERSION}"
}

on_install() {
    local BUSYBOX=""

    if [ -x "/data/adb/magisk/busybox" ]; then
        BUSYBOX="/data/adb/magisk/busybox"
    elif [ -x "/sbin/.magisk/busybox" ]; then
        BUSYBOX="/sbin/.magisk/busybox"
    else
        abort "! Unsupported Magisk version!"
    fi

    local BUSYBOX_DIR="${MODPATH}/system/xbin"

    ui_print "- Linking ${BUSYBOX}"
    mkdir -p "${BUSYBOX_DIR}" >&2
    ln -s "${BUSYBOX}" "${BUSYBOX_DIR}/busybox" >&2
    ui_print "- Installing busybox"
    "${BUSYBOX}" --install -s "${BUSYBOX_DIR}" >&2
}
