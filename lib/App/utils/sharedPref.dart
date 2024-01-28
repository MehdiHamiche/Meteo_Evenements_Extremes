import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe pour la gestion des préférences partagées
class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  late SharedPreferences _prefs;

  // Constructeur privé
  SharedPreferencesManager._internal();

  // Méthode de fabrique pour obtenir une instance unique de la classe
  factory SharedPreferencesManager() {
    if (_instance == null) {
      _instance = SharedPreferencesManager._internal();
    }
    return _instance!;
  }

  // Initialiser les préférences partagées
  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Enregistrer la température dans les préférences partagées
  void saveTemperature(String temperature) {
    _prefs
        .setString('temperature', temperature)
        .then((value) => debugPrint("local data saved"));
  }

  // Enregistrer la vitesse du vent dans les préférences partagées
  void saveWind(String wind) {
    _prefs
        .setString('wind', wind)
        .then((value) => debugPrint("local data saved"));
  }

  // Enregistrer le nuage dans les préférences partagées
  void saveCloud(String cloud) {
    _prefs
        .setString('cloud', cloud)
        .then((value) => debugPrint("local data saved"));
  }

  // Enregistrer l'humidité dans les préférences partagées
  void saveHumidity(String humidity) {
    _prefs
        .setString('humidity', humidity)
        .then((value) => debugPrint("local data saved"));
  }

  // Effacer toutes les données des préférences partagées
  void clearData() {
    _prefs.clear().then((value) => debugPrint("local data Cleared"));
  }

  // Obtenir la température à partir des préférences partagées
  String getTemperature() {
    String? temperature = _prefs.getString('temperature');
    return temperature ?? '0';
  }

  // Obtenir la vitesse du vent à partir des préférences partagées
  String getWind() {
    String? wind = _prefs.getString('wind');
    return wind ?? '0';
  }

  // Obtenir le nuage à partir des préférences partagées
  String getCloud() {
    String? wind = _prefs.getString('cloud');
    return wind ?? '0';
  }

  // Obtenir l'humidité à partir des préférences partagées
  String gethumidity() {
    String? wind = _prefs.getString('humidity');
    return wind ?? '0';
  }
}
