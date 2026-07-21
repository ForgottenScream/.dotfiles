#!/usr/bin/env bash

VM="$1"
DEVICE="sys-usb:4-7"

INUSE=$(qvm-device usb ls | awk -v m="$DEVICE" '$1==m {print $10}')
if [ -n "$INUSE" ]; then
	qvm-device usb d "$INUSE" "$DEVICE"
else
	qvm-device usb a "$VM" "$DEVICE"
fi
