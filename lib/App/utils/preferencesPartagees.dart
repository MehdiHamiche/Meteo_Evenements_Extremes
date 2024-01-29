import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe pour la gestion des préférences partagées
class PreferencesPartageesManager {
  static PreferencesPartageesManager? _instance;
  late SharedPreferences _preferences;

  // Constructeur privé
  PreferencesPartageesManager._internal();

  // Méthode de fabrique pour obtenir une instance unique de la classe
  factory PreferencesPartageesManager() {
    if (_instance == null) {
      _instance = PreferencesPartageesManager._internal();
    }
    return _instance!;
  }

  // Initialiser les préférences partagées
  Future<void> preferencesPartageesInitiales() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Enregistrer la température dans les préférences partagées
  void temperatureSauvegardee(String temperature) {
    _preferences
        .setString('temperature', temperature)
        .then((value) => debugPrint("local data saved"));
  }

  // Enregistrer la vitesse du vent dans les préférences partagées
  void vitesseVentSauvegardee(String wind) {
    _preferences
        .setString('wind', wind)
        .then((value) => debugPrint("local data saved"));
  }

  // Enregistrer le nuage dans les préférences partagées
  void nuageSauvegardee(String cloud) {
    _preferences
        .setString('cloud', cloud)
        .then((value) => debugPrint("local data saved"));
  }

  // Enregistrer l'humidité dans les préférences partagées
  void humiditeSauvegardee(String humidity) {
    _preferences
        .setString('humidity', humidity)
        .then((value) => debugPrint("local data saved"));
  }

  // Effacer toutes les données des préférences partagées
  void effacerDonnees() {
    _preferences.clear().then((value) => debugPrint("local data Cleared"));
  }

  // Obtenir la température à partir des préférences partagées
  String getTemperature() {
    String? temperature = _preferences.getString('temperature');
    return temperature ?? '0';
  }

  // Obtenir la vitesse du vent à partir des préférences partagées
  String getVitesseVent() {
    String? wind = _preferences.getString('wind');
    return wind ?? '0';
  }

  // Obtenir le nuage à partir des préférences partagées
  String getNuage() {
    String? wind = _preferences.getString('cloud');
    return wind ?? '0';
  }

  // Obtenir l'humidité à partir des préférences partagées
  String getHumidite() {
    String? wind = _preferences.getString('humidity');
    return wind ?? '0';
  }
}
