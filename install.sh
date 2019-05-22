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
    ui_print " ${MOD_NAME}"
    ui_print " v${MOD_VERSION}"
}

on_install() {
    ui_print "- Searching Busybox"
    local BUSYBOX="$(busybox which busybox)"
    test ! -x "${BUSYBOX}" && abort "! Unsupported Magisk version!"

    local BUSYBOX_DIR="$(${BUSYBOX} 2>&1 | head -1)"
    test ! -z "${BUSYBOX_DIR##*topjohnwu*}" && abort "Unsupported Magisk Busybox: ${BUSYBOX_DIR} at ${BUSYBOX}"

    BUSYBOX_DIR="${MODPATH}/system/xbin"

    ui_print "- Linking ${BUSYBOX}"
    mkdir -p "${BUSYBOX_DIR}" >&2
    ln -s "${BUSYBOX}" "${BUSYBOX_DIR}/busybox" >&2
    ui_print "- Installing busybox"
    "${BUSYBOX}" --install -s "${BUSYBOX_DIR}" >&2
}
