::/
::  @product     qtVersioning
::  @file        build.bat
::  @author      Richard [https://github.com/im-richard/]
::
::  Called on build of the application to create the build.h header file
::/

@echo off & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: application configs
set cfg_app_title="qtVersioning"
set cfg_app_company="Oort Digital"
set cfg_app_website="http://company-url.com"
set cfg_app_copyright="Copyright (c) 2020 Your Company"
set cfg_app_author="Richard"
set cfg_app_license="GPL-3.0"
set cfg_app_vmajor=1
set cfg_app_vminor=1
set cfg_app_vmicro=0
set cfg_app_vbyear=2018

set cfg_debug_enabled=true
set cfg_inc_micro=true
set cfg_inc_build=true
set cfg_automate_micro=true
set cfg_resetmicro=true

set cfg_path_fol=C:\Users\%USERNAME%\Documents\admintool
set cfg_path_run="build.bat"
set cfg_path_src="build.h"
set cfg_path_txt="build_micro.txt"
set cfg_path_dat="build_data.txt"
set cfg_path_log="build_debug.txt"

:: --------------- NO NEED TO EDIT BELOW THIS LINE --------------- ::

:: open cached information and pull last compiled version
for /f "usebackq tokens=1-4 delims=." %%a in ( %cfg_path_fol%\%cfg_path_dat:"=% ) do (
	set _cache_Major=%%a
	set _cache_Minor=%%b
	set _cache_Micro=%%c
	set _cache_Build=%%d

	set _cache_Major=!_cache_Major:"=!
	set _cache_Minor=!_cache_Minor:"=!
	set _cache_Micro=!_cache_Micro:"=!
	set _cache_Build=!_cache_Build:"=!
)

set /p _storage_micro= <%cfg_path_fol%\%cfg_path_txt%
set /a _storage_micro= %_storage_micro%+1
set _storage_log=%cfg_path_fol%\%cfg_path_log:"=%

:: Used to modify the buildsrc file string replacing file extention with 
:: header name [automating the process] and to keep conformity
:: Ex: build.h -> build_h

set _FILTER_FROM=.
set _FILTER_TO=_

:: define compiled vars
set _writeto=%cfg_path_fol%\%cfg_path_src%
set _buildsrc=!cfg_path_src:%_FILTER_FROM%=%_FILTER_TO%!

:: automate strings
call :STR_UPPER _buildsrc
set _buildsrc

:: build information
set dt_cyear=%date:~10,4%
set dt_cday=%date:~7,2%
set dt_cmonth=%date:~4,2%

set /a "byear_calc=%dt_cyear%-%cfg_app_vbyear%"
set /a build_c1="byear_calc * 1000"

call :DINYEAR %dt_cday% %dt_cmonth% %dt_cyear% DayOrdinalNumber
set dt_cdon=%DayOrdinalNumber%
set /a "build=%build_c1%+%dt_cdon%"

:: ensure the build always ends up with 4 digits
:: <years_since_start><days_in_year:max[365]>
if %build% LSS 100 set build=0%build%
if %build% LSS 10 set build=0%build%
if %byear_calc% LSS 1 set build=0%build%

set APP_BUILD=%build:"=%

:: START OF HEADER ------------------------------------------
echo %_storage_micro% >%cfg_path_fol%\%cfg_path_txt:"=%
echo /** >%_writeto%
echo *  @package 	%cfg_app_title:"=% >>%_writeto%
echo *  @file 		%cfg_path_src:"=% >>%_writeto%
echo *  @author 		%cfg_app_author:"=% >>%_writeto%
echo * >>%_writeto%
echo *  Do not modify this file under any circumstance. It will be modified via %cfg_path_run% when application is built. >>%_writeto%
echo *  All manual adjustments will be overwritten. >>%_writeto%
echo */ >>%_writeto%
echo. >>%_writeto%
echo #ifndef %_buildsrc:"=% >>%_writeto%
echo #define %_buildsrc:"=% >>%_writeto%
echo. >>%_writeto%
echo #define APP_TITLE %cfg_app_title% >>%_writeto%
echo #define APP_COMPANY %cfg_app_company% >>%_writeto%
echo #define APP_WEBSITE %cfg_app_website% >>%_writeto%
echo #define APP_AUTHOR %cfg_app_author% >>%_writeto%
echo #define APP_LICENSE %cfg_app_license% >>%_writeto%
echo #define APP_COPYRIGHT %cfg_app_copyright% >>%_writeto%
echo #define APP_MAJOR %cfg_app_vmajor:"=% >>%_writeto%
echo #define APP_MINOR %cfg_app_vminor:"=% >>%_writeto%

:: Check use of VERSION MICRO

if defined cfg_inc_micro (
    if defined cfg_automate_micro (
        echo #define APP_MICRO %_storage_micro% >>%_writeto%
        set cfg_app_vmicro=%_storage_micro:"=%
    ) else (
        echo #define APP_MICRO %cfg_app_vmicro:"=% >>%_writeto%
        set cfg_app_vmicro=%cfg_app_vmicro:"=%
    )
)

:: Check use of VERSION BUILD

if defined cfg_inc_build (
    echo #define APP_BUILD %APP_BUILD:"=% >>%_writeto%
)

echo. >>%_writeto%
echo #endif // BUILD_H >>%_writeto%
echo %_storage_micro%

:: compile the entire version number
set _tostorage="%cfg_app_vmajor%.%cfg_app_vminor%.%cfg_app_vmicro%.%build%"
echo %_tostorage% >%cfg_path_fol%\%cfg_path_dat:"=%

CALL :SETLOG "BUILD COMPLETE v%_tostorage:"=%"

:: END OF HEADER ------------------------------------------

:: Transforms characters to uppercase
:STR_UPPER
for %%L IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO set %1=!%1:%%L=%%L!
goto :EOF

:: Transforms character to lowerbase
:STR_LOWER
for %%L IN (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO set %1=!%1:%%L=%%L!
goto :EOF

:: calculate days in a year
:DINYEAR day month year output_
setlocal enableextensions enabledelayedexpansion
if %2 LEQ 2 (
    set /a f=%1-1+31*^(%2-1^)
) else (
    set /a a=%3
    set /a b=!a!/4-!a!/100+!a!/400
    set /a c=^(!a!-1^)/4-^(!a!-1^)/100+^(!a!-1^)/400
    set /a s=!b!-!c!
    set /a f=%1+^(153*^(%2-3^)+2^)/5+58+!s!
)
set /a output_=%f%+1
endlocal & set "%4=%output_%" & goto :EOF

:SETLOG
FOR %%A in ("%~1") do (
    if defined cfg_debug_enabled (
        @echo DEBUG: %%~A
        if NOT EXIST "%_storage_log%" echo ------- LOG START ------- >%_storage_log%
        @echo [%date% @%time%] Debug: %%~A >> "%_storage_log%" 2>&1
    )
)
exit /b 0
