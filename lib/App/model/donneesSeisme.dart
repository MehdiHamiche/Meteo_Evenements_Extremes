// Classe principale représentant le modèle des tremblements de terre.
class ModeleSeisme {
  String type;
  Metadonnees metadonnees;
  List<Caracteristiques> caracteristiques;

  ModeleSeisme({required this.type, required this.metadonnees, required this.caracteristiques});

  factory ModeleSeisme.fromJson(Map<String, dynamic> json) {
    return ModeleSeisme(
      type: json['type'],
      metadonnees: Metadonnees.fromJson(json['metadata']),
      caracteristiques: List<Caracteristiques>.from(json['features'].map((feature) => Caracteristiques.fromJson(feature))),
    );
  }
}

// Classe représentant les métadonnées liées aux tremblements de terre.
class Metadonnees {
  int generer;
  String url;
  String titre;
  int statut;
  String api;
  int limite;
  int offset;//Renvoie les résultats à partir du nombre d'événements spécifié, en commençant à 1.
  int count;// Effectue un comptage sur une demande de données

  Metadonnees({
    required this.generer,
    required this.url,
    required this.titre,
    required this.statut,
    required this.api,
    required this.limite,
    required this.offset,
    required this.count,
  });

  //La classe MetaData utilise le constructeur factory afin de créer des instances à partir des données JSON

  factory Metadonnees.fromJson(Map<String, dynamic> json) {
    return Metadonnees(
      generer: json['generated'],
      url: json['url'],
      titre: json['title'],
      statut: json['status'],
      api: json['api'],
      limite: json['limit'],
      offset: json['offset'],
      count: json['count'],
    );
  }
}

// Classe représentant une caractéristique individuelle d'un tremblement de terre.
class Caracteristiques {
  String type;
  Proprietes properties;
  Geometrie geometry;
  String id;

  Caracteristiques({required this.type, required this.properties, required this.geometry, required this.id});

  factory Caracteristiques.fromJson(Map<String, dynamic> json) {
    return Caracteristiques(
      type: json['type'],
      properties: Proprietes.fromJson(json['properties']),
      geometry: Geometrie.fromJson(json['geometry']),
      id: json['id'],
    );
  }
}

// Classe représentant les propriétés d'un tremblement de terre.
class Proprietes {
  num magnitude;
  String place;
  int date;
  int actualise;
  String url;
  String detail;
  int tsunami;
  num sig;
  String titre;

  Proprietes({
    required this.magnitude,
    required this.place,
    required this.date,
    required this.actualise,
    required this.url,
    required this.detail,
    required this.tsunami,
    required this.sig,
    required this.titre,
  });

  factory Proprietes.fromJson(Map<String, dynamic> json) {
    return Proprietes(
      magnitude: json['mag'],
      place: json['place'],
      date: json['time'],
      actualise: json['updated'],
      url: json['url'],
      detail: json['detail'],
      tsunami: json['tsunami'],
      sig: json['sig'],
      titre: json['title'],
    );
  }
}

// Classe représentant la géométrie d'un tremblement de terre.
class Geometrie {
  String type;
  List<double> coordonnees;

  Geometrie({required this.type, required this.coordonnees});

  factory Geometrie.fromJson(Map<String, dynamic> json) {
    return Geometrie(
      type: json['type'],
      coordonnees: List<double>.from(json['coordinates'].map((coordinate) => coordinate.toDouble())),
    );
  }
}
