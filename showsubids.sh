#!/bin/bash
SUBUID=/etc/subuid
SUBGID=/etc/subgid
for i in $SUBUID $SUBGID; do [[ -f "$i" ]] || { echo "ERROR: $i does not exist, but is required."; exit 1; }; done
[[ -n "$1" ]] && USERS=$1 || USERS=$(awk -F : '{x=x " " $1} END{print x}' $SUBUID)
for i in $USERS; do
        awk -F : "\$1 ~ /$i/ {printf(\"%-16s sub-UIDs: %6d..%6d (%6d)\", \$1 \",\", \$2, \$2+\$3, \$3)}" $SUBUID
        awk -F : "\$1 ~ /$i/ {printf(\", sub-GIDs: %6d..%6d (%6d)\", \$2, \$2+\$3, \$3)}" $SUBGID
        echo ""
done
