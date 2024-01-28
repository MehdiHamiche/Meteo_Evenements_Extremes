// Importation du package geolocator
import 'package:geolocator/geolocator.dart';

// Fonction asynchrone pour déterminer la position géographique
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Vérifier si les services de localisation sont activés
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Les services de localisation ne sont pas activés
    return Future.error('Les services de localisation sont désactivés.');
  }

  // Demander les permissions de localisation
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Les permissions de localisation sont refusées
      return Future.error('Les permissions de localisation sont refusées.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Les permissions de localisation sont refusées de manière permanente
    return Future.error(
        'Les permissions de localisation sont refusées de manière permanente, nous ne pouvons pas les demander.');
  }

  // Obtenir la position géographique actuelle de l'utilisateur
  return await Geolocator.getCurrentPosition();
}