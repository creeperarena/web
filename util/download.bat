@echo off

REM =================================
goto :main

REM =================================
:BASENAME
set %2=%~nx1

exit /b

REM =================================
:PATHNAME
set %2=%~p1

exit /b

REM =================================
:main

REM =================================
chcp 950

REM =================================
set path=%LOCALAPPDATA%\Google\Cloud SDK\google-cloud-sdk\platform\google_appengine;%PATH%;

REM =================================
call config.bat

REM =================================
call :PATHNAME %0 BASE
call :PATHNAME %BASE:~0,-1% BASE
call :BASENAME %BASE:~0,-1% BASE

REM =================================
echo appcfg.py -A %BASE% download_app %BASE%
appcfg.py -A %BASE% download_app %BASE%
