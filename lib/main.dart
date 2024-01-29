import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/App/common/inferieurNav.dart';
import 'package:weather/App/controller/meteoController.dart';
import 'package:weather/App/repository/meteoApiRepo.dart';
import 'package:weather/App/view/dashboard/nuage.dart';
import 'package:weather/App/view/dashboard/accueil.dart';
import 'package:weather/App/view/dashboard/humidite.dart';
import 'package:weather/App/view/dashboard/infoSeisme.dart';
import 'package:weather/App/view/dashboard/vent.dart';
import 'package:weather/App/view/login/connexion.dart';
import 'package:weather/App/view/splash/interfaceChargement.dart';
import 'package:workmanager/workmanager.dart';

import 'App/utils/localisation.dart';
import 'App/utils/preferencesPartagees.dart';
import 'App/view/dashboard/temperature.dart';

@pragma('vm:entry-point')
Future<void> printHello() async {
  print("Native called background task:");
  final emplacemement = await determinePosition();
  final lat = emplacemement.latitude;
  final lang = emplacemement.longitude;
  MeteoApiRepo repo = MeteoApiRepo();
  final donnees = await repo.getDonneesMeteo(lat, lang);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final valeurTemperatureStockee = int.parse(prefs.getString('temperature') ?? '0');
  final valeurVentStockee = int.parse(prefs.getString('wind') ?? '0');
  final donneesNuage = int.parse(prefs.getString("cloud") ?? '0') ;
  final dataHumidite = int.parse(prefs.getString("humidite") ?? '0');

  final temp = donnees?.main.temp;
  final vent = donnees?.vent.vitesseVent;
  final humidite = donnees?.main.humidite;
  final nuage = donnees?.nuages.nuageux;

    if (temp! >= valeurTemperatureStockee) {
      if(valeurTemperatureStockee != 0)
        {
          showNotification("Temperature");
        }

    }
    if (vent! >= valeurVentStockee) {
      if(valeurVentStockee != 0)
        {
          showNotification("Wind");
        }

    }
    if(humidite! >= dataHumidite )
      {
        if(dataHumidite != 0)
          {
            showNotification("Humidity");
          }

      }
    if(nuage! >= donneesNuage )
      {
        if(donneesNuage != 0)
          {
            showNotification("Cloud");
          }

      }

}

@pragma('vm:entry-point')
void callbackDispatcher() async {
  print("Tâche de fond appelée nativement");
   Workmanager().executeTask((task, inputData) async {
    debugPrint("Exécution en arrière-plan");
    print(
        "Tâche d'arrière-plan appelée nativement: $task");
    return Future.value(true);
  });
}

Future showNotification(String notify) async {
  const AndroidInitializationSettings android =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: android);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'canal_haute_performance', // id
    'Notifications très importantes', // title
    description:
        'Ce canal est utilisé pour des notifications très importantes', // description
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

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

  await flutterLocalNotificationsPlugin.show(
    0,
    '$notify Alerte',
    '$notify  supérieure ou égale à la valeur enregistrée.',
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesPartageesManager().preferencesPartageesInitiales();
  await AndroidAlarmManager.initialize();
  const int helloAlarmID = 0;
  await AndroidAlarmManager.periodic(
      const Duration(minutes: 5), helloAlarmID, printHello);
 await  Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode:
          true
      );
 await  Workmanager().registerPeriodicTask(
    "tempCallApi021",
    "tempCallApis021",
    initialDelay: Duration.zero,
      existingWorkPolicy: ExistingWorkPolicy.append,
    frequency: const Duration(minutes: 1),
  );
  await requestLocationPermission();

  runApp(const MyApp());
}

Future<void> requestLocationPermission() async {
  var status = await Permission.location.status;

  if (status.isGranted) {

    print('Autorisation locale déjà acceptée.');
  } else if (status.isDenied) {
    // L'autorisation de localisation est refusée, demandez l'autorisation
    var result = await Permission.location.request();
    if (result.isGranted) {
      print('Autorisation locale acceptée.');
    } else {
      print('Autorisation locale refusée.');
    }
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MeteoController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: "/",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          //Différents chemins menants aux différentes interfaces de l'application
          routes: {
            "/": (context) => const MyWidget(),
            "/login": (context) => const Connexion(),
            "/home": (context) => const Accueil(),
            "/bottom": (context) => const InferieurNav(),
            "/info": (context) => const InfoSeisme(),
            "/temp": (context) => const Temperature(),
            "/wind": (context) => const Vent(),
            "/humidity": (context) => const Humidite(),
            "/cloud": (context) => const Nuage(),
          },
        ));
  }
}
