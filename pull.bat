: Written by https://github.com/zmweske/Local-Windows-Spotlight-Grabber
@echo off

REM %USERPROFILE%\Pictures fails sometimes when OneDrive is used, and the OneDrive folder can have inconsistent naming
for /f "tokens=*" %%a in ('dir /b /ad "%USERPROFILE%\OneDrive*"') do set TEST_DIR=%%a
if exist "%USERPROFILE%\%TEST_DIR%\Pictures" cd "%USERPROFILE%\%TEST_DIR%\Pictures"
if exist "%USERPROFILE%\Pictures" cd "%USERPROFILE%\Pictures"
REM ----- cd "[anywhere]" that you want to store the images


REM ------------------------------------------------------------------------------
echo Creating dirs...

REM ----- Set working dir name here
set "LOCATION=Lock Screens\"
if not exist "%LOCATION%" mkdir "%LOCATION%"
cd "%LOCATION%"

REM ensure imgInfo.bat is accessible
if not exist "imgInfo.bat" (
	if exist "%~dp0\imgInfo.bat" (copy "%~dp0\imgInfo.bat" ".\") ^
	else (
		echo Did not find helper script in %~dp0 nor working dir; downloading now...
		curl -L -O https://github.com/zmweske/Local-Windows-Spotlight-Grabber/raw/refs/heads/master/imgInfo.bat
	)
)
if not exist "dump\" 			mkdir "dump\"
if not exist "horizontal\" 		mkdir "horizontal\"
if not exist "vertical\" 		mkdir "vertical\"
if not exist "large\"	 		mkdir "large\"
if not exist "temp" 			mkdir "temp\"

REM testing
REM move "large\134321448492741245.jpeg" "temp\"
REM copy "dump\test1.jpeg" "temp\"


REM PAUSE
REM ------------------------------------------------------------------------------
echo Copying to temp dir...

REM copy lock screens to temp and rename
set "LOCK_SCREENS=%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
@copy "%LOCK_SCREENS%\*" "temp\" >nul 2>nul
ren "temp\*" *.jpeg

REM copy windows spotlight to temp
set "WIN_SPOTLIGHT=%LocalAppData%\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\LocalCache\Microsoft\IrisService"
for /r "%WIN_SPOTLIGHT%" %%F in (*) do (
    copy "%%F" "temp\" >nul 
	REM 2>nul
)


REM PAUSE
REM ------------------------------------------------------------------------------
echo Removing and logging duplicates...

cd "temp"
REM Deleting known files
for /f "delims=" %%f in (..\trash.txt) do @del "%%f" 2>nul
REM adding processed files to trash.txt
for /r %%i in (*) do echo %%i >> ..\trash.txt
echo Deleted duplicates...


REM PAUSE
REM ------------------------------------------------------------------------------
echo Sorting pictures by size...

REM already in temp dir, only perform copy if new items exist
for /f %%f in ('dir /b .') do @(
	REM echo %%f
	@for /f "delims=" %%a in ('call ..\imgInfo.bat %%f')  do (
		REM echo %%a
		if "%%a" == "1920 x 1080" (move %%f ..\horizontal\) ^
		else if "%%a" == "1080 x 1920" (move %%f ..\vertical\) ^
		else if "%%a" == "3840 x 2160" (move %%f ..\large\) ^
		else move %%f "..\dump\"
	)
)

cd ..
rmdir "temp"
echo Done
REM PAUSE
