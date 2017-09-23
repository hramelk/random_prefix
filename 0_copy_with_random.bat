@ECHO OFF

TITLE Copy with random prefix by Hramelk95
ECHO Batch script for copying files with random number prefix by Hramelk95
ECHO Place this file in the folder with you .mp3 files and run it
ECHO The script will create a new filder named random_^<DATE^>_^<TIME^>
ECHO and copy the files into it with new names
ECHO.

ECHO Press any key to start copying
PAUSE >nul

CHCP 65001 >nul

IF NOT EXIST *.mp3 (
    ECHO.
    ECHO No *.mp3 files found
    GOTO :exitme
)

SET "newFolderName=random_%DATE%_%TIME::=.%"
SET "newFolderName=%newFolderName: =%"
SET _NL=^


REM Two empty lines are required here

ECHO.
ECHO Creating folder
MD "%newFolderName%"
IF EXIST "%newFolderName%"\ (
    ECHO Folder %newFolderName% created
) ELSE (
    ECHO Folder was not created
    ECHO.
    GOTO :exitme
)

ECHO.
ECHO Copying files
ECHO.
SET "_count=0"
SET "_fail=0"
SET "_list="
SET "_temp="
FOR /f "eol=: delims=" %%a IN ('DIR /b *.mp3') DO (
    SETLOCAL DisableDelayedExpansion
        ECHO %%a
        SET "_temp=%%a"
        SETLOCAL EnableDelayedExpansion
            COPY "!_temp!" "%newFolderName%\!random!__!_temp!"
        ENDLOCAL
    ENDLOCAL
    ECHO.
    IF %ERRORLEVEL% GTR 0 (
        SET /a "_fail+=1"
        SET "_list=!_list!!_NL!%%a"
    ) ELSE (SET /a "_count+=1")

)
ECHO.
ECHO Copy completed, %_count% files copied, %_fail% failed
ECHO.
IF %_fail% GTR 0 (
    SETLOCAL EnableDelayedExpansion
        ECHO Fails`
        ECHO !_list!
        ECHO.
    ENDLOCAL
)

:exitme
ECHO Press any key to exit the script
PAUSE >nul
EXIT /b 0
