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

import 'Login_ui.dart';
import 'menu.dart';
import 'ordinazioni_elenco.dart';
import 'ordinazioni_elenco_cucina.dart';
import 'ordinazioni_vuoto.dart';


class pagina_iniziale_ui extends StatelessWidget {
  late int id;
  late String nome;
  late String cognome;
  late String email;
  late String password;
  late String ruolo;
  late int id_ristorante;
  pagina_iniziale_ui({Key? key}) : super(key : key);
  //TODO: assegnazione variabili utente
  @override
  Widget build(BuildContext context) {
    Amplify_controller amplify_controller = Amplify_controller();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Ratatouille23',
                style:GoogleFonts.sendFlowers(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              SizedBox(
                width: 400,
              ),
              IconButton(
                onPressed: (){
                  amplify_controller.signOutCurrentUser();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login_ui()));
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottoni_gestione(route: registra_utente(id: id, nome: nome, cognome: cognome, email: email, password: password, ruolo: ruolo, id_ristorante: id_ristorante,), text: 'AGGIUNGI UTENTE', color1: Colors.orangeAccent, color2: Colors.yellow, icon: Icons.person_add_alt_1_outlined),
              bottoni_gestione(route: ordinazioni_elenco()/*const ordinazioni_vuoto()*/, text: 'ORDINAZIONI', color1: Colors.pink, color2: Colors.deepOrange, icon: Icons.checklist_outlined),
              bottoni_gestione(route: /*const menu_vuoto()*/menu(id: id, nome: nome, cognome: cognome, email: email, password: password, ruolo: ruolo, id_ristorante: id_ristorante), text: 'MENU', color1: Colors.lightBlue, color2: Colors.lightBlueAccent, icon: Icons.menu_book),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bottoni_gestione(route: ordinazioni_elenco_cucina()/*const registra_utente()*/, text: 'CUCINA', color1: Colors.purple, color2: Colors.purpleAccent, icon: Icons.cake_outlined),
              SizedBox(width: 30,),
              bottoni_gestione(route: /*route*/registra_utente(id: id, nome: nome, cognome: cognome, email: email, password: password, ruolo: ruolo, id_ristorante: id_ristorante), text: 'STATISTICHE', color1: Colors.green, color2: Colors.lightGreen, icon: Icons.query_stats_outlined)
            ],
          )
        ],
      ),
    );
  }


}
