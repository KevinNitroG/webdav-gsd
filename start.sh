#!/usr/bin/env sh

set -e

export RCLONE_CONFIG='/app/rclone/rclone.conf'
if [ ! -e "$RCLONE_CONFIG" ]; then
  mkdir -p "${RCLONE_CONFIG%/*}"
  wget -O "$RCLONE_CONFIG" "$RCLONE_CONFIG_URL"
fi

all_drives=$(rclone backend -o config drives "${ROOT:-root:}")
echo "$all_drives" >>"$RCLONE_CONFIG"

sleep 5 # Let rclone rest, update sth

rclone ${RCLONE_ARGS:+$RCLONE_ARGS} serve webdav AllDrives: --addr :8080 --vfs-cache-mode full --webdav-user ${RCLONE_USER} --webdav-pass ${RCLONE_PASS} ${RCLONE_OPT_ARGS:+$RCLONE_OPT_ARGS}
