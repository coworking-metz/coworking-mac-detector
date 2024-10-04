#!/bin/bash

# Afficher le logo et message de bienvenue
echo "        --------      
     ------   -----   
    -----   --.-----  
   ------     ------- 
  -------      -------
  -----         ------
  ------        ----- 
   ------      ------ 
   ------- --------   
    --    -------     
    -                 
"

echo "Coworking Metz - Le Poulailler"

# Afficher le texte de bienvenue
echo "Bonjour, ce script réalisé par l'association Coworking Metz va vous aider à ajouter cet appareil à votre compte."
read -p "Appuyez sur entrée pour continuer, ou 'q' pour quitter... " input

if [[ "$input" == "q" ]]; then
    exit 0
fi

# Récupération des adresses MAC et IP
mac_list=$(ip link show | awk '/ether/ {print $2}')
ip_list=$(ip -4 -o addr show scope global | awk '{print $4}')

# Afficher les adresses MAC et IP détectées
if [[ -n "$mac_list" ]]; then
    echo "Adresses MAC détectées :"
    echo "$mac_list"
else
    echo "Aucune adresse MAC détectée."
fi

# Demander si l'utilisateur souhaite ajouter l'adresse MAC à son compte
read -p "Voulez-vous ajouter l'adresse MAC de cet appareil à votre compte Coworker ? Appuyez sur entrée pour continuer, ou 'q' pour quitter... " input

if [[ "$input" == "q" ]]; then
    exit 0
fi

# Utiliser la première adresse MAC détectée
first_mac=$(echo "$mac_list" | head -n 1)

# Tenter d'ouvrir l'URL avec xdg-open
url="https://www.coworking-metz.fr/mon-compte/appareils/?adresse-mac=$first_mac"
xdg-open "$url" 2>/dev/null

# Si xdg-open échoue, afficher simplement l'URL dans le terminal
if [[ $? -ne 0 ]]; then
    echo "Impossible d'ouvrir le navigateur automatiquement."
    echo "Veuillez cliquer sur ce lien pour ajouter l'adresse MAC : $url"
fi
