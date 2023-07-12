import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
import 'package:translator/translator.dart';

import '../../controllers/Presa_ordinazione_view_controller.dart';
import 'elementi_card_presa_ordinazione_header.dart';

class elementi_card_presa_ordinazione extends StatefulWidget{
  @override
  final Key key = UniqueKey();
  final Utente utente;
  final Elemento elemento;
  final Presa_ordinazione_view_controller presa_ordinazione_view_controller;
  String descrizioneElemento = "";
  String allergeniElemento = "";

  elementi_card_presa_ordinazione({super.key, required this.utente, required this.elemento, required this.presa_ordinazione_view_controller});
  @override
  elementi_card_presa_ordinazione_ui createState() => elementi_card_presa_ordinazione_ui();
}

class elementi_card_presa_ordinazione_ui extends State<elementi_card_presa_ordinazione>{
  GoogleTranslator translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    widget.allergeniElemento = widget.elemento.allergeni;
    widget.descrizioneElemento = widget.elemento.descrizione;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: UniqueKey(),
      color: Colors.white,
      elevation: 24.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
      child: Padding(
        padding: const EdgeInsets.all(15), //apply padding to all four sides
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            elementi_card_presa_ordinazione_header(
                nome: widget.elemento.nome,
                costo: widget.elemento.costo,
                utente: widget.utente,
                elemento: widget.elemento,
                presa_ordinazione_view_controller: widget.presa_ordinazione_view_controller,
                quantita: 0,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width:1161,
              child: Text(
                  widget.descrizioneElemento,
                  style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontSize: 27)
              ),
              //  )
            ),
            const SizedBox(height: 32),
            // elementi_card_bottom(allergeni: widget.elemento.allergeni)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      widget.descrizioneElemento = widget.elemento.descrizione;
                      widget.allergeniElemento = widget.elemento.allergeni;
                    });
                  },
                  child: Flag.fromCode(FlagsCode.IT, height: 30, width: 35),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: (){
                    setState(() {
                      translator.translate(widget.elemento.descrizione, from: 'it', to: 'en').then(
                              (value){
                                widget.descrizioneElemento = value.toString();
                          }
                      );
                      translator.translate(widget.elemento.allergeni, from: 'it', to: 'en').then(
                              (value){
                            setState(() {
                              widget.allergeniElemento = value.toString();
                            });
                          }
                      );
                    });

                  },
                  child: Flag.fromCode(FlagsCode.GB, height: 30, width: 35),
                ),
                //SizedBox(width: 451,),
                const Spacer(),
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
                          widget.allergeniElemento,
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