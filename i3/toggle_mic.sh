#!/usr/bin/env bash

VM="$1"
DEVICE="dom0:mic"

INUSE=$(qvm-device mic ls | awk -v m="$DEVICE" '$1==m {print $5}')
if [ -n "$INUSE" ]; then
	qvm-device mic d "$INUSE" "$DEVICE"
else
	qvm-device mic a "$VM" "$DEVICE"
fi
