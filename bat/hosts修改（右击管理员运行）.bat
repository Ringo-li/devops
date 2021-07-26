:: bat另存为时，UTF-8保存为ANSI 格式。即可解决运行是乱码问题

:: 判断的写法

:: @if %errorlevel%==0 (
:: echo good log
:: ) else (
:: echo. fail log
:: 
:: )

:: @echo off 表示不输出到屏幕，加@表示连这句也不输出

:: echo.可以换行，例如：echo.>>C:\Windows\System32\drivers\etc\hosts

:: pause表示按任意键继续


:: dos中的sleep：timeout /t 3

:: dos中的退出程序：exit \d 1

@echo off

echo "右击管理员身份运行"
echo "请注意你的杀毒软件提示，一定要允许，该脚本仅在第一次配置时执行"

echo. & pause

TYPE C:\Windows\system32\drivers\etc\hosts |findstr "www.yycc.com" >nul
if %errorlevel% equ 0 (
echo 已经修改过了
timeout /t 3
exit /b 0
) else (
echo 开始修改hosts
)

xcopy C:\Windows\system32\drivers\etc\hosts C:\Windows\system32\drivers\etc\hostsbakup\ /y >nul

if %errorlevel%==0 (
:: 换行
echo.>>C:\Windows\System32\drivers\etc\hosts
echo.>>C:\Windows\System32\drivers\etc\hosts

echo 220.181.57.218 www.yycc.com >>C:\Windows\System32\drivers\etc\hosts
echo 220.181.57.218 www.yycc.com >>C:\Windows\System32\drivers\etc\hosts

echo hosts文件修改完成

ipconfig /flushdns

echo 刷新DNS完成

echo. & pause

timeout /t 3
) else (
echo 以管理员身份运行
timeout /t 3
exit \d 1

)
