import 'package:flutter/material.dart';

// La classe ClientDrawer est un widget Stateless représentant un tiroir de navigation personnalisé.
class ClientDrawer extends StatelessWidget {
  const ClientDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Le widget Drawer crée un tiroir de navigation latéral.
    return Drawer(
      // Le contenu du tiroir est une ListView contenant plusieurs éléments.
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // L'en-tête du tiroir, généralement utilisé pour afficher un titre ou un logo.
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            // Le texte dans l'en-tête du tiroir.
            child: Text(
              'Custom Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Élément de liste représentant une option dans le tiroir (par exemple, "Home").
          ListTile(
            // Icône à gauche de l'option.
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () {
              // Naviguer vers l'écran d'accueil et fermer le tiroir.
              Navigator.pop(context);
            },
          ),
          // Élément de liste représentant une autre option dans le tiroir (par exemple, "Settings").
          ListTile(
            // Icône à gauche de l'option.
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            // Action à effectuer lorsque l'option est sélectionnée (par exemple, naviguer vers l'écran des paramètres).
            onTap: () {
              // Naviguer vers l'écran des paramètres et fermer le tiroir.
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}