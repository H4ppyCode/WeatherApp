![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)

# project_weather

WeatherApp By H4ppyCode

## Descritpion

L'Application Météo est une application Flutter qui permet aux utilisateurs d'obtenir des informations météorologiques actuelles et prévisionnelles pour différentes localisations. L'application utilise plusieurs services pour récupérer et afficher les données météorologiques, les informations de date et d'heure, ainsi que les informations sur le fuseau horaire.

## Fonctionnalités 

- Affichage des conditions météorologiques actuelles.
- Prévisions météorologiques en temps réel.
- Informations sur la date et l'heure actuelles.
- Information partout dans le monde.
  
Affichage du fuseau horaire correspondant à la localisation sélectionnée.

## Structure du projet 

Voici un aperçu des fichiers principaux du projet et de leur rôle :

main.dart
Le point d'entrée principal de l'application. Ce fichier configure l'application et initialise la page d'accueil.

homePage.dart
Contient la définition de la page d'accueil de l'application. C'est ici que les différentes informations météorologiques et temporelles sont affichées à l'utilisateur.

weather_model.dart
Définit le modèle de données pour les informations météorologiques. Ce fichier contient les classes nécessaires pour gérer et structurer les données météo.

weather_main_condition.dart
Gère les principales conditions météorologiques. Ce fichier est responsable de définir les différents types de conditions météo que l'application peut afficher.

weather_service.dart
Service qui récupère les données météorologiques depuis une API tierce. Ce fichier contient les fonctions nécessaires pour faire des appels réseau et traiter les réponses de l'API.

date-hours_service.dart
Service qui fournit les informations sur la date et l'heure actuelles. Ce fichier permet de récupérer et de formater les informations temporelles pour les afficher dans l'application.

timezone_service.dart
Service qui gère les informations de fuseau horaire. Ce fichier permet de récupérer et d'afficher le fuseau horaire correspondant à la localisation de l'utilisateur.

## Installation 

Prérequis
Flutter SDK
Un émulateur ou un appareil physique pour tester l'application
Installation
Clonez ce dépôt :

git clone <url_du_dépôt>
Accédez au répertoire du projet :
cd weather_app
Installez les dépendances :
flutter pub get
Exécution
Pour exécuter l'application sur un émulateur ou un appareil connecté :

bash
Copier le code
flutter run
Utilisation
Ouvrez l'application.
Autorisez l'accès à la localisation si demandé.
Consultez les informations météorologiques et temporelles affichées sur l'écran d'accueil.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
