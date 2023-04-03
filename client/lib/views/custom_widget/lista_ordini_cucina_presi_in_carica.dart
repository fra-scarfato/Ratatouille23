import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/Ordinazione.dart';
import 'ordinazioni_cucina_card.dart';

class lista_ordini_cucina_presi_in_carica extends StatefulWidget {
  const lista_ordini_cucina_presi_in_carica({
    Key? key,
    required this.ord,
  }) : super(key: key);

  final List<Ordinazione> ord;

  @override
  lista_ordini_cucina_presi_in_carica_state createState() => lista_ordini_cucina_presi_in_carica_state();


}

class lista_ordini_cucina_presi_in_carica_state extends State<lista_ordini_cucina_presi_in_carica>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-195,
            child:ordinazioni_cucina_card(ord: widget.ord)),
        SizedBox(height: 10,),
        Container(
          width: 100,
          child: ElevatedButton(

            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle_outlined, size: 25, color: Colors.orangeAccent,),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 25, color: Colors.orangeAccent,),                    ],
            ),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            ),
          ),
        )
      ],
    );
  }
}