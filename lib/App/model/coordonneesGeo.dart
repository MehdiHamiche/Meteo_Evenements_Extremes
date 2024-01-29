// Classe représentant les coordonnées géographiques (longitude et latitude).
class Coord {
  double lon;
  double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

// Classe représentant les informations sur la météo (ID, temps, description et icône).
class Meteo {
  int id;
  String main;
  String description;
  String icon;

  Meteo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Meteo.fromJson(Map<String, dynamic> json) {
    return Meteo(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

// Classe représentant les informations principales sur la météo (température, sensation thermique, etc.).
class InfoPrincipale {
  double temp;
  double ressentie;
  double tempMin;
  double tempMax;
  int pression;
  int humidite;

  InfoPrincipale({
    required this.temp,
    required this.ressentie,
    required this.tempMin,
    required this.tempMax,
    required this.pression,
    required this.humidite,
  });

  factory InfoPrincipale.fromJson(Map<String, dynamic> json) {
    return InfoPrincipale(
      temp: json['temp'].toDouble(),
      ressentie: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pression: json['pressure'],
      humidite: json['humidity'],
    );
  }
}

// Classe représentant les informations sur le vent.
class Vent {
  double vitesse;
  int degreeDirection;

  Vent({required this.vitesse, required this.degreeDirection});

  factory Vent.fromJson(Map<String, dynamic> json) {
    return Vent(
      vitesse: json['speed'].toDouble(),
      degreeDirection: json['deg'],
    );
  }
}

// Classe représentant les informations sur les nuages.
class Nuages {
  int nuageux;

  Nuages({required this.nuageux});

  factory Nuages.fromJson(Map<String, dynamic> json) {
    return Nuages(
      nuageux: json['all'],
    );
  }
}

// Classe représentant les informations du système (type, ID, pays, lever/coucher du soleil, etc.).
class InfoSysteme {
  int type;
  int id;
  String pays;
  int leverSoleil;
  int coucherSoleil;

  InfoSysteme({
    required this.type,
    required this.id,
    required this.pays,
    required this.leverSoleil,
    required this.coucherSoleil,
  });

  factory InfoSysteme.fromJson(Map<String, dynamic> json) {
    return InfoSysteme(
      type: json['type'],
      id: json['id'],
      pays: json['country'],
      leverSoleil: json['sunrise'],
      coucherSoleil: json['sunset'],
    );
  }
}

// Classe représentant l'ensemble des données météorologiques pour une ville spécifique.
class donneesMeteoVille {
  Coord coord;
  List<Meteo> meteoListeVille;
  String base;
  InfoPrincipale main;
  int visibilite;
  Vent vent;
  Nuages nuage;
  int dt;
  InfoSysteme systeme;
  int fuseauHoraire;
  int id;
  String nomVille;
  int cod;

  donneesMeteoVille({
    required this.coord,
    required this.meteoListeVille,
    required this.base,
    required this.main,
    required this.visibilite,
    required this.vent,
    required this.nuage,
    required this.dt,
    required this.systeme,
    required this.fuseauHoraire,
    required this.id,
    required this.nomVille,
    required this.cod,
  });

  factory donneesMeteoVille.fromJson(Map<String, dynamic> json) {
    return donneesMeteoVille(
      coord: Coord.fromJson(json['coord']),
      meteoListeVille: (json['weather'] as List<dynamic>)
          .map((item) => Meteo.fromJson(item))
          .toList(),
      base: json['base'],
      main: InfoPrincipale.fromJson(json['main']),
      visibilite: json['visibility'],
      vent: Vent.fromJson(json['wind']),
      nuage: Nuages.fromJson(json['clouds']),
      dt: json['dt'],
      systeme: InfoSysteme.fromJson(json['sys']),
      fuseauHoraire: json['timezone'],
      id: json['id'],
      nomVille: json['name'],
      cod: json['cod'],
    );
  }
}
