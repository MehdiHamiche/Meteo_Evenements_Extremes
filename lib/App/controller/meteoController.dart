import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/App/repository/meteoApiRepo.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/preferencesPartagees.dart';

// La classe MeteoController étend ChangeNotifier et agit comme un contrôleur pour la gestion des données météorologiques.
class MeteoController extends ChangeNotifier {
  MeteoController() {
    // Initialise la détermination de la position lors de la création du contrôleur.
    _determinerPosition();
  }

  // Booléen indiquant si la recherche est en cours.
  bool _estRecherche = false;
  bool get estRecherche => _estRecherche;

  // Getter et Setter pour la variable isSearch.
  set setEstRecherche(value) {
    _estRecherche = value;
    notifyListeners();
  }

  // Méthode asynchrone pour déterminer la position actuelle de l'utilisateur.
  Future<Position> _determinerPosition() async {
    // Vérifie si les services de localisation sont activés.
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Les services de localisation ne sont pas activés, ouvre les paramètres de l'application.
      openAppSettings();
      return Future.error('Les services de localisation sont désactivés.');
    }

    // Demande les permissions de localisation.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Les permissions de localisation sont refusées.
        return Future.error('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Les permissions de localisation sont refusées de manière permanente.
      return Future.error(
          'Les permissions de localisation sont refusées de manière permanente, nous ne pouvons pas demander les permissions.');
    }

