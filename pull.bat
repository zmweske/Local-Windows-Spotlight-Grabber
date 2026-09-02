: Written by https://github.com/zmweske/Local-Windows-Spotlight-Grabber
@echo off

REM ------------------------------------------------------------------------------
echo Creating dirs...

REM setup location
SET "DIRECTORY=%USERPROFILE%\Pictures"
SET "LOCATION=Lock Screens\"

cd "%DIRECTORY%"
if not exist "%LOCATION%" 		mkdir "%LOCATION%"
if not exist "%~dp0\imgInfo.bat" 	move "%~dp0\imgInfo.bat" "%LOCATION%"

cd "%LOCATION%"
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
@copy "%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*" "temp\" >nul 2>nul
ren "temp\*" *.jpeg

REM copy windows spotlight to temp
for /r "%LocalAppData%\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\LocalCache\Microsoft\IrisService" %%F in (*) do (
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
for /F %%i in ('dir /b /a "."') do (
	REM echo if you see this the folder is NOT empty
	for /f %%f in ('dir /b .') do @(
		REM echo %%f
		REM for /f "delims=? tokens=2" %%a in ('call ..\toolTipInfo.bat %%f ^|find "Dimensions:"')  do (
		@for /f "delims=" %%a in ('call ..\imgInfo.bat %%f')  do (
			REM echo %%a
			@if "%%a" == "1920 x 1080" @move %%f ..\horizontal\
			@if "%%a" == "3840 x 2160" @move %%f ..\large\
			@if "%%a" == "1080 x 1920" @move %%f ..\vertical\
		)
	)
)



REM PAUSE
REM ------------------------------------------------------------------------------
echo Moving leftovers to dump dir...

cd ..
for /F %%i in ('dir /b /a "temp"') do (
	@move "temp\%%i" "dump\"
)

rmdir "temp"
REM CALL explorer.exe .
echo Done

