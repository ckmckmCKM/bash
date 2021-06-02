#!/bin/bash
# @REM git.exe路径 注意修改
GIT="C:\Program Files\Git\bin\git.exe"
# 项目配置父文件目录 注意修改
cfgParentPath=/e/bash
#项目名字txt文本配置 注意修改
textNamePath=/e/bash/GitPullObjNameP1BR.txt
# 项目tag txt文本配置 注意修改
textPath=/e/bash/GitPull2_p1.txt

#分支名字 有新分支要手动添加
branchName=pm1


# 得到路径的最后文件名字
# resFile=`echo /tmp/csdn/zhengyi/test/adb.log | awk -F "/" '{print $NF}'`
# resFile=`basename /tmp/csdn/zhengyi/test/adb.log`
# echo $resFile

# 拉取项目
pullGit(){
    if [ $branchName == 1 ]; then
    git checkout master
    elif [ $branchName == pm1 ]; then
    git checkout pm1
    elif [ $branchName == pm2 ]; then
    git checkout pm2
    else
    # git checkout -b pm1 remotes/origin/pm1
    # git pull origin pm1
    # git checkout pm2
    echo 默认检出master
    git checkout master
    fi
    # git fetch

    # git pull
}

# 提交项目
pushGit(){
    record=$2
    # 修改提交记录日志
    # record=loading

    git add $1
    git commit -m $record
    git push
    # 第一次推送用下面的
    # git push --set-upstream origin pm2
}

# 提交tag
pushTag(){
    if [ $choose == 3 ]
    then
    record=sit
    fi

    git tag -a $1 -m  $record
    git push origin $1
}

# 删除tag
clearTag(){
    git tag -d $1
    git push origin :$1
}

# 设置前端显示的tag
setShowTag(){
    echo $2 > $versionPath
}

#打包
build(){
    source $buildBashPath
}

#还原本地没有提交的修改
checkoutIndex(){
    git checkout .
}

# 测试空打印
csEcho(){
    echo 测试空打印
}

switchFun(){
    # echo $p
    # echo $packageName
    cd $objPath
    # $1 tag
    # $2 日志
    case $choose in
    1) pullGit ;; # 拉取项目
    2) pushGit $objPath $2 ;; # 提交项目
    3) pushTag $1 $2 ;; # 提交tag
    4) clearTag $1 $2 ;; # 删除tag
    5) setShowTag $1 $2 ;; # 提交tag
    6) build $objPath;; #打包
    7) checkoutIndex ;; #还原本地没有提交的修改
    *) csEcho ;;
    esac
    echo
}

readCfgFun(){
    cat ${textPath} | while read c1 c2 c3
    do

    if [ ${1} == $c1 ]
    then
    echo $c1 $c2 $c3

    # #git tag
    # echo $c2
    #show tag
    switchFun $c2 $c3
    return 1
    fi

    if [ $c1 == 0 ]
    then
    return 2
    fi
    done
}

appOrWeb(){
    echo 选择app or web：1.app 2.web "(注：app打包 记得改打包上传的路径 dirpath=/home/nfs_root/qa-web-pvc-5fe80612-e10b-4112-8509-511c5ba19127/www/p2native/pm1)"
    read chooseAW
    case $chooseAW in
    1)
    echo app
    buildBashPath=/e/bash/buildp2.sh
    ;;
    2)
    echo web
    buildBashPath=/e/bash/uploadp2web.sh
    ;;
    2)
    echo 没有 $chooseAW 这个选项
    appOrWeb
    ;;
    esac
    echo
}

# 读取项目tag配置
readFun(){
    echo 选择git操作：1拉取 2提交推送项目 3提交推送tag 4删除tag 5设置显示tag 6打包 7还原本地没有提交的修改
    read choose
    # echo qqqqqqqqqqqqqqqqqqqqqqqqqqq---$chooseCfg
    if [ $chooseCfg == 2 ] && [ $choose == 1 ]
    then
    echo p2项目拉取要选择分支还是主干: 1.主干 2.pm1 3.pm2 4.退出（任意键也是退出）
    read chooseBranchName
    case $chooseBranchName in
    1)
    branchName=1
    ;;
    2)
    branchName=pm1
    ;;
    3)
    branchName=pm2
    ;;
    *)
    echo 退出 chooseBranchName
    readFun
    ;;
    esac
    fi

    case $choose in
    1) echo 1拉取 ;;
    2) echo 2提交推送项目 ;;
    3) echo 3提交推送tag ;;
    4) echo 4删除tag ;;
    5) echo 5设置显示tag ;;
    6) echo 6打包
    # 如果是p1没有写打包
    if [ $chooseCfg == 1 ]
    then 
    echo p1没有写打包
    echo
    startMain
    else
    # app or web
    echo
    appOrWeb
    fi
    ;;

    7) echo 7还原本地没有提交的修改 ;;

    *)
    echo 选项不存在,
    readFun
    ;;

    esac
    echo
}

# 读取项目名字配置
readObjNameFun(){

    cat ${textNamePath} | while read c1 c2
    do
    objPath=${objParent}/$c2
    versionPath=$objPath/assets/resources/$c2/version/version.txt
    if [ ! -d $objPath ]
    then
    echo ----------------------------- objPath 路径不存在 ${objPath}
    return
    fi

    if [ $c1 == 0 ]
    then
    echo ----------完了-----------------$c1
    return
    fi

    # if [ ! -d $versionPath ]
    # then
    # cd /e/jinhuye/bqtpSlots/assets/resources/bqtpSlots/version
    # pwd
    # echo $versionPath
    # echo ----------------------------- versionPath 路径不存在 ${versionPath}
    # return
    # fi

    echo $c1 $c2  
    packageName=$c2

    readCfgFun $c1 $c2
    isHaveCfg=$?
    
    if [ $isHaveCfg == 2 ]
    then
    echo -----------------------------不存在 ${c1} 配置
    return
    fi

    done
}

# 选择工程项目父目录配置
chooseObjCfg(){
    echo 选择工程项目父目录配置：1.p1 2.p2
    read chooseCfg
    case $chooseCfg in
    1)
    echo p1
    textNamePath=/e/bash/GitPullObjNameP1BR.txt
    textPath=/e/bash/GitPull2_p1.txt
    objParent=/e/Git
    ;;
    2)
    echo p2
    textNamePath=/e/bash/GitPullObjNameP2LB.txt
    textPath=/e/bash/GitPull2_p2.txt
    objParent=/e/jinhuye
    ;;
    *)
    echo 选项不存在
    chooseObjCfg ;;
    esac
    echo
}

startMain(){
    chooseObjCfg
    readFun
    
    echo 读取配置
    echo
    OLD_IFS=$IFS
    IFS=" ",$'\t'$'\r'
    
    readObjNameFun
    # 如果是p1项目再运行一次readObjNameFun把拉霸一起修改了
    if [ $chooseCfg == 1 ]
    then 
    textNamePath=/e/bash/GitPullObjNameP1LB.txt
    textPath=/e/bash/GitPull2_p1.txt
    objParent=/e/Git/zhuang
    readObjNameFun
    fi
    
    IFS=$OLD_IFS
    echo
    
    echo 是否继续操作：1.继续 2.退出（任意键也是退出）
    read chooseCfg
    case $chooseCfg in
    1)
    #循环开始
    startMain 
    echo
    ;;
    *)
    echo 操作完了
    ;;
    esac
}

#开始
startMain

echo
echo "完了"