    // Récupère la position actuelle de l'utilisateur.
    return await Geolocator.getCurrentPosition();
  }

  // Plugin pour les notifications locales.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Méthode pour afficher une notification locale.
  Future afficherNotification(String notify) async {
    try {
      // Initialisation des notifications locales.
      flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
      const AndroidInitializationSettings android =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: android);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Configuration du canal de notification Android.
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'canal à haute importance', // id
        'Notifications très importantes', // titre
        description:
            'Ce canal est utilisé pour les notifications importantes.', // description
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // Configuration des détails de la notification.
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance.max,
        priority: Priority.high,
        icon:
            '@mipmap/ic_launcher',
        playSound: true,
      ));

      // Affichage de la notification.
      await flutterLocalNotificationsPlugin.show(
        0,
        'Alerte $notify',
        '$notify  supérieure ou égale à la valeur enregistrée.',
        platformChannelSpecifics,
        payload: 'default',
      );
    } on Exception catch (e) {
      debugPrint("Erreur : ... $e");
    }
  }

  // checkValueAndNotify() async
  // {
  //   final dataTemp =  int.parse(SharedPreferencesManager().getTemperature()) ;
  //   final dataCloud = int.parse(SharedPreferencesManager().getCloud()) ;
  //   final dataWind = int.parse(SharedPreferencesManager().getWind());
  //   final dataHumidity = int.parse(SharedPreferencesManager().gethumidity());
  //   if(temp >= dataTemp)
  //     {
  //       debugPrint("Temp Alert Notify");
  //       showNotification("Temperature");
  //     }
  //   if(cloud >= dataCloud)
  //     {
  //       debugPrint("Cloud Alert Notify");
  //       showNotification("Cloud");
  //     }
  //   if(wind >=dataWind)
  //     {
  //       debugPrint("Wind Alert Notify");
  //       showNotification("Wind");
  //     }
  //   if(humi >=dataHumidity)
  //   {
  //     debugPrint("Humidity Alert Notify");
  //     showNotification("Humidity");
  //   }
  //
  //
  //
  // }

  // Méthode pour vérifier les valeurs météorologiques et afficher des notifications en cas de dépassement des seuils.
  afficherValeurEtNotifier() async {
    final PreferencesPartageesManager prefsManager = PreferencesPartageesManager();

    final int dataTemp = int.parse(prefsManager.getTemperature());
    final int dataCloud = int.parse(prefsManager.getNuage());
    final double dataCloud1 = double.parse(prefsManager.getNuage());
    final int dataWind = int.parse(prefsManager.getVitesseVent());
    final int dataHumidity = int.parse(prefsManager.getHumidite());
    final double dataHumidity1 = double.parse(prefsManager.getHumidite());



    debugPrint("Temp .. $nuage  .... $dataCloud");
    if (dataTemp != 0) {
      _verifierEtNotifier("Température", temperature, dataTemp);
    }
    if (nuage.runtimeType == int) {
      if (dataCloud != 0) {
        _verifierEtNotifier("Nuage", nuage, dataCloud);
      }
    } else if (nuage.runtimeType == double) {
      if (dataCloud != 0.0) {
        _verifierEtNotifier("Nuage", nuage, dataCloud);
      }
    }
    if (dataWind != 0) {
      _verifierEtNotifier("Vitesse du Vent", vitesseVent, dataWind);
    }

    if (humidite.runtimeType == int) {
      if (humidite != 0) {
        _verifierEtNotifier("Humidité", humidite, dataHumidity);
      }
    } else if (humidite.runtimeType == double) {
      if (humidite != 0.0) {
        _verifierEtNotifier("Humidité", humidite, dataHumidity1);
      }
    }
  }

  // Méthode pour vérifier une valeur spécifique et afficher une notification si elle dépasse le seuil.
  void _verifierEtNotifier(String type,  currentValue, threshold)async  {
    if (currentValue >= threshold) {
      debugPrint("$type Alerte Notification");
      afficherNotification(type);
    }
  }

  // Variables représentant les données météorologiques.
  String icon_url = "";
  String desc = "";
  double temperature = 0.0;
  double temp_ressentie = 0.0;
  int pression = 0;
  dynamic humidite ;
  double temp_max = 0.0;
  double temp_min = 0.0;
  int visibilite = 0;
  String pays = "";
  double vitesseVent = 0;
  var nuage ;
  String ville = "";

  // Instance de WeatherApiRepo pour obtenir les données météorologiques à partir de l'API.
  MeteoApiRepo repo = MeteoApiRepo();

  // Méthode pour obtenir toutes les données météorologiques actuelles.
  Future<void> getDonneesMeteoAll() async {
    // Récupère la position actuelle de l'utilisateur.
    final position = await _determinerPosition();
    double lat = position.latitude;
    double lang = position.longitude;

    // Obtient les données météorologiques à partir de l'API en fonction de la position.
    final donneeMeteo = await repo.getDonneesMeteo(lat, lang);
    if (donneeMeteo != null) {
      // Mise à jour des variables avec les nouvelles données.
      icon_url = "http://openweathermap.org/img/w/" +
          donneeMeteo.meteoListeActuelle[0].icon +
          ".png";
      desc = donneeMeteo.meteoListeActuelle[0].description;
      temperature = donneeMeteo.main.temp;
      temp_ressentie = donneeMeteo.main.temperatureRessentie;
      pression = donneeMeteo.main.pression;
      humidite = donneeMeteo.main.humidite;
      temp_max = donneeMeteo.main.tempMax;
      temp_min = donneeMeteo.main.tempMin;
      visibilite = donneeMeteo.visibilite;
      pays = donneeMeteo.systeme.pays!;
      vitesseVent = donneeMeteo.vent.vitesseVent;
      nuage = donneeMeteo.nuages.nuageux;
      ville = donneeMeteo.nomVille.toString();
      debugPrint(vitesseVent.toString());

      // Notifie les auditeurs (widgets) du changement de données.
      notifyListeners();
    }

    // Vérifie les seuils et affiche les notifications appropriées.
    afficherValeurEtNotifier();
  }

  // Variables pour stocker les données météorologiques d'une ville spécifique.
  double villeTemp = 0.0;
  double villeVitesseVent = 0.0;
  int villePression = 0;
  int villeVisibilite = 0;

  // Méthode pour obtenir les données météorologiques d'une ville spécifique.
  Future<void> getMeteoVille(String city, String countryCode) async {
    final weatherCity = await repo.getDonneesMeteoParVille(city, countryCode);
    if (weatherCity != null) {
      villeTemp = weatherCity.main.temp;
      villeVitesseVent = weatherCity.vent.vitesse;
      villePression = weatherCity.main.humidite;
      villeVisibilite = weatherCity.visibilite;
      debugPrint(weatherCity.visibilite.toString());
      // Notifie les auditeurs (widgets) du changement de données.
      notifyListeners();
    }
  }
}
