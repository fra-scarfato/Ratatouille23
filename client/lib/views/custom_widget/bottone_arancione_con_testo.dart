

import 'package:flutter/material.dart';

class bottone_arancione_con_testo extends StatelessWidget{
  final String text;
  final Widget route;

  const bottone_arancione_con_testo({super.key, required this.text, required this.route });
  @override
  Widget build(BuildContext context){
    return ElevatedButton(

        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => route));
        },
        child: Text(
          '$text',
          style:const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),

        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

        )

    );
  }
}

