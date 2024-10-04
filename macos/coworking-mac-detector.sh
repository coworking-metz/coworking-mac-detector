#!/bin/bash

# Affichage du texte d'introduction
echo "        --------"
echo "     ------   -----"
echo "    -----   --.-----"
echo "   ------     -------"
echo "  -------      -------"
echo "  -----         ------"
echo "  ------        -----"
echo "   ------      ------"
echo "   ------- --------"
echo "    --    -------"
echo "    -"
echo "Coworking Metz - Le Poulailler"

# Affichage du texte de bienvenue
echo "Bonjour, ce script réalisé par l'association Coworking Metz va vous aider à ajouter cet appareil à votre compte."
echo "Appuyez sur entrée pour continuer, ou sur 'q' pour quitter..."

# Lecture de l'entrée utilisateur
read -r input
if [[ "$input" == "q" ]]; then
    exit 0
fi

# Récupération des adresses MAC et IP via ifconfig
mac_list=$(ifconfig | awk '/ether/{print $2}')
ip_list=$(ifconfig | awk '/inet /{print $2}' | grep -v '127.0.0.1')

# Affichage des adresses MAC détectées
if [[ -n "$mac_list" ]]; then
    echo "Détection terminée: $mac_list"
else
    echo "Aucune adresse MAC détectée sur cet appareil."
    exit 1
fi

echo "Voulez-vous ajouter l'adresse MAC de cet appareil à votre compte Coworker ?"
echo "Appuyez sur entrée pour continuer, ou sur 'q' pour quitter..."

# Lecture de l'entrée utilisateur
read -r input
if [[ "$input" == "q" ]]; then
    exit 0
fi

# Extraire la première adresse MAC
first_mac=$(echo "$mac_list" | head -n 1)

# Ouverture de l'URL avec la première adresse MAC
open "https://www.coworking-metz.fr/mon-compte/appareils/?adresse-mac=$first_mac"
