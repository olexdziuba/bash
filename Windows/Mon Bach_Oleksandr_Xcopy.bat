@echo off
rem Oleksandr groupe 1653
Title Mon Bach file 
mode con cols=100 lines=35
echo.

color 0A

:menu
rem nettoyer ecran 
cls
rem saute une ligne
echo.
rem montre le date
date /t
rem saute une ligne
echo.
rem montre le time
time /t
rem saute une ligne
echo.
rem ecrir Bienvenue
echo              _____________________________ 
echo             :                             :
echo             : Bienvenue a mon Batch file  :
echo             :_____________________________:
echo.

echo. 
echo                  Faites votre choix!
echo.

rem menu 
echo --------------------------------------------------------------------------
echo  "a" pour afficher uniquement les fichiers Word 
echo.
echo  "b" pour copier tous les fichiers Word dans le dossier backup 
echo.
echo  "c" pour supprimer les fichiers Word qui ont ete archives
echo.
echo  "d" pour deplacer tous les fichiers Word qui se trouveraient sur le bureau vers le repertoire "Mes Documents"
echo.
echo  "e" pour quitter le fichier de commandes 
echo.
echo  "f" pour fermer l'ordinateur avec un delai de 2 minutes
echo --------------------------------------------------------------------------
echo.
echo.

rem set+variable
set /p select=
set /p select=entrez votre choix (a, b, c, d, e ou f): 


rem si variable different xe a, b, c, d, e ou f goto menu
if "%select%"=="" goto menu
if "%select%"==" " goto menu
rem if variable equivalent XX goto YY
if /i %select% equ a goto afficher
if /i %select% equ b goto copy
if /i %select% equ c goto supprimer
if /i %select% equ d goto move
if /i %select% equ e goto quitter
if /i %select% equ f goto fermer
goto menu



rem execution afficher les documents avec pause
:afficher
dir /s %userprofile%\Documents\*.doc
pause
goto menu
rem execution copy: creation le  lecteur K:\ avec NET USE, copy les documents, deconnection du lecteur K:\ sans pause - apres directement au menu
:copy
Net use  K: \\P488EB5025-L208\Home_dir
xcopy /s /m %userprofile%\Documents\*.doc K:\Backup
Net use K: /delete

goto menu

rem execution supprimer 
:supprimer
del /s /A:-A %userprofile%\Documents\*.doc

goto menu

rem execution move + Provoque la demande de confirmation de remplacement de fichiers de destination existants /-Y

:move
move /-Y %userprofile%\desktops\*.doc %userprofile%\Documents\*.doc

goto menu

rem execution quitter et quitter batch file
:quitter
exit

rem execution fermer ordinateur avec un délai de 2 minutes et quitter batch file
:fermer
shutdown /s /t 120









