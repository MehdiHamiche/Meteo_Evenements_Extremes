import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Imporation de la gestion des préférences partagées depuis le fichier 'sharedPref.dart' dans le dossier 'utils'.
import '../../utils/sharedPref.dart';

class Wind extends StatefulWidget {
  const Wind({super.key});

  @override
  State<Wind> createState() => _WindState();
}

class _WindState extends State<Wind> {
  // Contrôleur pour le champ de texte permettant à l'utilisateur de saisir la vitesse du vent.
  TextEditingController windController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vent"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: windController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: 'Entrez vitesse vent',
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              // Lorsque l'utilisateur appuie sur le bouton "Set", la valeur du vent est sauvegardée localement.
              SharedPreferencesManager().saveWind(windController.text.trim());
            },
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Enregistrer",
                  style: GoogleFonts.readexPro(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
