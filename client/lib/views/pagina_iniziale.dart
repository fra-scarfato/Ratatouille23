import 'package:flutter/material.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/views/custom_widget/bottoni_gestione.dart';
import 'package:ratatouille23/views/registra_utente.dart';
import 'package:ratatouille23/views/statistiche.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/Utente_controller.dart';
import '../models/Utente.dart';
import 'menu.dart';
import 'ordinazioni_elenco.dart';
import 'ordinazioni_elenco_cucina.dart';

class pagina_iniziale extends StatelessWidget {
  final Utente utente;
  Amplify_controller amplify_controller = Amplify_controller();
  late Utente_controller utente_controller;

  pagina_iniziale(this.utente);

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
              onPressed: () {},
              icon: Icon(Icons.logout)
          )
        ],
      ),

      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 25,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  utente.get_ruolo() == "Amministratore" ?
                  bottoni_gestione(
                      route: registra_utente(
                        utente: utente,
                      ),
                      routeText: "/utente",
                      text: 'AGGIUNGI UTENTE',
                      color1: Colors.orangeAccent,
                      color2: Colors.yellow,
                      icon: Icons.person_add_alt_1_outlined) : SizedBox.shrink(),
                  SizedBox(width: 50),
                  bottoni_gestione(
                      route: ordinazioni_elenco(utente: utente),
                      routeText: "/ordinazioni",
                      text: 'ORDINAZIONI',
                      color1: Colors.pink,
                      color2: Colors.deepOrange,
                      icon: Icons.checklist_outlined),
                  SizedBox(width: 50),
                  bottoni_gestione(
                      route: menu(utente: utente),
                      routeText: "/menu",
                      text: 'MENU',
                      color1: Colors.lightBlue,
                      color2: Colors.lightBlueAccent,
                      icon: Icons.menu_book),
                ],
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bottoni_gestione(
                      route: ordinazioni_elenco_cucina(utente: utente,),
                      routeText: "/cucina",
                      text: 'CUCINA',
                      color1: Colors.purple,
                      color2: Colors.purpleAccent,
                      icon: Icons.cake_outlined),
                  utente.get_ruolo() == "Amministratore" ?
                  SizedBox(
                    width: 30,
                  ): SizedBox.shrink(),
                  utente.get_ruolo() == "Amministratore" ?
                  bottoni_gestione(
                      route: statistiche(utente: utente,),
                      routeText: "/statistiche",
                      text: 'STATISTICHE',
                      color1: Colors.green,
                      color2: Colors.lightGreen,
                      icon: Icons.query_stats_outlined) : SizedBox.shrink()
                ],
              )
            ],
          )
        ],
      ),
    );
  }


}
