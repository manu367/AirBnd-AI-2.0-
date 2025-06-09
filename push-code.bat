@echo off
setlocal EnableDelayedExpansion

:: Check if Git is installed
git --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Git is not installed. Please install Git first.
    pause
    exit /b
)

:: Check Git user.name
for /f "tokens=*" %%i in ('git config user.name') do (
    set USERNAME=%%i
)

IF "%USERNAME%"=="" (
    echo Git user.name not found. Setting Git identity...
    set /p GITNAME="Enter your Git user.name: "
    git config --global user.name "%GITNAME%"
) ELSE (
    echo Git user.name already set to: %USERNAME%
)

:: Check Git user.email
for /f "tokens=*" %%i in ('git config user.email') do (
    set EMAIL=%%i
)

IF "%EMAIL%"=="" (
    echo Git user.email not found. Setting Git identity...
    set /p GITEMAIL="Enter your Git user.email: "
    git config --global user.email "%GITEMAIL%"
) ELSE (
    echo Git user.email already set to: %EMAIL%
)

:: Stage all files
git add .

:: Take commit message input
set /p MSG="Enter commit message: "
git commit -m "%MSG%"

:: Set branch to main (skip if already on main)
git branch > temp_branch.txt
findstr /C:"* main" temp_branch.txt >nul
IF %ERRORLEVEL% NEQ 0 (
    git branch -M main
)
del temp_branch.txt

:: Push to origin main
git push origin main

echo.
echo Code pushed successfully!
pause
