
#!/bin/bash

OUTPATH=$(readlink -f $1/../target/boot)
KERNEL_VERSION=$(cat $1/../../.config | grep 'BR2_LINUX_KERNEL_VERSION' | cut -d '=' -f2 | sed 's/\"//g')
KERNEL_PATH=$(readlink -f $1/../build/linux-$KERNEL_VERSION)
INCLUDE_H=$(readlink -f $KERNEL_PATH/arch/arm/boot/dts/include)
INCLUDE_DTSI=$(readlink -f $KERNEL_PATH/arch/arm/boot/dts)
DTC="$1/../../output/host/usr/bin/dtc"
CPP="$1/../../output/host/usr/bin/arm-linux-cpp"

[ -f $DTC ] && echo "  Found Dtc Compiler..." || (echo "  Error: DTC Compiler not Installed!" && exit -1)

for f in $1/../../nonlinear/devicetree/nonlinear-labs-*.dts
do
	echo "  Processing $f"
	FILENAME=$(basename "$f")
	EXTENSION="${FILENAME##*.}"
	FILENAME="${FILENAME%.*}"
	REVISION=`echo $FILENAME | cut -d '-' -f 3`
	#echo $INCLUDE_H
	#echo $INCLUDE_DTSI
	#echo Extension: $EXTENSION
	#echo Filename: $FILENAME
	#echo Revision: $REVISION
	cat $f | eval $CPP -P -x assembler-with-cpp -undef -D__DTS__ -nostdinc -I $INCLUDE_H -I $INCLUDE_DTSI - >tmp.dtc
	eval $DTC -i $INCLUDE_DTSI -I dts -b 0 -O dtb -o $OUTPATH/$FILENAME.dtb tmp.dtc && rm tmp.dtc
done

echo "  Build compatibility File: am335x-boneblack.dtb"
cp $OUTPATH/$FILENAME.dtb $OUTPATH/am335x-boneblack.dtb


exit 0

