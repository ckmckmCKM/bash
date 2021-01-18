
@echo off&setlocal enabledelayedexpansion
@REM git.exe路径 注意修改
set GIT="C:\Program Files\Git\bin\git.exe"
@REM 项目父文件目录 注意修改
set objGitPath=E:\Git\zhuang
@REM 项目txt文本配置 注意修改
set textNamePath=E:\Git\zhuang\GitPullObjName.txt
@REM 项目txt文本配置 注意修改
set textPath=E:\Git\zhuang\GitPull2.txt

goto CHOOSE_OBJ_PARENT

:CHOOSE_OBJ_PARENT
@REM 选择工程项目父目录
echo "choose P1BR(1) , P1LB(2) , P2LB(3), exit(4)"
set /p choose=
echo %choose%
echo.

if "%choose%"=="1" (
set objGitPath=E:\Git
set textNamePath=E:\Git\zhuang\GitPullObjNameP1BR.txt
set textPath=E:\Git\zhuang\GitPull2.txt
)

if "%choose%"=="2" (
set objGitPath=E:\Git\zhuang
set textNamePath=E:\Git\zhuang\GitPullObjNameP1LB.txt
set textPath=E:\Git\zhuang\GitPull2.txt
)

if "%choose%"=="3" (
set objGitPath=E:\jinhuye
set textNamePath=E:\Git\zhuang\GitPullObjNameP2LB.txt
set textPath=E:\Git\zhuang\GitPull2.txt
)

if "%choose%"=="4" (
  exit
)



goto START

:START
set /a index=1
set /a index1=1
set end="0"
goto CHOOSE


:NEXT
for /f "skip=%index1% tokens=1,2* delims=, " %%i in (!textNamePath!) do (
    if "%%i"==%end% (
      echo.
      echo "ObjGit over11111"
      @REM pause
      @REM exit
      goto CHOOSE_OBJ_PARENT
    )
    @REM echo %%i
    echo %%j
    @REM echo "hhhhhhhhhhh"
    @REM 项目中文名字
    set objZhName=%%i
    @REM 项目名字
    set objName=%%j
    set /a index1+=1
    echo %index1%
    echo.
    goto SET_TEXT
)
echo "cccccccc"
pause
exit

:SET_TEXT
for /f "skip=%index% tokens=1,2,3* delims=, " %%i in (!textPath!) do (
    if "%%i"==%end% (
      echo %textNamePath%
      echo %textPath% "no have" %objName%
      pause
      @REM exit
      echo.
      goto CHOOSE_OBJ_PARENT
    )
    @REM 版本号
    set ObjGit=%%j
    @REM 日志
    set record=%%k
    @REM @REM 手动修改日志 %%j
    if "%choose%"=="3" (
      set record=sit
    )
    @REM set /a index+=1
    @REM echo %index%
    if "%%i"=="%objZhName%" (
      @REM echo "fffffffffffff"
      @REM echo %%i
      echo %%j
      echo %%k
      echo.
      goto GIT
    )
)


:GIT
set objPath=%objGitPath%\%objName%
@REM 版本号路径
set versionPath=%objPath%\assets\resources\%objName%\version\version.txt
echo %versionPath%
if not exist %objPath% (
        echo %objPath%
        echo "error lu jing cuo wu"
        pause
        goto CHOOSE_OBJ_PARENT
    )

for /f "delims=" %%i in ("%objPath%") do (
  set DiskName=%%~di
  @REM echo %%~di
  )

@REM 打开输入路径
echo %DiskName%
echo %objPath%
%DiskName%
cd %objPath%

@REM 根据选择跳转拉取ObjGit还是上传ObjGit
if "%choose%"=="1" (
  goto PULLGIT
)

if "%choose%"=="2" (
  goto PUSHGIT
)

if "%choose%"=="3" (
  goto PUSHTAG
)

if "%choose%"=="4" (
  goto CLEARTAG
)

if "%choose%"=="5" (
  goto SET_SHOW_TAG
)


:PULLGIT
@REM 拉取ObjGit
@REM %GIT% pull
echo.
goto NEXT


@REM :PUSHGIT
@REM @REM 提交ObjGit
@REM %GIT% add %objPath%
@REM %GIT% commit -m %record%
@REM %GIT% push
@REM echo.
@REM goto NEXT


@REM :PUSHTAG
@REM @REM 提交tag
@REM echo PUSHTAG
@REM %GIT% tag -a %ObjGit% -m  %record%
@REM %GIT% push origin %ObjGit%
@REM goto NEXT


@REM :CLEARTAG
@REM @REM 删除tag
@REM %GIT% tag -d %ObjGit%
@REM %GIT% push origin :%ObjGit%
@REM goto NEXT


@REM :SET_SHOW_TAG
@REM echo %record%>!versionPath!
@REM goto NEXT


:CHOOSE
@REM 选择拉取还是提条ObjGit
echo "choose pull(1) , pushObj(2) , pushTag(3) , clearTag(4) , setShowTag(5) , exit(6)"
set /p choose=
echo %choose%
echo.
if "%choose%"=="1" (
  echo "PULLGIT"
  goto NEXT
)

if "%choose%"=="2" (
  echo "PUSHGIT"
  goto NEXT
)

if "%choose%"=="3" (
  echo "PUSHTAG"
  goto NEXT
)

if "%choose%"=="4" (
  echo "CLEARTAG"
  goto NEXT
)

if "%choose%"=="5" (
  echo "SET_SHOW_TAG"
  goto NEXT
)

if "%choose%"=="6" (
  exit
)

echo "choose error"
pause
goto CHOOSE


pause
exit