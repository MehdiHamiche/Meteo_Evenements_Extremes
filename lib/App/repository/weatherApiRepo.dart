// Importation des packages nécessaires pour effectuer des requêtes HTTP et travailler avec JSON.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/App/model/weather.dart'; // Importation du modèle de données pour les conditions météorologiques.

import '../model/cityweather.dart'; // Importation du modèle de données pour les conditions météorologiques d'une ville.

// Classe responsable de l'interaction avec l'API météo pour récupérer les données.
class WeatherApiRepo {
  // Méthode pour obtenir les données météorologiques en fonction des coordonnées géographiques.
  Future<WeatherData?> getWeatherData(lat, lang) async {
    try {
      // Construction de l'URL de l'API météo avec les coordonnées géographiques, la clé d'API et l'unité métrique.
      String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lang&appid=de7b0e0799133898673b245deac4dc1e&units=metric";
      // Envoi de la requête HTTP de type GET à l'API.
      final response = await http.get(Uri.parse(url));
      // Vérification du code de statut de la réponse HTTP.
      if (response.statusCode == 200) {
        // Si la réponse est réussie (code 200), on décode le JSON et crée une instance de WeatherData.
        final body = response.body;
        final jsonData = jsonDecode(body);
        final data = WeatherData.fromJson(jsonData);
        return data;
      } else {
        // En cas d'échec de la réponse HTTP, une exception est levée.
        return throw Exception("Échec du chargement des données météorologiques");
      }
    } on Exception catch (e) {
      // En cas d'exception, affichage d'une information de débogage et retour null.
      debugPrint(e.toString());
      return null;
    }
  }

  // Méthode pour obtenir les données météorologiques d'une ville en fonction du nom de la ville et du code du pays.
  Future<CityWeatherData?> getWeatherDataByCity(String city, String countryCode) async {
    try {
      // Construction de l'URL de l'API météo avec le nom de la ville, le code du pays, la clé d'API et l'unité métrique.
      String url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city,$countryCode&appid=de7b0e0799133898673b245deac4dc1e&units=metric";
      // Envoi de la requête HTTP de type GET à l'API.
      final response = await http.get(Uri.parse(url));
      // Vérification du code de statut de la réponse HTTP.
      if (response.statusCode == 200) {
        // Si la réponse est réussie (code 200), on décode le JSON et crée une instance de CityWeatherData.
        final body = response.body;
        final jsonData = jsonDecode(body);
        final data = CityWeatherData.fromJson(jsonData);
        return data;
      } else {
        // En cas d'échec de la réponse HTTP, une exception est levée.
        return throw Exception("Échec du chargement des données météorologiques de la ville");
      }
    } catch (e) {
      // En cas d'exception, affichage d'une information de débogage et retour null.
      debugPrint(e.toString());
      return null;
    }
  }
}
