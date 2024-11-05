#!/bin/sh
# Usage $0 <PCI device>, ex: 9:00.0

INTX=$(( 0x400 ))
ORIG=$(( 0x$(setpci -s $1 4.w) ))

if [ $(( $INTX & $ORIG )) -ne 0 ]; then
echo "INTx disable supported and enabled on $1"
exit 0
fi

NEW=$(printf %04x $(( $INTX | $ORIG )))
setpci -s $1 4.w=$NEW
NEW=$(( 0x$(setpci -s $1 4.w) ))

if [ $(( $INTX & $NEW )) -ne 0 ]; then
echo "INTx disable support available on $1"
else
echo "INTx disable support NOT available on $1"
fi

NEW=$(printf %04x $ORIG)
setpci -s $1 4.w=$NEW

