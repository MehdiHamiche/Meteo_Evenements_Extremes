// Classe principale représentant le modèle des tremblements de terre.
class ModeleSeisme {
  String type;
  Metadata metadata;
  List<Feature> features;

  ModeleSeisme({required this.type, required this.metadata, required this.features});

  factory ModeleSeisme.fromJson(Map<String, dynamic> json) {
    return ModeleSeisme(
      type: json['type'],
      metadata: Metadata.fromJson(json['metadata']),
      features: List<Feature>.from(json['features'].map((feature) => Feature.fromJson(feature))),
    );
  }
}

// Classe représentant les métadonnées liées aux tremblements de terre.
class Metadata {
  int generer;
  String url;
  String title;
  int status;
  String api;
  int limit;
  int offset;
  int count;

  Metadata({
    required this.generer,
    required this.url,
    required this.title,
    required this.status,
    required this.api,
    required this.limit,
    required this.offset,
    required this.count,
  });

  //La classe MetaData utilise le constructeur factory afin de créer des instances à partir des données JSON

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      generer: json['generated'],
      url: json['url'],
      title: json['title'],
      status: json['status'],
      api: json['api'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
    );
  }
}

// Classe représentant une caractéristique individuelle d'un tremblement de terre.
class Feature {
  String type;
  Properties properties;
  Geometry geometry;
  String id;

  Feature({required this.type, required this.properties, required this.geometry, required this.id});

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      type: json['type'],
      properties: Properties.fromJson(json['properties']),
      geometry: Geometry.fromJson(json['geometry']),
      id: json['id'],
    );
  }
}

// Classe représentant les propriétés d'un tremblement de terre.
class Properties {
  num mag;
  String place;
  int time;
  int updated;
  String url;
  String detail;
  int tsunami;
  num sig;
  String title;

  Properties({
    required this.mag,
    required this.place,
    required this.time,
    required this.updated,
    required this.url,
    required this.detail,
    required this.tsunami,
    required this.sig,
    required this.title,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      mag: json['mag'],
      place: json['place'],
      time: json['time'],
      updated: json['updated'],
      url: json['url'],
      detail: json['detail'],
      tsunami: json['tsunami'],
      sig: json['sig'],
      title: json['title'],
    );
  }
}

// Classe représentant la géométrie d'un tremblement de terre.
class Geometry {
  String type;
  List<double> coordinates;

  Geometry({required this.type, required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates'].map((coordinate) => coordinate.toDouble())),
    );
  }
}
