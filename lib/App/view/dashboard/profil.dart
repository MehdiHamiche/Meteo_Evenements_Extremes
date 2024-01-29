import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/App/utils/preferencesPartagees.dart';


// La classe Profil est un StatefulWidget qui gère l'écran Profil
// Cette classe permet de gérer toutes les options proposées à l'utilisateur
class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  // Booléen pour le contrôle de l'interrupteur des notifications
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //En tête de l'écran de Profil
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: const Text("Paramètres"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              const SizedBox(
                height: 10,
              ),

              // Paramètre des notifications avec un interrupteur
              ListTile(
                leading: const Icon(Icons.notifications), // Your leading icon
                title: const Text("Notification"),
                subtitle: const Text("Informations de notification"),
                trailing: Switch(
                  value: isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      isSwitched = value;
                      debugPrint(isSwitched.toString());
                    });
                  },
                ),
              ),

              // Paramètre du profil avec une icône d'édition
              ListTile(
                leading: const Icon(Icons.person_2),
                title: const Text("Profil"),
                subtitle: const Text("Informations utilisateur"),
                trailing:IconButton(onPressed: () {  }, icon: const Icon(Icons.edit),) ,
              ),

              // Paramètre des tremblements de terre avec une icône d'édition
              ListTile(
                leading: const Icon(Icons.event), // Your leading icon
                title: const Text("Tremblement de terre"),
                subtitle: const Text("Informations sur les tremblements de terre"),
              onTap: (){
                  Navigator.pushNamed(context, "/info");
              },
              trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.edit_document)),
              ),

              // Paramètre de la température avec une icône d'ajout
              ListTile(
                leading: const Icon(CupertinoIcons.radiowaves_right), // Your leading icon
                title: const Text("Température"),
                subtitle: const Text("Définir la valeur de la température"),
                onTap: () {
                  Navigator.pushNamed(context, "/temp");
                },
                trailing: IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.add_circled)),
              ),

              // Paramètre du vent avec une icône d'éolienne
              ListTile(
                leading: const Icon(CupertinoIcons.wand_rays), // Your leading icon
                title: const Text("Vent"),
                onTap: (){
                  Navigator.pushNamed(context, "/wind");
                },
                subtitle: const Text("Définir la valeur du vent"),
                trailing: IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.wind)),
              ),

              // Paramètre de l'humidité avec une icône de pompe à chaleur
              ListTile(
                leading: const Icon(CupertinoIcons.hurricane), // Your leading icon
                title: const Text("Humidité"),
                onTap: (){
                  Navigator.pushNamed(context, "/humidity");
                },
                subtitle: const Text("Définir la valeur d'humidité"),
                trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.heat_pump)),
              ),

               // Paramètre de couvertures nuageuses avec une icône de nuage
              ListTile(
                leading: const Icon(CupertinoIcons.cloud_bolt), // Your leading icon
                title: const Text("Nuage"),
                onTap: (){
                    Navigator.pushNamed(context, "/cloud");
                },
                subtitle: const Text("Définir la valeur des couvertures nuageuses"),
                trailing: IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.cloud)),
              ),

              // Paramètre pour effacer les données locales avec une icône de suppression
              ListTile(
                leading:  const Icon(CupertinoIcons.decrease_indent), // Your leading icon
                title:  const Text("Effacer les données"),
                onTap: (){
                  PreferencesPartageesManager().effacerDonnees();
                },
                subtitle: const Text("Effacer les données stockées"),
                trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.clear_all_rounded)),
              ),
            ],
          ),
        ),
      )
    );
  }
}