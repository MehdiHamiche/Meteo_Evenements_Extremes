import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/sharedPref.dart';

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  // Contrôleur pour récupérer la valeur saisie dans le champ de texte
  TextEditingController temperatureController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
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
              // Enregistrez la température dans les préférences partagées
               SharedPreferencesManager().saveTemperature(temperatureController.text.trim());
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
