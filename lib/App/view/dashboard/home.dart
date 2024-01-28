import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/App/common/drawer.dart';
import 'package:weather/App/controller/weather.dart';
import 'package:weather/App/model/weather.dart';
import 'package:weather/App/utils/image.dart';
import 'package:weather/App/utils/list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherController? controller;

  @override
  void initState() {
    controller = Provider.of<WeatherController>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await controller?.getWeatherAll();
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedTime = DateFormat('EEEE h:mm a').format(now);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Image.asset(
          F,
          height: 30,
          width: 60,
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            sun,
            height: 20,
            width: 30,
          ),
          Text(
            "Sunny Day",
            style: GoogleFonts.readexPro(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Consumer<WeatherController>(builder: (context, value, child) {
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
                        child: Text(
                          value.country,
                          style: GoogleFonts.readexPro(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Text(
                          "${value.city}",
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
                                children: [
                                  Text("${value.temp.toString()} °C " ?? "",
                                      style: GoogleFonts.readexPro(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Weather",
                                  style: GoogleFonts.readexPro(
                                      fontSize: 20, color: Colors.white)),
                              Text(formattedTime,
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
                                    "Visibility ${value.visibility}",
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
                              Text('High of ${value.temp_min}',
                                  style: GoogleFonts.readexPro(
                                      color: Colors.grey, fontSize: 10)),
                              Text("with a low of ${value.temp_max}",
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
                              "${value.wind}km/h",
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
                                  humi,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${value.humi}%",
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
                                  cloud,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${value.cloud}%",
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
                                  press,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${value.pressure}",
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
