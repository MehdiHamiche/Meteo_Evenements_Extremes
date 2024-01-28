import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/donneesSeisme.dart';

class InfoSeisme extends StatefulWidget {
  const InfoSeisme({super.key});

  @override
  State<InfoSeisme> createState() => _InfoSeismeState();
}

class _InfoSeismeState extends State<InfoSeisme> {
  late List<Seisme> earthquakes;
  bool enChargement = false;

  @override
  void initState() {
    super.initState();
    recupDonneesSeisme();
  }

  Future<void> recupDonneesSeisme() async {
    setState(() {
      enChargement = true;
    });
    final response = await http.get(Uri.parse(
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&eventtype=earthquake&orderby=time&minmag=5&limit=100'));
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

                  title: Text('Magnitude: ${earthquakes[index].mag}'),
                  subtitle: Text(earthquakes[index].place),
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

class EcranSeismeDetail extends StatelessWidget {
  List<Seisme>? seisme;
  int index;

   EcranSeismeDetail({super.key, required this.seisme,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails des données'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Magnitude: ${seisme?[index].mag}'),
            Text('Lieu: ${seisme?[index].place}'),
            Text(
                'Date et heure: ${DateTime.fromMillisecondsSinceEpoch(seisme![index].time)}'),


          ],
        ),
      ),
    );
  }
}

class Seisme {
  final double mag;
  final String place;
  final int time;
  final String? url;

  Seisme({
    required this.mag,
    required this.place,
    required this.time,
    this.url,
  });

  factory Seisme.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'];
    return Seisme(
      mag: properties['mag'].toDouble(),
      place: properties['place'],
      time: properties['time'],
      url: properties['url'],
    );
  }
}
