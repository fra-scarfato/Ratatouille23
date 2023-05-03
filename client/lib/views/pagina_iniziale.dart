import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/views/custom_widget/bottoni_gestione.dart';
import 'package:ratatouille23/views/menu_vuoto.dart';
import 'package:ratatouille23/views/registra_utente.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/Utente_controller.dart';
import '../models/Utente.dart';
import 'Login_ui.dart';
import 'menu.dart';
import 'ordinazioni_elenco.dart';
import 'ordinazioni_elenco_cucina.dart';
import 'ordinazioni_vuoto.dart';

class pagina_iniziale extends StatelessWidget {
  late Utente utente;
  late Amplify_controller amplify_controller;
  late Utente_controller utente_controller;

  pagina_iniziale(this.utente);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ratatouille23',
                style: GoogleFonts.sendFlowers(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              SizedBox(
                width: 400,
              ),
              IconButton(
                onPressed: () {
                  amplify_controller.signOutCurrentUser();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login_ui()));
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  utente.get_ruolo() == "Amministratore" ?
                  bottoni_gestione(
                      route: registra_utente(
                        utente: utente,
                      ),
                      text: 'AGGIUNGI UTENTE',
                      color1: Colors.orangeAccent,
                      color2: Colors.yellow,
                      icon: Icons.person_add_alt_1_outlined) : SizedBox.shrink(),
                  bottoni_gestione(
                      route: ordinazioni_elenco() /*const ordinazioni_vuoto()*/,
                      text: 'ORDINAZIONI',
                      color1: Colors.pink,
                      color2: Colors.deepOrange,
                      icon: Icons.checklist_outlined),
                  //bottoni_gestione(route: /*const menu_vuoto()*/menu(utente), text: 'MENU', color1: Colors.lightBlue, color2: Colors.lightBlueAccent, icon: Icons.menu_book),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bottoni_gestione(
                      route: ordinazioni_elenco_cucina(),
                      text: 'CUCINA',
                      color1: Colors.purple,
                      color2: Colors.purpleAccent,
                      icon: Icons.cake_outlined),
                  SizedBox(
                    width: 30,
                  ),
                  utente.get_ruolo() == "Amministratore" ?
                  bottoni_gestione(
                      route: /*route*/ registra_utente(
                        utente: utente,
                      ),
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
