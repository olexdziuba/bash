#!/bin/bash

while true
do
    clear
    echo "==========================================="
    echo "======= MENU =============================="
    echo "==========================================="
    echo "1) Information sur un compte"
    echo "2) Information sur un groupe"
    echo "3) Afficher les comptes utilisateurs"
    echo "4) Afficher les comptes de service"
    echo "5) Gérer le mot de passe d’un compte"
    echo "6) Afficher les comptes verrouillés ou désactivés"
    echo "7) Activer, déverrouiller un compte ou modifier son mot de passe"
    echo "8) Quitter"
    echo ""
    read -p "Faire votre choix: " choice

    case $choice in
        1)
            echo "Vous avez choisi l'option 1. Information sur un compte"
            read -p "Saisir un compte : " compte

           # verification si le compte existe
           if id "$compte" >/dev/null 2>&1; then
              echo "Nom du compte : $compte"
              echo "UID : $(id -u "$compte")"
              echo "Son GID : $(id -g "$compte")"
              echo "Groupe primaire : $(id -gn "$compte")"
              echo "Groupes secondaires : $(id -Gn "$compte" | sed 's/ /, /g')"
              echo "Rép. Personnel : $(eval echo ~"$compte")"
              echo "Taille du rép. personnel : $(du -sh $(eval echo ~"$compte") | awk '{print $1}')"
          else
              echo "Ce compte n'existe pas."
          fi
            ;;
        2)
            echo "Vous avez choisi l'option 2. Information sur un groupe"
            
	    read -p "Saisir un groupe : " groupe

            # Vérification si le groupe existe
            if grep -q "^$groupe:" /etc/group; then
                echo "Groupe : $groupe"
                echo "ID du groupe : $(grep "^$groupe:" /etc/group | cut -d: -f3)"
#
                echo "Membres : $(grep "^$groupe:" /etc/group | cut -d: -f4)"
                echo "Primaire pour : $(grep "^$groupe:" /etc/group | cut -d: -f5)"
                echo "Secondaire pour : $(grep "^$groupe:" /etc/group | cut -d: -f6)"
                echo "Admin du groupe : $(grep "^$groupe:" /etc/group | cut -d: -f4 | grep -w admin | cut -d, -f1)"
                # verification password
                if chage -l "$groupe" | grep -q "password must be changed"; then
                    echo "Mot de passe : oui"
                else
                    echo "Mot de passe : non"
								fi
            else
                echo "Ce groupe n'existe pas."
            fi
            ;;

        3)
            echo "Vous avez choisi l'option 3. Afficher les comptes utilisateurs"
            echo "Comptes utilisateurs :"
            comptes=$(grep "/home/" /etc/passwd | cut -d: -f1)
            nombre_comptes=$(echo "$comptes" | wc -w)
            echo "$comptes"
            echo "Nombre total : $nombre_comptes"
            ;;
        4)
            echo "Vous avez choisi l'option 4. Afficher les comptes de service"
            comptes_service=$(grep -E "/sbin/nologin$|/bin/false$" /etc/passwd | cut -d: -f1)
            nombre_comptes_service=$(echo "$comptes_service" | wc -w)
            echo "Comptes de service :"
            echo "$comptes_service"
            echo "Nombre total : $nombre_comptes_service"
            ;;
        5)
            echo "Vous avez choisi l'option 5. Gérer le mot de passe d’un compte"
            read -p "Saisir un compte : " compte

            # Vérification si le compte existe
            if id "$compte" >/dev/null 2>&1; then
                echo "Définir le nombre minimum de jours entre chaque changement de mot de passe à MIN_DAYS :"
                read -p "MIN_DAYS : " min_days

                echo "Configurer le nombre maximum de jours pendant lesquels un mot de passe est valable :"
                read -p "MAX_DAYS : " max_days

                echo "Configurer le nombre de jours d'avertissement avant que le changement de mot de passe ne soit obligatoire :"
                read -p "WARNING_DAYS : " warning_days

                echo "Configurer le nombre de jours d'inactivité, après qu'un mot de passe ait dépassé la date de fin de validité, avant que le compte ne soit bloqué :"
                read -p "INACTIVE_DAYS : " inactive_days

                echo "Voulez-vous désactiver le compte ? (yes/no) :"
                read -p "Désactiver le compte : " disable_account

                if [[ $disable_account == "yes" ]]; then
                    chage -E 0 "$compte"   # Desactivation compte
                    echo "Le compte $compte a été désactivé."
                fi

                chage -m "$min_days" -M "$max_days" -W "$warning_days" -I "$inactive_days" "$compte"  # Налаштування параметрів пароля
                echo "Les paramètres du mot de passe pour le compte $compte ont été mis à jour."
            else
                echo "Ce compte n'existe pas."
            fi

            ;;
        6)
            echo "Vous avez choisi l'option 6. Afficher les comptes verrouillés ou désactivés"
            echo "Les comptes verrouillés ou désactivés (comptes d'utilisateurs) :"

    # List tous comptes utilisateurs
            users=$(grep 'home' /etc/passwd | cut -d: -f1)

    # Verification si compté est desactivé ou veruiller
            for user in $users
            do
        # Check si copmte est member de "service"
           if groups "$user" | grep -qw "service"; then
        continue
    fi

    status=$(passwd -S "$user" | awk '{print $2}')
    if [[ "L NP P" =~ $status ]]; then
        echo "$user"
    fi
