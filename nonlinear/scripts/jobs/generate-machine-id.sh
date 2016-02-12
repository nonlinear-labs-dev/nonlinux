#!/bin/bash
WD=$1
OUTFILE=$WD/etc/machine-id

MACHINE_ID=`< /dev/urandom tr -dc '[:xdigit:]' | head -c32 | tr '[:upper:]' '[:lower:]'; echo;`;

echo Generated /etc/machine_id = [$MACHINE_ID]
echo $MACHINE_ID > $OUTFILE

exit 0
