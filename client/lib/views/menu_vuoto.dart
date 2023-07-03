

import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:ratatouille23/views/custom_widget/barra_superiore.dart';
import 'package:flutter/material.dart';

import '../models/Utente.dart';
import 'custom_widget/bottone_gestione_menu_admin.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class menu_vuoto extends StatefulWidget {
  const menu_vuoto({super.key, required this.utente, required this.menu_controller});
  final Utente utente;
  final Menu_controller menu_controller;
  @override
  menu_vuoto_ui createState() => menu_vuoto_ui();

}



class menu_vuoto_ui extends State<menu_vuoto>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bubble.png"),

            ),

          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const barra_superiore(text: '',),
              const finestra_nessun_elemento(string1: 'NON CI SONO PIATTI', string2: 'NEL TUO MENU', string3: 'CREA UNA CATEGORIA E', string4: 'AGGIUNGI UN NUOVO PIATTO', string5: 'CLICCANDO IL BOTTONE'),
              const SizedBox(height:35),
              bottone_gestione_menu_admin(listaCategorie: const [], utente: widget.utente, menu_controller: widget.menu_controller,),
              const SizedBox(
                height: 8,
              )

            ],
          )
      ),
    );
  }










}

