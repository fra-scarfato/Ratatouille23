import 'package:flutter/cupertino.dart';
import 'package:ratatouille23/controllers/Categoria__controller.dart';
import 'package:ratatouille23/controllers/Utente_controller.dart';

class mostra_categorie extends StatefulWidget{
  mostra_categorie_state createState() => mostra_categorie_state();
}

class mostra_categorie_state extends State<mostra_categorie>{
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 67,
        width: MediaQuery.of(context).size.width,
        child:ListView(
            scrollDirection: Axis.horizontal,
            children: /*<Widget>[
                categorie_card('Primi'),
                categorie_card('Secondi'),
                categorie_card('Contorni'),
                categorie_card('Frutta'),
                categorie_card('Dolci'),
                categorie_card('Primi'),
                categorie_card('Secondi'),
                categorie_card('Contorni'),
                categorie_card('Frutta'),
                categorie_card('Dolci'),
                categorie_card('Primi'),
                categorie_card('Secondi'),
                categorie_card('Contorni'),
                categorie_card('Frutta'),
                categorie_card('Dolci'),
              ]*/

        )
    );
  }
}