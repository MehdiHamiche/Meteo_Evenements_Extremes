import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/App/controller/meteoController.dart';
import 'package:weather/App/view/dashboard/accueil.dart';
import 'package:weather/App/view/dashboard/profil.dart';
import 'package:weather/App/view/dashboard/recherche.dart';

// La classe InferieurNav est un StatefulWidget qui représente la barre de navigation inférieure de l'application.
class InferieurNav extends StatefulWidget {
  const InferieurNav({super.key});

  @override
  State<InferieurNav> createState() => _InferieurNavState();
}

// La classe _InferieurNavState est l'état associé à InferieurNav.
class _InferieurNavState extends State<InferieurNav> {
  // Index de la page actuellement affichée dans la barre de navigation inférieure.
  int indexPageActuelle = 0;
  // Liste des écrans à afficher dans la barre de navigation inférieure.
  List<Widget> ecran = [
    Accueil(),
    Recherche(),
    Profil(),
  ];

  // Contrôleur pour gérer les données météorologiques (à travers le package Provider).
  MeteoController? _controller;
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
        child: ecran[indexPageActuelle],
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
        selectedIndex: indexPageActuelle,
        onDestinationSelected: (int index) {
          setState(() {
            // Mise à jour de l'index de la page actuelle lorsqu'une destination est sélectionnée.
            indexPageActuelle = index;
          });
        },
      ),
    );
  }
}
