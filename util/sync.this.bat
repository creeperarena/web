@echo off

REM =================================
goto main

REM =================================
:BASENAME
set %2=%~nx1

exit /b

REM =================================
:PATHNAME
set %2=%~p1

exit /b

REM =================================
:whereis
set %2=
for %%X in (%1) do (set %2="%%~$PATH:X")

exit /b

REM =================================
:RSYNC
call :PATHNAME %1 SUB
call :BASENAME "%SUB:~0,-1%" SUB
if "%SUB%" == "%BASE%" set SUB=
set options=-az --info=backup --backup --backup-dir='%CD:~0,2%/%backup_local_root%/%SUB%'

set NEWFILE="%SYNCPATH%/%SUB%/%~nx1"
set NEWFILE_UNC=%NEWFILE:/=\%
REM echo %NEWFILE_UNC%

set DST="/cygdrive/%~dp1"
set DST=%DST:\=/%
set DST=%DST::=%
REM echo %DST%
REM goto :EOF

IF EXIST %NEWFILE_UNC% (
    REM echo.
    echo Syncing %1 from UNC ...
    REM echo rsync %options% %NEWFILE% %DST%
    rsync %options% %NEWFILE% %DST% 2>nul | %GREP% 'backed up'
    REM rsync %options% %NEWFILE% %DST%
)

IF NOT "%SYNCPATH:rsync:=%" == "%SYNCPATH%" (
    echo Syncing %1 from RSYNC ...
    rsync %options% %NEWFILE% %DST% 2>nul | %GREP% 'backed up'
)

exit /b

REM =================================
:RSYNCEXT
pushd %~dp0
for /R %%x in (%1) do (
    IF EXIST "%%x" call :RSYNC "%%x"
)
popd

exit /b

REM =================================
:main
REM =================================
call :whereis grep.exe GREP
if [%GREP%] == [""] set GREP="C:\Program Files\Git\usr\bin\grep.exe"

REM =================================
call :PATHNAME %0 BASE
call :BASENAME "%BASE:~0,-1%" BASE

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%

set backup_remote_root=recycle/%MONTH%/%TODAY%/%BASE:/=\%
set backup_local_root=%backup_remote_root%

set options=-az --info=backup --backup --backup-dir='%CD:~0,2%/%backup_local_root%'

REM =================================
REM set SYNCFILES=sync.files.bat
IF DEFINED SYNCPATH (
    REM echo %SYNCPATH%
    REM call %SYNCFILES%
    REM set SYNCPATH=rsync://sita.ddns.net/NetBackup/rsync/update
    call :RSYNCEXT %1

REM =================================
    icacls "%cd%" /reset /t /c /l /q >nul
)

REM =================================
REM timeout 10
