// Classe représentant les données météorologiques pour une ville.
class DonneesMeteo {
  Coord coord;            // Coordonnées géographiques de la ville.
  List<Weather> meteoListeActuelle;  // Liste des conditions météorologiques actuelles.
  String base;            // Base de données utilisée pour les données météorologiques.
  Main main;              // Informations principales telles que la température, la pression, etc.
  int visibilite;         // Visibilité en mètres.
  Wind vent;              // Informations sur le vent.
  Clouds nuages;          // Informations sur les nuages.
  int dt;                 // Timestamp de la dernière mise à jour des données.
  Sys sys;                // Informations sur le système (pays, lever/coucher du soleil, etc.).
  int fuseauHoraire;      // Fuseau horaire de la ville en secondes.
  int idVille;            // Identifiant de la ville.
  String nomVille;        // Nom de la ville.
  int code;               // Code de réponse de la requête.

  DonneesMeteo({
    required this.coord,
    required this.meteoListeActuelle,
    required this.base,
    required this.main,
    required this.visibilite,
    required this.vent,
    required this.nuages,
    required this.dt,
    required this.sys,
    required this.fuseauHoraire,
    required this.idVille,
    required this.nomVille,
    required this.code,
  });

  // Méthode de fabrique pour créer une instance de WeatherData à partir d'un JSON.
  factory DonneesMeteo.fromJson(Map<String, dynamic> json) {
    return DonneesMeteo(
      coord: Coord.fromJson(json['coord']),
      meteoListeActuelle: (json['weather'] as List).map((e) => Weather.fromJson(e)).toList(),
      base: json['base'],
      main: Main.fromJson(json['main']),
      visibilite: json['visibility'],
      vent: Wind.fromJson(json['wind']),
      nuages: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      fuseauHoraire: json['timezone'],
      idVille: json['id'],
      nomVille: json['name'],
      code: json['cod'],
    );
  }
}

// Classe représentant les coordonnées géographiques (longitude et latitude).
class Coord {
  double lon;   //longitude
  double lat;   //latitude

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
  double temperatureRessentie;    // Température ressentie.
  double tempMin;      // Température minimale.
  double tempMax;      // Température maximale.
  int pression;        // Pression atmosphérique.
  int humidite;        // Humidité atmosphérique.

  Main({
    required this.temp,
    required this.temperatureRessentie,
    required this.tempMin,
    required this.tempMax,
    required this.pression,
    required this.humidite,
  });

  // Méthode de fabrique pour créer une instance de Main à partir d'un JSON.
  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      temperatureRessentie: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pression: json['pressure'],
      humidite: json['humidity'],
    );
  }
}

// Classe représentant les informations sur le vent.
class Wind {
  double vitesseVent;        // Vitesse du vent.
  int degreeDirectionVent;             // Direction du vent en degrés.

  Wind({
    required this.vitesseVent,
    required this.degreeDirectionVent,
  });

  // Méthode de fabrique pour créer une instance de Wind à partir d'un JSON.
  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      vitesseVent: _parseDouble(json['speed']),
      degreeDirectionVent: json['deg'],
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
  int nuageux;

  Clouds({
    required this.nuageux,
  });

  // Méthode de fabrique pour créer une instance de Clouds à partir d'un JSON.
  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      nuageux: json['all'],
    );
  }
}

// Classe représentant les informations du système (pays, lever/coucher du soleil, etc.).
class Sys {
  int? type;      // Type de système (peut être null).
  int? id;        // Identifiant de système (peut être null).
  String? pays;   // Pays.
  int? leverSoleil;    // Timestamp du lever du soleil (peut être null).
  int? coucherSoleil;     // Timestamp du coucher du soleil (peut être null).

  Sys({
    required this.type,
    required this.id,
    required this.pays,
    required this.leverSoleil,
    required this.coucherSoleil,
  });

  // Méthode de fabrique pour créer une instance de Sys à partir d'un JSON.
  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'] ?? 0,
      id: json['id'],
      pays: json['country'],
      leverSoleil: json['sunrise'],
      coucherSoleil: json['sunset'],
    );
  }
}
