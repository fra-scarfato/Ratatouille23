import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/views/custom_widget/modifica_piatto.dart';

class elementi_card_header extends StatefulWidget{
  final String nome;
  final double costo;

  const elementi_card_header({Key? key, required this.nome, required this.costo}) : super(key: key);
  @override
  elementi_card_header_state createState() => elementi_card_header_state();

}

class elementi_card_header_state extends State<elementi_card_header>{
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
            onPressed: (){/*modifica_piatto(listaCategorie: [], utente: null, elemento: null,)*/},
            icon: Icon(
              Icons.mode_edit_outlined,
              size: 50,
            )
        ),
        IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 50,
            )
        ),


      ],
    );
  }

}