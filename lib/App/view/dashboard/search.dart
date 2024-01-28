import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather/App/controller/weather.dart';
import 'package:weather/App/model/weather.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // Contrôleur pour récupérer la valeur saisie dans le champ de recherche
  TextEditingController search = TextEditingController();
  String selectedCountryCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recherche"),
      ),
      body: Consumer<WeatherController>(builder: (context, value, child) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
              // Champ de texte pour saisir la recherche
              Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      hintText: 'Ecrire',
                      helperStyle: GoogleFonts.readexPro(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      suffix: IconButton(
                        onPressed: () {
                          // Lorsque l'utilisateur appuie sur le bouton de recherche,
                          // déclenche la recherche en utilisant WeatherController

                          value.setIsSearch = true;
                          value.getWeatherCity(capitalizeFirstCharacter(search.text.trim()), selectedCountryCode.toLowerCase());
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
                  // Sélecteur de code de pays
                  CountryCodePicker(
                    onChanged: (CountryCode countryCode) {
                      setState(() {
                        selectedCountryCode = countryCode.code!.toLowerCase().toString();
                      });
                    },
                    initialSelection: 'US', // Code de pays sélectionné initialement
                    favorite: ['+1', 'US'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  SizedBox(height: 20),
              // Affiche les détails de la ville si la recherche est effectuée
              value.isSearch == false
                  ? Container()
                  : Stack(
                      fit: StackFit.loose,
                      clipBehavior: Clip.antiAlias,
                      children: [
                        // Image de fond
                        Container(
                          height: 200,
                          width: 500,
                          //  clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            "assets/images/pic.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Informations météorologiques superposées
                        Positioned(
                          left: 16,
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Icône météo
                                  Row(
                                    children: [
                                      // Add some spacing between icon and text
                                      Image.network(
                                        "http://openweathermap.org/img/w/03d.png",
                                      ),

                                      //
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Température
                                          Text(
                                            "${value.cityTemp} °C",
                                            style: GoogleFonts.readexPro(
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                          // Vitesse du vent
                                          Text(
                                            "Vent-${value.cityWind} km/h",
                                            style: GoogleFonts.readexPro(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  // Informations supplémentaires
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            // Humidité
                                            Text(
                                              "Humidité : ",
                                              style: GoogleFonts.readexPro(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              "${value.cityPressure}%",
                                              style: GoogleFonts.readexPro(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Visibilité : ",
                                              style: GoogleFonts.readexPro(
                                                fontSize: 06,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${value.cityVisibility/1000} km",
                                              style: GoogleFonts.readexPro(
                                                  color: Colors.white,
                                                  fontSize: 06,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
            ]));
      }),
    );
  }

  // Met en majuscule la première lettre de la recherche
  String capitalizeFirstCharacter(String text) {
    if (text.isEmpty) {
      return text;
    }

    return text[0].toUpperCase() + text.substring(1);
  }
}
