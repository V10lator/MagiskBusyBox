#!/sbin/sh

SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false
REPLACE="
"

print_modname() {
    unzip -o "${ZIPFILE}" module.prop -d "${TMPDIR}" >&2
    local MOD_PROP="$(cat "${TMPDIR}/module.prop")"

    local MOD_NAME="$(echo "${MOD_PROP}" | grep "name=")"
    MOD_NAME=${MOD_NAME:5}

    local MOD_VERSION="$(echo "${MOD_PROP}" | grep "version=")"
    MOD_VERSION=${MOD_VERSION:8}

    ui_print "******************************"
    ui_print " Resurrection Remix Oreo Boot"
    ui_print " v${MOD_VERSION}"
}

on_install() {
    local BUSYBOX=""

    if [ -x "/data/adb/magisk/busybox" ]; then
        BUSYBOX="/data/adb/magisk/busybox"
    elif [ -x "/sbin/.magisk/busybox" ]; then
        BUSYBOX="/sbin/.magisk/busybox"
    elif [ -x "/sbin/.core/busybox" ]; then
        BUSYBOX="/sbin/.core/busybox"
    elif [ -x "/magisk/.core/busybox" ]; then
        BUSYBOX="/magisk/.core/busybox"
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
