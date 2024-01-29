import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/App/utils/image.dart';

// La classe Connexion est un StatefulWidget qui permet à l'utilisateur de se connecter en tant qu'invité

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section de l'en-tête avec une image et des textes
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Affiche une image de connexion chargée à partir du fichier 'login' dans 'image.dart'
                  Center(
                      child: Image.asset(
                    login,
                    height: 300,
                    width: 300,
                  )),
                  // Titre "Connexion" avec une police personnalisée
                  Text(
                    "Connexion",
                    style: GoogleFonts.readexPro(fontSize: 50),
                  ),
                  // Sous-titre "Bonjour" avec une police personnalisée
                  Text(
                    "Bonjour",
                    style: GoogleFonts.readexPro(color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              // Bouton "Connexion en tant qu'invité" avec une action de navigation
              Center(
                child: InkWell(
                  onTap: () {
                    // FirebaseAuth.instance.signInAnonymously().then((value) {
                    //   Navigator.popAndPushNamed(context, "/bottom");
                    // });

                    // Action à effectuer lorsqu'on appuie sur le bouton
                    // Dans ce cas, on navigue vers un autre écran avec la route "/bottem"
                    Navigator.popAndPushNamed(context, "/bottom");
                  },
                  child: Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text("Connexion en tant qu'ivité"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