done

    # Verification comptes bloquees
    locked_users=$(awk -F':' '($2 == "!!") {print $1}' /etc/shadow)
echo "$locked_users"

echo "Nombre total : $(echo "$users $locked_users" | wc -w)"
            ;;
        7)
            echo "Vous avez choisi l'option 7. Activer, déverrouiller un compte ou modifier son mot de passe"
            read -p "Saisir un compte : " username

    # Verification si compté existe
    if id "$username" >/dev/null 2>&1; then
        # Verification si compté bloquée
        if passwd -S "$username" | grep -q "L"; then
            echo "Le compte est verrouillé."
            read -p "Voulez-vous déverrouiller le compte ? (Yes/No) : " choice
            if [[ "$choice" =~ ^[Yy]$ ]]; then
                # Debloqer le compte
                passwd -u "$username"
                echo "Le compte a été déverrouillé avec succès."
            else
                echo "Le compte n'a pas été déverrouillé."
            fi
        else
            # Verification si compté est desactivée
            if passwd -S "$username" | grep -q "NP"; then
                echo "Le compte est désactivé."
                # Creation new passwort username+year
                new_password="${username}$(date +"%Y")"
                echo "Nouveau mot de passe généré pour confirmation : $new_password"
                read -p "Confirmez le nouveau mot de passe : " confirm_password
                if [ "$confirm_password" = "$new_password" ]; then
                    # Change password + ask change password next connection
                    echo "$username:$new_password" | chpasswd
                    chage -d 0 "$username"
                    echo "Le mot de passe a été modifié avec succès. Le compte a été activé."
                else
                    echo "Confirmation du mot de passe incorrecte. Le mot de passe n'a pas été modifié."
                fi
            else
                # Compte ni bloque ni desactivé = active
                echo "Le compte est actif."
                read -p "Voulez-vous changer le mot de passe ? (Yes/No) : " choice
                if [[ "$choice" =~ ^[Yy]$ ]]; then
                    # Creation new password  username+year
                    new_password="${username}$(date +"%Y")"
                    echo "Nouveau mot de passe généré pour confirmation : $new_password"
                    read -p "Confirmez le nouveau mot de passe : " confirm_password
                    if [ "$confirm_password" = "$new_password" ]; then
                        # Change password + ask change password next connection
                        echo "$username:$new_password" | chpasswd
                        chage -d 0 "$username"
                        echo "Le mot de passe a été modifié avec succès. Le compte a été activé."
                    else
                        echo "Confirmation du mot de passe incorrecte. Le mot de passe n'a pas été modifié."
                    fi
                  fi
                fi
              fi
          else
            echo "Ce compte n'existe pas."
        fi
            
            ;;
        8)
            echo "Vous avez choisi l'option 8. Quitter"
            break
            ;;
        *)
            echo "Choix invalide. Veuillez sélectionner une option valide."
            ;;
    esac

    read -p "Appuyez sur Entrée pour continuer..."
done
