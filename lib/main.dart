import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/App/common/bottem.dart';
import 'package:weather/App/controller/weather.dart';
import 'package:weather/App/repository/weatherApiRepo.dart';
import 'package:weather/App/view/dashboard/cloud.dart';
import 'package:weather/App/view/dashboard/home.dart';
import 'package:weather/App/view/dashboard/humidity.dart';
import 'package:weather/App/view/dashboard/info.dart';
import 'package:weather/App/view/dashboard/wind.dart';
import 'package:weather/App/view/login/login.dart';
import 'package:weather/App/view/splash/splash.dart';
import 'package:workmanager/workmanager.dart';

import 'App/utils/loocation.dart';
import 'App/utils/sharedPref.dart';
import 'App/view/dashboard/temp.dart';

@pragma('vm:entry-point')
Future<void> printHello() async {
  print("Native called background task:");
  final location = await determinePosition();
  final lat = location.latitude;
  final lang = location.longitude;
  WeatherApiRepo repo = WeatherApiRepo();
  final data = await repo.getWeatherData(lat, lang);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final storedValueTemp = int.parse(prefs.getString('temperature') ?? '0');
  final storedValueWind = int.parse(prefs.getString('wind') ?? '0');
  final dataCloud = int.parse(prefs.getString("cloud") ?? '0') ;
  final dataHumidity = int.parse(prefs.getString("humidity") ?? '0');

  final temp = data?.main.temp;
  final wind = data?.wind.speed;
  final humidity = data?.main.humidity;
  final cloud = data?.clouds.all;

    if (temp! >= storedValueTemp) {
      if(storedValueTemp != 0)
        {
          showNotification("Temperature");
        }

    }
    if (wind! >= storedValueWind) {
      if(storedValueWind != 0)
        {
          showNotification("Wind");
        }

    }
    if(humidity! >= dataHumidity )
      {
        if(dataHumidity != 0)
          {
            showNotification("Humidity");
          }

      }
    if(cloud! >= dataCloud )
      {
        if(dataCloud != 0)
          {
            showNotification("Cloud");
          }

      }

}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() async {
  print("Native called background task:");
   Workmanager().executeTask((task, inputData) async {
    // final location = await determinePosition();
    // final lat = location.latitude;
    // final lang = location.longitude;
    // WeatherApiRepo repo = WeatherApiRepo();
    // final data = await repo.getWeatherData(lat, lang);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final storedValueTemp = int.parse(prefs.getString('temperature') ?? '0');
    // final storedValueWind = int.parse(prefs.getString('wind') ?? '0');
    // final dataCloud = int.parse(prefs.getString("cloud") ?? "0");
    // final dataHumidity = int.parse(prefs.getString("humidity") ?? "0");
    // final dataCloud1 = double.parse(prefs.getString("cloud") ?? "0.0");
    // final dataHumidity1 =
    //     double.parse(prefs.getString("humidity") ?? "0.0" );

    debugPrint("Run background");

    //final temp = data?.main.temp;
    // final wind = data?.wind.speed;
    // final humidity = data?.main.humidity;
    // final cloud = data?.clouds.all;
    //
    // if (temp! >= storedValueTemp) {
    //   if (storedValueTemp != 0) {
    //     showNotification("Temperature");
    //   }
    // }
    // if (wind! >= storedValueWind) {
    //   if (storedValueWind != 0) {
    //     showNotification("Wind");
    //   }
    // }
    // if (humidity! >= dataHumidity) {
    //   if (humidity.runtimeType == int) {
    //     if (dataHumidity != 0) {
    //       showNotification("Humidity");
    //     }
    //   } else if (humidity.runtimeType == double) {
    //     if (dataHumidity1 != 0.0) {
    //       showNotification("Humidity");
    //     }
    //   }
    // }
    // if (cloud! >= dataCloud) {
    //   if (cloud.runtimeType == int) {
    //     if (dataCloud != 0) {
    //       showNotification("cloud");
    //     }
    //   } else if (cloud.runtimeType == double) {
    //     if (dataCloud1 != 0.0) {
    //       showNotification("cloud");
    //     }
    //   }
    // }
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
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
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
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
    '$notify Alert',
    'The $notify is greater than or equal to the stored value.',
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().initSharedPreferences();
  await AndroidAlarmManager.initialize();
  const int helloAlarmID = 0;
  await AndroidAlarmManager.periodic(
      const Duration(minutes: 5), helloAlarmID, printHello);
 await  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
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
    // Location permission is already granted
    print('Location permission is already granted.');
  } else if (status.isDenied) {
    // Location permission is denied, request permission
    var result = await Permission.location.request();
    if (result.isGranted) {
      print('Location permission granted.');
    } else {
      print('Location permission denied.');
    }
  } else if (status.isPermanentlyDenied) {
    // Location permission is permanently denied, take the user to app settings
    openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WeatherController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: "/",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            "/": (context) => const MyWidget(),
            "/login": (context) => const Login(),
            "/home": (context) => const Home(),
            "/bottem": (context) => const BottemNav(),
            "/info": (context) => const Info(),
            "/temp": (context) => const Temp(),
            "/wind": (context) => const Wind(),
            "/humidity": (context) => const Humidity(),
            "/cloud": (context) => const Cloud(),
          },
        ));
  }
}
