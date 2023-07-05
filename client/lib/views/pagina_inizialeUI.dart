import 'package:flutter/material.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/views/Home.dart';
import 'package:ratatouille23/views/custom_widget/bottoni_gestione.dart';
import 'package:ratatouille23/views/registra_utente.dart';
import 'package:ratatouille23/views/statistiche.dart';

import 'package:google_fonts/google_fonts.dart';

import '../controllers/Utente_controller.dart';
import '../models/Utente.dart';
import 'menu.dart';
import 'ordinazioni_elenco.dart';
import 'ordinazioni_elenco_cucina.dart';

class pagina_inizialeUI extends StatelessWidget {
  final Utente utente;
  Amplify_controller amplify_controller = Amplify_controller();
  late Utente_controller utente_controller;

  pagina_inizialeUI(this.utente, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
                'Ratatouille23',
                style: GoogleFonts.sendFlowers(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await amplify_controller.signOutCurrentUser();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
              },
              icon: const Icon(Icons.logout)
          )
        ],
      ),

      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const SizedBox(width: 50),
                  Expanded(
                    child: (utente.get_ruolo() == "Amministratore") ? bottoni_gestione(
                        route: registra_utenteUI(
                          utente: utente,
                        ),
                        routeText: "/utente",
                        text: 'AGGIUNGI UTENTE',
                        color1: Colors.orangeAccent,
                        color2: Colors.yellow,
                        icon: Icons.person_add_alt_1_outlined) : bottoneBloccato(),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: (utente.get_ruolo() == "Amministratore" || utente.get_ruolo() == "Addetto alla sala") ? bottoni_gestione(
                        route: ordinazioni_elenco(utente: utente),
                        routeText: "/ordinazioni",
                        text: 'ORDINAZIONI',
                        color1: Colors.pink,
                        color2: Colors.deepOrange,
                        icon: Icons.checklist_outlined) : bottoneBloccato(),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: (utente.get_ruolo() == "Amministratore" || utente.get_ruolo() == "Supervisore") ? bottoni_gestione(
                        route: menu(utente: utente),
                        routeText: "/menu",
                        text: 'MENU',
                        color1: Colors.lightBlue,
                        color2: Colors.lightBlueAccent,
                        icon: Icons.menu_book) : bottoneBloccato(),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 50),
                  Expanded(
                    child: (utente.get_ruolo() == "Amministratore" || utente.get_ruolo() == "Addetto alla cucina") ? bottoni_gestione(
                        route: ordinazioni_elenco_cucina(utente: utente,),
                        routeText: "/cucina",
                        text: 'CUCINA',
                        color1: Colors.purple,
                        color2: Colors.purpleAccent,
                        icon: Icons.cake_outlined) : bottoneBloccato(),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: (utente.get_ruolo() == "Amministratore") ? bottoni_gestione(
                        route: statistiche(utente: utente,),
                        routeText: "/statistiche",
                        text: 'STATISTICHE',
                        color1: Colors.green,
                        color2: Colors.lightGreen,
                        icon: Icons.query_stats_outlined) : bottoneBloccato(),
                  ),
                  const SizedBox(width: 50),
                ],
              )
            ],
          )
        ],
      ),
    );
  }


}
