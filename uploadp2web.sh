#!/bin/sh

path=$1
game=${path##*/}
game=${game%.*}
loadUUid="" 
loadpath=$path/assets/resources/general/loading/loading.fire.meta
if [ -e $loadpath ]; then 
	loadUUid=$(cat $loadpath | jq -r ".uuid")
fi
echo $loadUUid
# buildparam="title=$game;platform=win32;md5Cache=false;template=link;inlineSpriteFrames=false;debug=true;encryptJs=false"
buildparam="title=$game;platform=web-mobile;debug=true;embedWebDebugger=true;md5Cache=true;"
if [[ $loadUUid != "" ]]; then buildparam="$buildparam;startScene=$loadUUid"; fi
/d/ruanjian/CocosDashboard/resources/.editors/Creator/2.4.3/CocosCreator.exe --path "$path" --build "$buildparam"

rm $path/build/$game.zip
rm -rf /s/q $path/build/$game
mv $path/build/web-mobile $path/build/$game
cd $path/build
zip -r -q $game.zip $game 

path=$path/build/$game.zip

dirpath=/home/nfs_root/qa-web-pvc-5fe80612-e10b-4112-8509-511c5ba19127/www/p2web

scp $path root@192.168.0.189:$dirpath
ssh root@192.168.0.189 "cd $dirpath && rm -rf $game && unzip $game.zip && rm $game.zip"
echo p2web $game
