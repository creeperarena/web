@echo off

pushd %~dp0

set SYNCPATH=rsync://home.changen.com.tw/NetBackup/rsync/update
call sync.this.bat sync.this.bat

set SYNCPATH=rsync://home.changen.com.tw/NetBackup/rsync/gcloud
call sync.this.bat *.bat

popd

