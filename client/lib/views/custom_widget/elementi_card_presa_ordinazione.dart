import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'elementi_card_bottom.dart';
import 'elementi_card_header.dart';
import 'elementi_card_presa_ordinazione_header.dart';

class elementi_card_presa_ordinazione extends StatefulWidget{
  final Key key = UniqueKey();
  final String nome;
  final double costo;
  final String descrizione;
  final String allergeni;
  elementi_card_presa_ordinazione({required this.nome, required this.costo, required this.descrizione, required this.allergeni});
  @override
  elementi_card_presa_ordinazione_state createState() => elementi_card_presa_ordinazione_state();
}

class elementi_card_presa_ordinazione_state extends State<elementi_card_presa_ordinazione>{
  @override
  Widget build(BuildContext context) {
    return Card(
      key: UniqueKey(),
      color: Colors.white,
      elevation: 24.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
      child: Padding(
        padding: EdgeInsets.all(15), //apply padding to all four sides
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            elementi_card_presa_ordinazione_header(nome: widget.nome, costo: widget.costo),
            SizedBox(height: 16),
            Container(
              width:1161,
              child: Text(
                  widget.descrizione,
                  style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontSize: 27)
              ),
              //  )
            ),
            SizedBox(height: 32),
            elementi_card_bottom(allergeni: widget.allergeni)
          ],
        ),
      ),

    );
  }
}