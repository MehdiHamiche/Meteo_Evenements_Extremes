import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/preferencesPartagees.dart';

class Nuage extends StatefulWidget {
  const Nuage({super.key});

  @override
  State<Nuage> createState() => _NuageState();
}

class _NuageState extends State<Nuage> {
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
