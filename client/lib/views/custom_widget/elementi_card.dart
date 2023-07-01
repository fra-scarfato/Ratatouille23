import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:translator/translator.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';

import '../../models/Utente.dart';
import '../../models/menu/Categoria.dart';
import '../../models/menu/Elemento.dart';
import 'Finestra_conferma.dart';
import 'elementi_card_bottom.dart';
import 'elementi_card_header.dart';
import 'modifica_piatto.dart';

class elementi_card extends StatefulWidget{
  final Key key = UniqueKey();
  final Utente utente;
  final Elemento elemento;
  final List<Categoria>? listaCategorie;

  elementi_card({required this.utente, required this.elemento, required this.listaCategorie});

  @override
  elementi_card_state createState() => elementi_card_state();
}

class elementi_card_state extends State<elementi_card>{
  Menu_controller menu_controller=Menu_controller();
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
            //elementi_card_header(nome: widget.nome, costo: widget.costo),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.elemento.nome,
                  style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                ),
                Spacer(),
                Text(
                  'Costo: ${widget.elemento.costo}\$',
                  style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                ),
                SizedBox(width: 170,),
                IconButton(
                    onPressed: (){Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>
                            modifica_piatto(listaCategorie: widget.listaCategorie,
                                utente: widget.utente, elemento: widget.elemento)));},
                    icon: Icon(
                      Icons.mode_edit_outlined,
                      size: 50,
                    )
                ),
                IconButton(
                    onPressed: (){
                      FToast toast = FToast();
                      Fluttertoast.cancel();
                      toast.showToast(
                          child: Finestra_conferma(message: "Elemento rimosso"),
                          toastDuration: Duration(seconds: 2),
                          gravity: ToastGravity.BOTTOM);
                      menu_controller.rimuoviElemento(widget.elemento);
                      },
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 50,
                    )
                ),


              ],
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