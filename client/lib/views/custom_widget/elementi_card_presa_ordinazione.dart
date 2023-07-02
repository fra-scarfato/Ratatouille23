import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
import 'package:translator/translator.dart';

import '../../controllers/Presa_ordinazione_view_controller.dart';
import 'elementi_card_presa_ordinazione_header.dart';

class elementi_card_presa_ordinazione extends StatefulWidget{
  final Key key = UniqueKey();
  final Utente utente;
  final Elemento elemento;
  final Presa_ordinazione_view_controller presa_ordinazione_view_controller;

  elementi_card_presa_ordinazione({required this.utente, required this.elemento, required this.presa_ordinazione_view_controller});
  @override
  elementi_card_presa_ordinazione_state createState() => elementi_card_presa_ordinazione_state();
}

class elementi_card_presa_ordinazione_state extends State<elementi_card_presa_ordinazione>{
  GoogleTranslator translator = new GoogleTranslator();
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
            elementi_card_presa_ordinazione_header(
                nome: widget.elemento.nome,
                costo: widget.elemento.costo,
                utente: widget.utente,
                elemento: widget.elemento,
                presa_ordinazione_view_controller: widget.presa_ordinazione_view_controller
            ),
            SizedBox(height: 16),
            Container(
              width:1161,
              child: Text(
                  widget.elemento.descrizione,
                  style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontSize: 27)
              ),
              //  )
            ),
            SizedBox(height: 32),
            // elementi_card_bottom(allergeni: widget.elemento.allergeni)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    translator.translate(widget.elemento.descrizione, from: 'en', to: 'it').then(
                            (value){
                          widget.elemento.descrizione = value.toString();
                        }
                    );
                    translator.translate(widget.elemento.allergeni, from: 'en', to: 'it').then(
                            (value){
                          setState(() {
                            widget.elemento.allergeni = value.toString();
                          });
                        }
                    );
                  },
                  child: Flag.fromCode(FlagsCode.IT, height: 30, width: 35),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: (){
                    translator.translate(widget.elemento.descrizione, from: 'it', to: 'en').then(
                            (value){
                          widget.elemento.descrizione = value.toString();
                        }
                    );
                    translator.translate(widget.elemento.allergeni, from: 'it', to: 'en').then(
                            (value){
                          setState(() {
                            widget.elemento.allergeni = value.toString();
                          });
                        }
                    );
                  },
                  child: Flag.fromCode(FlagsCode.GB, height: 30, width: 35),
                ),
                //SizedBox(width: 451,),
                Spacer(),
                Container(
                  width:1020,
                  alignment: AlignmentDirectional.topEnd,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Elenco allergeni:',
                          style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic, color: Colors.orange)
                      ),
                      Expanded(child: Text(
                          widget.elemento.allergeni,
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic)
                      )
                      )
                    ],
                  ),
                ),


              ],
            )
          ],
        ),
      ),

    );
  }
}