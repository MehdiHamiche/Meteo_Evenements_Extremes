import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/App/repository/weatherApiRepo.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/sharedPref.dart';

// La classe WeatherController étend ChangeNotifier et agit comme un contrôleur pour la gestion des données météorologiques.
class WeatherController extends ChangeNotifier {
  WeatherController() {
    // Initialise la détermination de la position lors de la création du contrôleur.
    _determinePosition();
  }

  // Booléen indiquant si la recherche est en cours.
  bool _isSearch = false;
  bool get isSearch => _isSearch;

  // Getter et Setter pour la variable isSearch.
  set setIsSearch(value) {
    _isSearch = value;
    notifyListeners();
  }

  // Méthode asynchrone pour déterminer la position actuelle de l'utilisateur.
  Future<Position> _determinePosition() async {
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
  Future showNotification(String notify) async {
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
        'high_importance_channel', // id
        'High Importance Notifications', // titre
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
            '@mipmap/ic_launcher', // Change this to the correct icon resource name
        playSound: true,
      ));

      // Affichage de la notification.
      await flutterLocalNotificationsPlugin.show(
        0,
        '$notify Alert',
        'The $notify  is greater than or equal to the stored value.',
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
  Future<void> checkValueAndNotify() async {
    final SharedPreferencesManager prefsManager = SharedPreferencesManager();

    final int dataTemp = int.parse(prefsManager.getTemperature());
    final int dataCloud = int.parse(prefsManager.getCloud());
    final double dataCloud1 = double.parse(prefsManager.getCloud());
    final int dataWind = int.parse(prefsManager.getWind());
    final int dataHumidity = int.parse(prefsManager.gethumidity());
    final double dataHumidity1 = double.parse(prefsManager.gethumidity());



    debugPrint("Temp .. $humi  .... $dataHumidity");
    if (dataTemp != 0) {
      _checkAndNotify("Temperature", temp, dataTemp);
    }
    if (cloud.runtimeType == int) {
      if (dataCloud != 0) {
        _checkAndNotify("Cloud", cloud, dataCloud);
      }
    } else if (cloud.runtimeType == double) {
      if (dataCloud1 != 0.0) {
        _checkAndNotify("Cloud", cloud, dataCloud1);
      }
    }
    if (dataWind != 0) {
      _checkAndNotify("Wind", wind, dataWind);
    }

    if (humi.runtimeType == int) {
      if (humi != 0) {
        _checkAndNotify("Humidity", humi, dataHumidity);
      }
    } else if (humi.runtimeType == double) {
      if (humi != 0.0) {
        _checkAndNotify("Humidity", humi, dataHumidity1);
      }
    }
  }

  // Méthode pour vérifier une valeur spécifique et afficher une notification si elle dépasse le seuil.
  void _checkAndNotify(String type,  currentValue, threshold)async  {
    if (currentValue >= threshold) {
      debugPrint("$type Alert Notify");
      await showNotification(type);
    }
  }

  // Variables représentant les données météorologiques.
  String icon_url = "";
  String desc = "";
  double temp = 0.0;
  double temp_feel = 0.0;
  int pressure = 0;
  dynamic humi;
  double temp_max = 0.0;
  double temp_min = 0.0;
  int visibility = 0;
  String country = "";
  double wind = 0;
  var cloud;
  String city = "";

  // Instance de WeatherApiRepo pour obtenir les données météorologiques à partir de l'API.
  WeatherApiRepo repo = WeatherApiRepo();

  // Méthode pour obtenir toutes les données météorologiques actuelles.
  Future<void> getWeatherAll() async {
    // Récupère la position actuelle de l'utilisateur.
    final location = await _determinePosition();
    double lat = location.latitude;
    double lang = location.longitude;

    // Obtient les données météorologiques à partir de l'API en fonction de la position.
    final weatherData = await repo.getWeatherData(lat, lang);
    if (weatherData != null) {
      // Mise à jour des variables avec les nouvelles données.
      icon_url = "http://openweathermap.org/img/w/" +
          weatherData.weather[0].icon +
          ".png";
      desc = weatherData.weather[0].description;
      temp = weatherData.main.temp;
      temp_feel = weatherData.main.feelsLike;
      pressure = weatherData.main.pressure;
      humi = weatherData.main.humidity;
      temp_max = weatherData.main.tempMax;
      temp_min = weatherData.main.tempMin;
      visibility = weatherData.visibility;
      country = weatherData.sys.country!;
      wind = weatherData.wind.speed;
      cloud = weatherData.clouds.all;
      city = weatherData.name.toString();
      debugPrint(wind.toString());

      // Notifie les auditeurs (widgets) du changement de données.
      notifyListeners();
    }

    // Vérifie les seuils et affiche les notifications appropriées.
    checkValueAndNotify();
  }

  // Variables pour stocker les données météorologiques d'une ville spécifique.
  double cityTemp = 0.0;
  double cityWind = 0.0;
  int cityPressure = 0;
  int cityVisibility = 0;

  // Méthode pour obtenir les données météorologiques d'une ville spécifique.
  Future<void> getWeatherCity(String city, String countryCode) async {
    final weatherCity = await repo.getWeatherDataByCity(city, countryCode);
    if (weatherCity != null) {
      cityTemp = weatherCity.main.temp;
      cityWind = weatherCity.wind.speed;
      cityPressure = weatherCity.main.humidity;
      cityVisibility = weatherCity.visibility;
      debugPrint(weatherCity.visibility.toString());
      // Notifie les auditeurs (widgets) du changement de données.
      notifyListeners();
    }
  }
}
