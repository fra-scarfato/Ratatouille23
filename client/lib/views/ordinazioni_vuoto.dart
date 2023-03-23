import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ratatouille23/views/custom_widget/bottone_arancione_con_testo.dart';
import 'package:ratatouille23/views/menu_vuoto.dart';

import 'barra_superiore.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class ordinazioni_vuoto extends StatelessWidget{
  const ordinazioni_vuoto({super.key});
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bubble.png"),

            ),

          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              barra_superiore(),
              finestra_nessun_elemento(string1: 'NON HAI REGISTRATO', string2: 'NESSUNA ORDINAZIONE', string3: 'REGISTRA UNA NUOVA', string4: 'ORDINAZIONE CLICCANDO IL', string5: 'BOTTONE'),
              SizedBox(height:35),
              bottone_arancione_con_testo(text: 'REGISTRA NUOVA ORDINAZIONE', route: menu_vuoto()),
              SizedBox(
                height: 8,
              )

            ],
          )
      ),
    );

  }

}