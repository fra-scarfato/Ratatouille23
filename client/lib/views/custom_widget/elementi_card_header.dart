import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class elementi_card_header extends StatefulWidget{
  final String nome;
  final double costo;

  const elementi_card_header({Key? key, required this.nome, required this.costo}) : super(key: key);
  @override
  elementi_card_header_ui createState() => elementi_card_header_ui();

}

class elementi_card_header_ui extends State<elementi_card_header>{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.nome,
          style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
        ),
        const Spacer(),
        Text(
          'Costo: ${widget.costo}\$',
          style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
        ),
        const SizedBox(width: 176,),
        IconButton(
            onPressed: (){/*modifica_piatto(listaCategorie: [], utente: null, elemento: null,)*/},
            icon: const Icon(
              Icons.mode_edit_outlined,
              size: 50,
            )
        ),
        IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 50,
            )
        ),


      ],
    );
  }

}