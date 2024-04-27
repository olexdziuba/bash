 color B0
@echo off
:Start2
cls 
goto start
:start
cls
title Generateur de mot de passe.
echo Ecrivez aide/help pour une commande d'aide.
echo.
echo.

echo           -----================================================-----
echo.
echo.

echo A --- 1 mot de passe
echo B --- 5 mots de passes
echo C --- 10 mots de passes
echo.
echo Entrez votre choix.
echo.
	
	
	

	set /p input= Choix:
if %input%==A goto A
if %input%==B goto B
if %input%==C goto C
if %input%==a goto A
if %input%==b goto B
if %input%==c goto C
if %input%==help goto aide
if %input%==aide goto aide
echo Choix invalide.
goto Start2
:aide
cls
echo           -----================================================-----
echo.
echo Ce programme va vous creer un ou des mots de passes.
echo Vous devriez noter le mot de passe que cette boite de commande va generer, 
echo ils seront effaces apres les operations.
echo.
echo           -----================================================-----
pause >nul
goto start
:A
cls
echo Votre mot de passe est : %random%
echo.
echo.
echo Maintenant choisissez une option :
echo.
echo.
				echo 1 --- Revenir au choix de mot de passes.
				echo.
				echo 2 --- Finir les operations.
				echo.
				echo 3 --- Creer un autre mot de passe.
				echo.
			
	set input=
	set /p input= Choix:
if %input%==1 goto Start2
echo.
if %input%==2 goto Exit
echo.
if %input%==3 goto A
echo Choix invalide.
pause
goto OPEN
:Exit
exit
:B
cls
echo Vos 5 mots de passes sont : %random%, %random%, %random%, %random%, %random%.
echo.
echo.
echo Maintenant choisissez une option :
echo.
echo.
				echo 1 --- Revenir au choix de mot de passes.
				echo.
				echo 2 --- Finir les operations.
				echo.
				echo 3 --- Creer 5 autres mots de passe.
				echo.
	set input=
	set /p input= Choix:
if %input%==1 goto Start2
echo.
if %input%==2 goto Exit
echo.
if %input%==3 goto B
echo.
echo Choix invalide.
pause
goto OPEN
:C
cls
echo Vos 10 mots de passes sont : %random%, %random%, %random%, %random%, %random%, %random%, %random%, %random%, %random%, %random%
echo.
echo.

echo Maintenant choisissez une option :
echo.
echo.
				echo 1 --- Revenir au choix de mot de passes.
				echo.
				echo 2 --- Finir les operations.
				echo.
				echo 3 --- Creer 10 autres mots de passe.
				echo.
	set input=
	set /p input= Choix:
if %input%==1 goto Start2
echo.
if %input%==2 goto Exit
echo.
if %input%==3 goto C
echo.
echo Choix invalide.
pause
goto OPEN
:OPEN
cls
echo                                 Choix invalide.
echo.
echo.
echo           -----================================================-----
echo.
echo.
echo.
echo.

echo Maintenant choisissez une option :
echo.
				echo 1 --- Revenir au choix de mot de passes.
				echo.
				echo 2 --- Finir les operations.
				echo.
				echo 3 --- Creer un/des autres mots de passe.
				echo.
	set /p input= Choix:
if %input%==1 goto Start2
if %input%==2 goto Exit
goto OPEN
