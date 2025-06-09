@echo off
:: Check if there are changes
git status
set /p msg=Enter commit message: 
git add .
git commit -m "%msg%"
git push origin main
pause
