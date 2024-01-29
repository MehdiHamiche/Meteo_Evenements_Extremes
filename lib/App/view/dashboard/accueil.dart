import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/App/common/clientNav.dart';
import 'package:weather/App/controller/meteoController.dart';
import 'package:weather/App/utils/image.dart';


// La classe Accueil est un StatefulWidget qui représente l'écran d'accueil de l'application.

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

// La classe _AccueilState est l'état associé à Accueil.
class _AccueilState extends State<Accueil> {

  //Contrôleur pour gérer les données affichées sur l'écran d'accueil
  MeteoController? controller;

  @override
  void initState() {
    // Initialisation du contrôleur de données météorologiques lors de la création de l'état.
    controller = Provider.of<MeteoController>(context, listen: false);
    super.initState();
  }

  @override
  //Cette méthode est appelée après initState() si un objet State dépend d'un widget hérité qui a changé.
  void didChangeDependencies() async {
    await controller?.getDonneesMeteoAll();
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    DateTime actuel = DateTime.now();

    String tempsFormate = DateFormat('EEEE k:mm').format(actuel);
    return Scaffold(
      key: _scaffoldKey,
      //En tête de l'écran d'accueil
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle: true,
        actions: [
          Text("",
            style: GoogleFonts.readexPro(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: ClientDrawer(),
      body: SingleChildScrollView(
        child: Consumer<MeteoController>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white24,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF243555)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        //initial du pays en fonction de la position
                        child: Text(
                          value.pays,
                          style: GoogleFonts.readexPro(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                        ),
                        //nom de la ville en fonction de la position
                        child: Text(
                          "${value.ville}",
                          style: GoogleFonts.readexPro(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              value.icon_url == null || value.icon_url == ""
                                  ? Container()
                                  : Image.network(value.icon_url),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                //affichage de la température
                                children: [
                                  Text("${value.temperature.toString()} °C " ?? "",
                                      style: GoogleFonts.readexPro(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Météo",
                                  style: GoogleFonts.readexPro(
                                      fontSize: 20, color: Colors.white)),
                              Text(tempsFormate,
                                  style: GoogleFonts.readexPro(
                                      color: Colors.white)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                value.desc,
                                style: GoogleFonts.readexPro(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Visibilité ${value.visibilite}",
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Plus basse température : ${value.temp_min}',
                                  style: GoogleFonts.readexPro(
                                      color: Colors.grey, fontSize: 10)),
                              Text(" et plus haute température : ${value.temp_max}",
                                  style: GoogleFonts.readexPro(
                                      color: Colors.grey, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 110,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                air,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              //affichage de la vitesse du vent
                              "${value.vitesseVent}km/h",
                              style: GoogleFonts.readexPro(
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  humidite,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                //affichage du taux d'humidité
                                "${value.humidite}%",
                                style: GoogleFonts.readexPro(
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  nuage,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                //affichage de la couverture nuageuse
                                "${value.nuage}%",
                                style: GoogleFonts.readexPro(
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  pression,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                //affichage de la pression atmosphérique
                                "${value.pression}",
                                style: GoogleFonts.readexPro(
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
