import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/preferencesPartagees.dart';

// La classe Temperature est un StatefulWidget qui permet la saisie de la température dans l'écran de Profil

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  // Contrôleur pour récupérer la valeur saisie dans le champ de texte
  TextEditingController temperatureController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  //Cette méthode est appelée après initState() si un objet State dépend d'un widget hérité qui a changé.
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature"),
      ),
      body: Column(
        children: [
          // Champ de texte pour saisir la température
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: temperatureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: 'Entrez la température',
              ),
            ),
          ),
          // Bouton "Enregistrez" pour enregistrer la température
          InkWell(
            onTap: () async {
              // Lorsque l'utilisateur appuie sur le bouton "Enregistré", la valeur de la température est sauvegardée localement.
               PreferencesPartageesManager().temperatureSauvegardee(temperatureController.text.trim());
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
