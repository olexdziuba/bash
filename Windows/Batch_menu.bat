@echo off
rem Oleksandr Dziuba 04.04.2017
title Mon Bach file

rem menu principal
:menu
rem nettoyer ecran 
cls
rem ecrir Bonjour

echo                 Bonjour tout le monde!
rem saute une ligne
echo.
rem montre le date
 date /t
 rem montre le time
 time /t
 rem saute 2 lignes
 echo.
 echo.
 :: Title menu
echo                  Faites votre choix!
:: saute la ligne
echo.
:: Menu
echo 1 pour ouvrir Google maps
echo.
echo 2 pour ouvrir bureau a distance
echo.
echo 3 pour ouvrir dernier document Word
echo.
echo 4 pour ouvrir EXEL
echo.
echo 5 pour quitter le programme
echo.
echo 6 pour eteindre l'appareil
echo.

rem declarer tout les varables pour eviter error
set select=

set /p select=entrer votre choix (1, 2, 3, 4, 5 ou 6):

rem si variable different de 1-6 goto menu
if "%select%"=="" goto menu
if "%select%"==" " goto menu

rem if variable=X goto Y
if %select% equ 1 goto maps
if %select% equ 2 goto bureau
if %select% equ 3 goto word
if %select% equ 4 goto exel
if %select% equ 5 goto quitter
if %select% equ 6 goto fermer
goto menu

:: execution GOTO google maps sans pause, apres GOTO Menu

:maps
start https://www.google.ca/maps/

goto menu
:: execution Démarrer le bureau à distance sans pause, apres GOTO Menu
:bureau
start mstsc.exe
 
 goto menu
 :: execution ouvrir dernier document Word sans pause, apres GOTO Menu
:word
start winword.exe /mfile1
 
 goto menu
 :: execution start EXCELv sans pause, apres GOTO Menu
:exel
start EXCEL.exe

goto menu
:: execution quitter, fermer Batch file
:quitter
exit

rem execution fermer ordinateur et quitter batch file
:fermer
shutdown /s

