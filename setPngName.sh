#!/bin/sh

# path=$1
# game=${path##*/}
# game=${game%.*}
echo 输入文件路径
read path
echo 
echo 输入修改前缀
read name

softfiles=$(ls $path)
for f in ${softfiles}
do
mv $path/$f $path/$name$f
# name=1_$f
# echo $f
# echo $name
done

echo 完成
