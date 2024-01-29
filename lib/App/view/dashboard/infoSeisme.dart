import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// La classe InfoSeisme est un StatefulWidget qui de gérer les informations sismologiques dans l'écran de Profil
// InfoSeisme responsable de l'interaction avec l'API séisme pour récupérer les données.

class InfoSeisme extends StatefulWidget {
  const InfoSeisme({super.key});

  @override
  State<InfoSeisme> createState() => _InfoSeismeState();
}

// La classe _InfoSeismeState est l'état associé à InfoSeisme.

class _InfoSeismeState extends State<InfoSeisme> {
  late List<Seisme> earthquakes;
  bool enChargement = false;

  @override
  void initState() {
    super.initState();
    recupDonneesSeisme();
  }

  //Méthode qui récupère les données  sismologiques avec l'API earthquake

  Future<void> recupDonneesSeisme() async {
    setState(() {
      enChargement = true;
    });
    // Envoi de la requête HTTP de type GET à l'API.
    final response = await http.get(Uri.parse(
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&eventtype=earthquake&orderby=time&minmag=5&limit=100'));
    // Vérification du code de statut de la réponse HTTP.
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
       final features = data['features'];


      setState(() {
        enChargement = false;
        earthquakes =
            List<Seisme>.from(features.map((e) => Seisme.fromJson(e)));
      });
    } else {
      enChargement = false;
      throw Exception('Echec du chargement des données sismologiques');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //En tête de la page de la liste des séismes
        title: const Text('Liste des séismes'),
      ),
      body: enChargement
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: earthquakes.length,
              itemBuilder: (context, index) {
                return ListTile(

                  title: Text('Magnitude: ${earthquakes[index].magnitude}'),
                  subtitle: Text(earthquakes[index].lieu),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EcranSeismeDetail(
                          seisme: earthquakes,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

// La classe InfoSeisme est un StatelessWidget qui affiche les données sismologiques détaillées pour chaque ville

class EcranSeismeDetail extends StatelessWidget {
  List<Seisme>? seisme;
  int index;

   EcranSeismeDetail({super.key, required this.seisme,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //En tête de la page des données détaillées
      appBar: AppBar(
        title: const Text('Détails des données'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //Affichage de la magnitude, lieu, la date et l'heure
          children: [
            Text('Magnitude: ${seisme?[index].magnitude}'),
            Text('Lieu: ${seisme?[index].lieu}'),
            Text(
                'Date et heure: ${DateTime.fromMillisecondsSinceEpoch(seisme![index].date)}'),
          ],
        ),
      ),
    );
  }
}

//Classe représentant les informations sur les séismes
class Seisme {
  final double magnitude;
  final String lieu;
  final int date;
  final String? url;

  Seisme({
    required this.magnitude,
    required this.lieu,
    required this.date,
    this.url,
  });
// Méthode de fabrique pour créer une instance de Séisme à partir d'un JSON.
  factory Seisme.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'];
    return Seisme(
      magnitude: properties['mag'].toDouble(),
      lieu: properties['place'],
      date: properties['time'],
      url: properties['url'],
    );
  }
}
