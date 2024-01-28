import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/earthquick.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late List<Earthquake> earthquakes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchEarthquakeData();
  }

  Future<void> fetchEarthquakeData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&eventtype=earthquake&orderby=time&minmag=5&limit=100'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
       final features = data['features'];


      setState(() {
        isLoading = false;
        earthquakes =
            List<Earthquake>.from(features.map((e) => Earthquake.fromJson(e)));
      });
    } else {
      isLoading = false;
      throw Exception('Failed to load earthquake data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquakes List'),
      ),
      body: isLoading
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
                        builder: (context) => EarthquakeDetailScreen(
                          earthquake: earthquakes,
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

class EarthquakeDetailScreen extends StatelessWidget {
  List<Earthquake>? earthquake;
  int index;

   EarthquakeDetailScreen({super.key, required this.earthquake,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Magnitude: ${earthquake?[index].mag}'),
            Text('Place: ${earthquake?[index].place}'),
            Text(
                'Time: ${DateTime.fromMillisecondsSinceEpoch(earthquake![index].time)}'),


          ],
        ),
      ),
    );
  }
}

class Earthquake {
  final double mag;
  final String place;
  final int time;
  final String? url;

  Earthquake({
    required this.mag,
    required this.place,
    required this.time,
    this.url,
  });

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'];
    return Earthquake(
      mag: properties['mag'].toDouble(),
      place: properties['place'],
      time: properties['time'],
      url: properties['url'],
    );
  }
}
