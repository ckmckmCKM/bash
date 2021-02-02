#!/bin/sh

path=$1

OLD_IFS=$IFS
IFS=' '','
cat ${path} | while read c1 c2
do
echo $c1
if [ $c1 == '"uuid":' ]
then
echo $c2
len=${#c2}
end=`expr ${#c2} - 2`
uuid=${c2:1:`expr ${#c2} - 2`}
echo $uuid
fi
done

IFS=$OLD_IFS
echo p2web $game
