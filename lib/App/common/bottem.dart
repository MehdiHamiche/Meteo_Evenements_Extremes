import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/App/controller/weather.dart';
import 'package:weather/App/view/dashboard/home.dart';
import 'package:weather/App/view/dashboard/profile.dart';
import 'package:weather/App/view/dashboard/search.dart';

// La classe BottemNav est un StatefulWidget qui représente la barre de navigation inférieure de l'application.
class BottemNav extends StatefulWidget {
  const BottemNav({super.key});

  @override
  State<BottemNav> createState() => _BottemNavState();
}

// La classe _BottemNavState est l'état associé à BottemNav.
class _BottemNavState extends State<BottemNav> {
  // Index de la page actuellement affichée dans la barre de navigation inférieure.
  int currentPageIndex = 0;
  // Liste des écrans à afficher dans la barre de navigation inférieure.
  List<Widget> screen = [
    Home(),
    Search(),
    Profile(),
  ];

  // Contrôleur pour gérer les données météorologiques (à travers le package Provider).
  WeatherController? _controller;
  @override
  void initState() {
    // Initialisation du contrôleur de données météorologiques lors de la création de l'état.
    _controller = Provider.of(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le corps de l'écran est centré et affiche la page actuelle de la barre de navigation inférieure.
      body: Center(
        child: screen[currentPageIndex],
      ),
      // La barre de navigation inférieure utilisant le widget NavigationBar.
      bottomNavigationBar: NavigationBar(
        // Utilisation de la classe NavigationBar pour la barre de navigation inférieure.
        destinations: const [
          // Définition des destinations de navigation.
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        // Index de l'élément actuellement sélectionné dans la barre de navigation inférieure.
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            // Mise à jour de l'index de la page actuelle lorsqu'une destination est sélectionnée.
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
