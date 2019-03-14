@echo off
REM echo =================
REM echo !!! Run first !!!
REM echo -----------------
REM echo gcloud auth login
REM echo =================

set path=%LOCALAPPDATA%\Google\Cloud SDK\google-cloud-sdk\bin;%PATH%;
start /min "" gcloud config set account creeper.workshop@gmail.com ^&^& exit
