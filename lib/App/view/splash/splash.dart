import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/App/utils/image.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    // Cette méthode est appelée une fois lorsque le widget est créé.
    // Elle utilise Future.delayed pour retarder l'exécution d'une action après une courte durée.
    Future.delayed(const Duration(seconds: 3), () {
      // Après le délai, une vérification d'état est effectuée.
      // Selon la condition, l'application navigue vers différentes routes.

      // if (FirebaseAuth.instance.currentUser != null) {
      //   Navigator.pushNamed(context, "/bottem");
      // } else {
      //   Navigator.pushNamed(context, "/login");
      // }

      // Ici, l'application navigue vers la route "/login".
      Navigator.pushNamed(context, "/login");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     // Obtient la hauteur et la largeur de l'écran
    final h = MediaQuery.maybeOf(context)?.size.width;
    final w = MediaQuery.maybeOf(context)?.size.height;

    // Construit l'interface utilisateur de l'écran de lancement (splash screen)
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Utilisation d'une image de lancement (splash) chargée à partir du fichier 'image.dart'
          const Spacer(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(),
              child: Image.asset(splash),
            ),
          ),

          // Affiche un indicateur d'activité Cupertino (spinner)
          const Center(child: CupertinoActivityIndicator()),
          const Spacer()
        ],
      ),
    );
  }
}
