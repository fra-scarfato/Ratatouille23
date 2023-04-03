import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class elementi_card_presa_ordinazione_header extends StatefulWidget{
  final String nome;
  final double costo;
  int quantita_da_ordinare=0;

  elementi_card_presa_ordinazione_header({Key? key, required this.nome, required this.costo}) : super(key: key);
  @override
  elementi_card_presa_ordinazione_header_state createState() => elementi_card_presa_ordinazione_header_state();

}

class elementi_card_presa_ordinazione_header_state extends State<elementi_card_presa_ordinazione_header>{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.nome,
          style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
        ),
        Spacer(),
        Text(
          'Costo: ${widget.costo}\$',
          style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
        ),
        SizedBox(width: 176,),
        IconButton(
            onPressed: (){setState(() {
              widget.quantita_da_ordinare--;
            });},
            icon: Icon(
              Icons.minimize,
              color: Colors.orangeAccent,
              size: 50,
            )
        ),
        Text('${widget.quantita_da_ordinare}'),
        IconButton(
            onPressed: (){setState(() {
              widget.quantita_da_ordinare++;
            });},
            icon: Icon(
              Icons.add,
              color: Colors.orangeAccent,
              size: 50,
            )
        ),


      ],
    );
  }

}