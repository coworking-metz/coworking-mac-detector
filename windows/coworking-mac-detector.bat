::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJE6B9n4zJwxbXg+LMmz3C7Qfpez++++EtkIPaPU2dovUzaeyIukd1kbrYpk/3XNUn4YBDRgVehe/awwgpnwMs3yAVw==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo        --------      
echo     ------   -----   
echo    -----   --.-----  
echo   ------     ------- 
echo  -------      -------
echo  -----         ------
echo  ------        ----- 
echo   ------      ------ 
echo   ------- --------   
echo    --    -------     
echo    -                 

echo Coworking Metz - Le Poulailler

:: Affichage du texte de bienvenue
echo Bonjour, ce script réalisé par l'association Coworking Metz va vous aider à ajouter cet appareil à votre compte.
echo Appuyez sur entrée pour continuer, ou sur 'q' pour quitter...

:: Attendre l'entrée utilisateur
set "input="
set /p "input=>> "
if /i "%input%"=="q" (
    exit /b
)

:: Initialisation des variables temporaires
set "mac_temp="
set "ip_temp="

:: Récupération des adresses MAC et IP via ipconfig
set "mac_list="
for /f "tokens=1,2 delims=:" %%a in ('ipconfig /all') do (
    set "line=%%a"
    set "value=%%b"
    
    :: Vérifier si la ligne correspond au format d'une adresse MAC (XX-XX-XX-XX-XX-XX)
    echo !value! | findstr /r /c:"[0-9A-F][0-9A-F]-[0-9A-F][0-9A-F]-[0-9A-F][0-9A-F]-[0-9A-F][0-9A-F]-[0-9A-F][0-9A-F]-[0-9A-F][0-9A-F]" >nul
    if !errorlevel! == 0 (
        :: Nettoyer l'adresse MAC
        set "mac_temp=!value: =!"
        
        :: Vérifier que l'adresse MAC a exactement 17 caractères
        if "!mac_temp:~0,17!" == "!mac_temp!" (
            echo .
        ) else (
            :: Si l'adresse MAC dépasse 17 caractères, l'ignorer
            set "mac_temp="
        )
    )

    :: Vérifier si la ligne correspond au format d'une adresse IP (IPv4), même si elle est suivie de texte
    echo !value! | findstr /r /c:"[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*" >nul
    if !errorlevel! == 0 (
        :: Extraire uniquement l'adresse IP avant tout texte supplémentaire
        for /f "tokens=1 delims= " %%b in ("!value!") do (
            set "ip_temp=%%b"
        )

        :: Si une adresse MAC a été précédemment détectée, associer la MAC à l'IP
        if defined mac_temp (
            if defined mac_list (
                set "mac_list=!mac_list!, !mac_temp!"
            ) else (
                set "mac_list=!mac_temp!"
            )
            :: Réinitialiser l'adresse MAC temporaire
            set "mac_temp="
        )
    )
)

:: Affichage des adresses MAC des adaptateurs actifs avec une adresse IP
if defined mac_list (
    echo Détection terminée: !mac_list!
) else (
    echo Aucune adresse MAC détectée sur cet appareil.
)

echo Voulez vous ajouter l'adresse MAC de cet appareil à votre compte Coworker ?
echo Appuyez sur entrée pour continuer, ou sur 'q' pour quitter...

:: Attendre l'entrée utilisateur
set "input="
set /p "input=>> "
if /i "%input%"=="q" (
    exit /b
)

:: Séparation de la première adresse MAC si la liste en contient plusieurs
for /f "tokens=1 delims=," %%a in ("!mac_list!") do set "first_mac=%%a"

:: Ouverture de l'URL avec la première adresse MAC
start https://www.coworking-metz.fr/mon-compte/appareils/?adresse-mac=!first_mac!

