import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/preferencesPartagees.dart';

// La classe Nuage est un StatefulWidget qui permet la saisie de la couverture nuageuse dans l'écran de Profil

class Nuage extends StatefulWidget {
  const Nuage({super.key});

  @override
  State<Nuage> createState() => _NuageState();
}

class _NuageState extends State<Nuage> {
  // Contrôleur pour récupérer la valeur saisie dans le champ de texte
  TextEditingController nuage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: nuage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: 'Enter cloud',
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              // Lorsque l'utilisateur appuie sur le bouton "Enregistré", la valeur de la couverture nuageuse est sauvegardée localement.
              PreferencesPartageesManager().nuageSauvegardee(nuage.text.trim());
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
                  "Enregistré",
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
