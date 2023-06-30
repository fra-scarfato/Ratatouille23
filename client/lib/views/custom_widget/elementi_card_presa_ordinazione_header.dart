import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/Presa_ordinazione_view_controller.dart';
import '../../models/Utente.dart';
import '../../models/menu/Categoria.dart';
import '../../models/menu/Elemento.dart';

class elementi_card_presa_ordinazione_header extends StatefulWidget{
  final String nome;
  final double costo;
  final Utente utente;
  final Elemento elemento;
  int quantita = 0;
  final Presa_ordinazione_view_controller presa_ordinazione_view_controller;

  elementi_card_presa_ordinazione_header({Key? key, required this.nome, required this.costo, required this.utente, required this.elemento, required this.presa_ordinazione_view_controller}) : super(key: key);
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
        Column(
          children: [
            IconButton(
                icon: Icon(
                  Icons.minimize,
                  color: Colors.orangeAccent,
                  size: 50,
                ),
              onPressed: (){
                if(widget.quantita > 0){
                  setState(() {
                    widget.quantita--;
                  });
                  widget.presa_ordinazione_view_controller
                      .rimuovi_quantita(widget.elemento);
                }
              },
            ),
            SizedBox(width: 50,),
          ],
        ),
        // Spacer(),
        ListenableBuilder(
            listenable: widget.presa_ordinazione_view_controller,
            builder: (context, child){
              widget.quantita = widget.presa_ordinazione_view_controller.get_quantita(widget.elemento);
              return Text('${widget.quantita}', style: TextStyle(fontSize: 50),);
            }
        ),
        // Spacer(),
        Column(
          children: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.orangeAccent,
                  size: 50,
                ),
              onPressed: (){
                setState(() {
                  widget.quantita++;
                });
                widget.presa_ordinazione_view_controller
                    .aggiungi_quantita(widget.elemento);
              },
            ),

            SizedBox(width: 20,),
          ],
        ),


      ],
    );
  }

}