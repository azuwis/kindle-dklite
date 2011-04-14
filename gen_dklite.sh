#!/bin/sh
dkfolder=$1
dklitefolder=$2
model=$3

mkdir -p $dklitefolder
for i in DK_Documents DK_Pictures DK_System
do
	mkdir -p $dklitefolder/$i
done

for i in lib system Savers
do
	cp -r $dkfolder/DK_System/$i $dklitefolder/DK_System/
done

mkdir -p $dklitefolder/DK_System/bin
for i in DKPrivateProfile doc2html ebook
do
	cp $dkfolder/DK_System/bin/$i $dklitefolder/DK_System/bin/
done

for i in Savers system config.ini
do
	cp -r $dkfolder/DK_System/DK_Update/$model/DK_System/$i $dklitefolder/DK_System/
done

cp startdk.sh $dklitefolder/DK_System/
