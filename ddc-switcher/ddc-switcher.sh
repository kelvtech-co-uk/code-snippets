#!/bin/bash
if ddcutil getvcp 60 | awk '{print $8}' | grep -q "(sl=0x03)"
then
	ddcutil setvcp 60 0x11
else
	ddcutil setvcp 60 0x03
fi
exit 0
