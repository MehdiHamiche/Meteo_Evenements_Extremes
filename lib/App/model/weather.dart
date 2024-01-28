// Classe représentant les données météorologiques pour une ville.
class WeatherData {
  Coord coord;            // Coordonnées géographiques de la ville.
  List<Weather> weather;  // Liste des conditions météorologiques actuelles.
  String base;            // Base de données utilisée pour les données météorologiques.
  Main main;              // Informations principales telles que la température, la pression, etc.
  int visibility;         // Visibilité en mètres.
  Wind wind;              // Informations sur le vent.
  Clouds clouds;          // Informations sur les nuages.
  int dt;                 // Timestamp de la dernière mise à jour des données.
  Sys sys;                // Informations sur le système (pays, lever/coucher du soleil, etc.).
  int timezone;           // Décalage horaire de la ville en secondes.
  int id;                 // Identifiant de la ville.
  String name;            // Nom de la ville.
  int cod;                // Code de réponse de la requête.

  WeatherData({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  // Méthode de fabrique pour créer une instance de WeatherData à partir d'un JSON.
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List).map((e) => Weather.fromJson(e)).toList(),
      base: json['base'],
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

// Classe représentant les coordonnées géographiques (longitude et latitude).
class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  // Méthode de fabrique pour créer une instance de Coord à partir d'un JSON.
  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'],
      lat: json['lat'],
    );
  }
}

// Classe représentant les conditions météorologiques.
class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  // Méthode de fabrique pour créer une instance de Weather à partir d'un JSON.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

// Classe représentant les informations principales sur la météo.
class Main {
  double temp;         // Température actuelle.
  double feelsLike;    // Sensation thermique.
  double tempMin;      // Température minimale.
  double tempMax;      // Température maximale.
  int pressure;        // Pression atmosphérique.
  int humidity;        // Humidité atmosphérique.

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  // Méthode de fabrique pour créer une instance de Main à partir d'un JSON.
  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

// Classe représentant les informations sur le vent.
class Wind {
  double speed;        // Vitesse du vent.
  int deg;             // Direction du vent en degrés.

  Wind({
    required this.speed,
    required this.deg,
  });

  // Méthode de fabrique pour créer une instance de Wind à partir d'un JSON.
  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: _parseDouble(json['speed']),
      deg: json['deg'],
    );
  }
}

// Fonction utilitaire pour parser une valeur en double.
double _parseDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else {
    throw FormatException("Type invalide pour un double : $value");
  }
}

// Classe représentant les informations sur les nuages.
class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  // Méthode de fabrique pour créer une instance de Clouds à partir d'un JSON.
  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

// Classe représentant les informations du système (pays, lever/coucher du soleil, etc.).
class Sys {
  int? type;      // Type de système (peut être null).
  int? id;        // Identifiant de système (peut être null).
  String? country; // Pays.
  int? sunrise;    // Timestamp du lever du soleil (peut être null).
  int? sunset;     // Timestamp du coucher du soleil (peut être null).

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  // Méthode de fabrique pour créer une instance de Sys à partir d'un JSON.
  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'] ?? 0,
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
