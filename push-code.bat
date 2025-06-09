@echo off
:: Check if there are changes
git status --porcelain > temp_status.txt

:: Count number of changed files
for /f %%A in ('find /v "" ^< temp_status.txt ^| find /c /v ""') do set count=%%A
del temp_status.txt

if "%count%"=="0" (
    echo No changes to commit.
) else (
    set /p msg=Enter commit message: 
    git add .
    git commit -m "%msg%"
    git push origin main
)

pause
