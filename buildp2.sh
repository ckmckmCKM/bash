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
buildparam="title=$game;platform=win32;md5Cache=false;template=link;inlineSpriteFrames=false;debug=true;encryptJs=false"
if [[ $loadUUid != "" ]]; then buildparam="$buildparam;startScene=$loadUUid"; fi
/d/ruanjian/CocosDashboard/resources/.editors/Creator/2.4.3/CocosCreator.exe --path "$path" --build "$buildparam"

rm -rf $path/$game
mkdir $path/$game
mv $path/build/jsb-link/assets $path/$game/assets
mv $path/build/jsb-link/src $path/$game/src
rm $path/$game/src/cocos2d-jsb.js
rm $path/$game/src/physics.js
xxh $path/$game
cd $path
zip -r -q $game.zip $game 
dirpath=/home/nfs_root/qa-web-pvc-5fe80612-e10b-4112-8509-511c5ba19127/www/p2native/pm1
scp $path/$game.zip root@192.168.0.189:$dirpath
ssh root@192.168.0.189 "cd $dirpath && rm -rf $game && unzip $game.zip"
rm -rf $path/$game
rm $path/$game.zip
echo "打包上传完成"