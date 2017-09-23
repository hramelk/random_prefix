@ECHO OFF

TITLE Remove random prefixes by Hramelk95
ECHO Batch script for removing the random prefixes by Hramelk95
ECHO Place this file in the folder with your ^<random^>__*.mp3 files and run it
ECHO The script will rename all your ^<random^>__*.mp3 files in that folder,
ECHO removing random numbers in their names
ECHO.

ECHO Press any key to start renaming
PAUSE >nul

CHCP 65001 >nul

IF NOT EXIST *__*.mp3 (
    ECHO.
    ECHO No *__*.mp3 files found
    GOTO :exitme
)

SET "Pattern=*__"
SET "Replace="
SET _NL=^


REM Two empty lines are required here

ECHO Removing random prefixes with underscores "*__"
ECHO.
SET "_count=0"
SET "_fail=0"
SET "_list="
SET "_temp="
FOR /f "eol=: delims=" %%# IN ('DIR /b *__*.mp3') DO (
    SETLOCAL DisableDelayedExpansion
        ECHO %%#
        SET "_temp=%%#"
        SETLOCAL EnableDelayedExpansion
            REN "!_temp!" "!_temp:%Pattern%=%Replace%!"
        ENDLOCAL
    ENDLOCAL
    ECHO.
    IF %ERRORLEVEL% GTR 0 (
        SET /a "_fail+=1"
        SET "_list=!_list!!_NL!%%a"
    ) ELSE (SET /a "_count+=1")
)
ECHO.
ECHO Rename completed, %_count% files renamed, %_fail% failed
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
