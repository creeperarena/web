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
set path=%LOCALAPPDATA%\Google\Cloud SDK\google-cloud-sdk\bin;%PATH%;

REM =================================
call config.bat

REM =================================
call :PATHNAME %0 BASE
call :PATHNAME %BASE:~0,-1% BASE
call :BASENAME %BASE:~0,-1% BASE

REM =================================
pushd ..
echo gcloud app deploy cron.yaml -q --project %BASE%
gcloud app deploy cron.yaml -q --project %BASE%
popd
