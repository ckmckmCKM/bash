#!/bin/bash


# 要删除的文件名字的数字（需要手动改）
rmArr=(.git library local temp packages settings)


# 当前绝对路径名字
project_path=$(cd `dirname $0`; pwd)
echo 当前绝对路径名字 $project_path
# 路径文件夹名字
project_name="${project_path##*/}"
echo 路径文件夹名字 $project_name
echo $project_path

# 读取当前文件夹下的文件名字
for file in `ls`
do
objPath=${project_path}/$file
# rm -rf $objPath/222

for obj in ${rmArr[*]}
do
# 判断路径存在
if [ -d $objPath ]
then
echo $objPath/$obj
# 删除目录
rm -rf $objPath/$obj
fi
done

done