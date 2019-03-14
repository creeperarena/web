@echo off

set path=%LOCALAPPDATA%\Google\Cloud SDK\google-cloud-sdk\bin;%PATH%;

start "" http://localhost:8080

REM gcloud config set disable_prompts true

pushd ..
dev_appserver.py app.yaml
popd
