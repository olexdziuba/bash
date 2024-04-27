@echo off
REM Prise de Renseignements Utilisateur � cr�er
REM Oleksandr GR 1653
title Creation de comptes
mode con cols=100 lines=35
color 0A
:menu
cls

echo.
echo       Creation de comptes
echo       -------------------

:: saute la ligne
echo.
:: Menu
echo.
echo   1 pour cree le compte
echo.
echo   2 pour quitter le programme

echo.
rem declarer tout les varables pour eviter error
set select=
set /p select=entrer votre choix:
echo.
if "%select%"=="" goto menu
REM if variable=X goto Y
if %select% equ 1 goto creat
if %select% equ 2 goto quitter
goto menu

:creat
set /p NOM=Entrez le nom de compte

set /p PRE=Entrez le prenom et nom

set /p MDP=Entrez le mot de passe

set /p COM=Entrez description

set /p ACT=Active Yes/No

set /p EXP=Entrez le date d'expiration en fotmat YYYY-MM-JJ ou never

set /p CHPWD=Changement le mot de passe Yes/No
Net user %NOM% %MDP% /add /fullname:%"PRE"% /comment:"%"COM"%"" /active:%ACT% /expires:%EXP% /passwordchg:%CHPWD%
goto menu

:quitter
pause
exit