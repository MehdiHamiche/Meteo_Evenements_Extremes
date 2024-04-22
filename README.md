# Application Meteo_Evenements_Extremes
Pour le module de programmation avancée, nous devions développer une application météo orientée évènement extrêmes. Notre application est basée sur Flutter et Dart
L'application utilise l'API OpenWeatherMap et l'API earthquake.usgs.gov pour récupérer les données météorologiques et sismologiques.
Ainsi à l'aide de ces API, notre application peut afficher les données météorologiques et sismologiques.

## Caractéristiques de l'application
- Affichage des données météorologiques (température, vitesse du vent, taux d'humidité,couverture nuageuse, pression atmosphérique) selon notre position actuelle
- Recherche des données météorologiques d'une ville
- Possibilité d'établir des seuils (température, vent, humidité, couverture nuageuse) selon les préférences de l'utilisateur
- Possibilité d'obtenir une liste détaillée des séismes dans le monde ainsi que leur magnitude

## Diagramme de classes
![diagrammeClasse](https://github.com/MehdiHamiche/Meteo_Evenements_Extremes/assets/117445844/4e327637-a48d-4117-94fe-89a66ac6172c)


## Capture d'écrans

![image](https://github.com/MehdiHamiche/Meteo_Evenements_Extremes/assets/117445844/79d8552b-36a6-4925-a350-3073cd7062b1)   ![image](https://github.com/MehdiHamiche/Meteo_Evenements_Extremes/assets/117445844/06039b4a-29ee-4bc5-a741-64552e5966de)

![image](https://github.com/MehdiHamiche/Meteo_Evenements_Extremes/assets/117445844/a334fa64-c972-4caa-82f5-20c87176aff6)   ![image](https://github.com/MehdiHamiche/Meteo_Evenements_Extremes/assets/117445844/f2c554b5-4d57-45ba-ae34-89f2e3759b4f)

![image](https://github.com/MehdiHamiche/Meteo_Evenements_Extremes/assets/117445844/8f3ffd31-7644-4056-8ab8-03aa54a11aa4)


## Comment lancer l'application

### Prérequis 
-Téléchargez et installez le SDK Flutter à partir du site officiel de Flutter : [flutter.dev](https://docs.flutter.dev/get-started/install/windows/mobile?)

-IDE : Pour le lancement de notre application nous avons utilisé Visual Studio Code et Android Studio  avec l'extension Flutter et Dart installée.

### 1. Cloner le dépôt
Clonez le dépôt github de l'application en exécutant la commande suivante depuis votre terminal
```
git clone https://github.com/MehdiHamiche/Meteo_Evenements_Extremes.git
```

### 2. Ouvrir le projet
Naviguez vers le répertoire application et ouvrez-le dans votre IDE (nous avons utilisé Visual Studio Code et Android Studio)


### 3. Téléchargement des dépendances
Exécutez la commande suivante depuis votre terminal afin de télécharger toutes les dépendances requises pour l'application Flutter 
```
flutter pub get
```

### 4. Lancer l'application
 - Depuis Android Studio : Lancez l'application avec le bouton "Run".

 - Depuis un terminal : Utilisez la commande suivante
```
flutter run
```

### 5. Visuel de l'application
Lorsque l'application sera lancée, elle sera exécutée sur un émulateur ou un appreil physique connecté.

## Membres du groupe
Mehdi Hamiche
Terry Tran




A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
