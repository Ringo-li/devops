:: bat���Ϊʱ��UTF-8����ΪANSI ��ʽ�����ɽ����������������

:: �жϵ�д��

:: @if %errorlevel%==0 (
:: echo good log
:: ) else (
:: echo. fail log
:: 
:: )

:: @echo off ��ʾ���������Ļ����@��ʾ�����Ҳ�����

:: echo.���Ի��У����磺echo.>>C:\Windows\System32\drivers\etc\hosts

:: pause��ʾ�����������


:: dos�е�sleep��timeout /t 3

:: dos�е��˳�����exit \d 1

@echo off

echo "�һ�����Ա�������"
echo "��ע�����ɱ�������ʾ��һ��Ҫ�����ýű����ڵ�һ������ʱִ��"

echo. & pause

TYPE C:\Windows\system32\drivers\etc\hosts |findstr "www.yycc.com" >nul
if %errorlevel% equ 0 (
echo �Ѿ��޸Ĺ���
timeout /t 3
exit /b 0
) else (
echo ��ʼ�޸�hosts
)

xcopy C:\Windows\system32\drivers\etc\hosts C:\Windows\system32\drivers\etc\hostsbakup\ /y >nul

if %errorlevel%==0 (
:: ����
echo.>>C:\Windows\System32\drivers\etc\hosts
echo.>>C:\Windows\System32\drivers\etc\hosts

echo 220.181.57.218 www.yycc.com >>C:\Windows\System32\drivers\etc\hosts
echo 220.181.57.218 www.yycc.com >>C:\Windows\System32\drivers\etc\hosts

echo hosts�ļ��޸����

ipconfig /flushdns

echo ˢ��DNS���

echo. & pause

timeout /t 3
) else (
echo �Թ���Ա�������
timeout /t 3
exit \d 1

)
