import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/preferencesPartagees.dart';

// La classe Humidite est un StatefulWidget qui permet la saisie de l'humidité dans l'écran de Profil .
class Humidite extends StatefulWidget {
  const Humidite({super.key});

  @override
  State<Humidite> createState() => _HumiditeState();
}

// La classe _HumiditeState est l'état associé à Humidite.

class _HumiditeState extends State<Humidite> {
  TextEditingController humidite = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: humidite,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: "Entrer l'humidité",
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              // Lorsque l'utilisateur appuie sur le bouton "Enregistré", la valeur de l'humidité est sauvegardée localement.
              PreferencesPartageesManager().humiditeSauvegardee(humidite.text.trim());
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
