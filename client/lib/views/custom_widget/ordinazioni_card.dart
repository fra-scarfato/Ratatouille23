import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';

import '../../models/Ordinazione.dart';
import '../../models/Utente.dart';
import 'Finestra_errore.dart';

class ordinazioni_card extends StatefulWidget{
  List<Ordinazione> ord;
  Utente utente;
  Ordinazione_controller ordinazione_controller;

  ordinazioni_card({Key? key, required this.ord, required this.utente, required this.ordinazione_controller}): super(key: key);

  @override
  ordinazioni_card_state createState() => ordinazioni_card_state();
  }

class ordinazioni_card_state extends State<ordinazioni_card>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          ...ordini_card(widget.ord),
        ],
      ),

    );
  }

  List<Card> ordini_card(List<Ordinazione> ord){
    List<Card> list=[];
    for(int i=0;i<ord.length;i++){
      list.add(Card(
          color: Colors.white,
          elevation: 24.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
          child:Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Tavolo n.',
                        style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        '${ord[i].get_tavolo()}',
                        style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: (){
                            //TODO
                          },
                          icon: Icon(
                            Icons.mode_edit_outlined,
                            size: 50,
                          )
                      ),
                      SizedBox(width:16),
                      IconButton(
                          onPressed: () async {
                            try{
                              await widget.ordinazione_controller.elimina_ordinazione_sala(ord[i]);
                            } catch (error) {
                              FToast toast = FToast();
                              toast.showToast(
                                  child: Finestra_errore(message: "Impossibile eliminare l'ordinazione.$error"),
                                  toastDuration: const Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                          }},
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 50,
                          )
                      ),

                    ],
                  ),
                  SizedBox(height:16),
                  Container(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: lista_elementi(ord[i]),
                    ),
                  ),
                  Container(
                    width:1161,
                    child: Text(
                        ord[i].get_note(),
                        style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontSize: 27)
                    ),
                  )


                ],
              )
          )

      ));
    }
    return list;
  }

  List<Widget> lista_elementi(Ordinazione ordinazione) {
    double costo=ordinazione.get_costo_totale();
    List<Widget> list=[];
    for(int i=0 ;i< ordinazione.get_lista_elementi().length; i++){
      if (i!=ordinazione.get_lista_elementi().length-1) {
        list.add(buildRiga(ordinazione.get_elemento(i).nome,ordinazione.get_quantita_elemento(i),ordinazione.get_elemento(i).costo));
        list.add(Divider(color: Colors.orange,));
      }
      else{
        list.add(buildRiga(ordinazione.get_elemento(i).nome,ordinazione.get_quantita_elemento(i),ordinazione.get_elemento(i).costo));
        list.add(Divider(color: Colors.orange,));
        list.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Totale:',
                      style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      '$costo\$',
                      style: GoogleFonts.roboto(fontSize: 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
        );
      }
    };
    return list;
  }

  Widget buildRiga(String getNomeElemento, int getQuantita, double getCostoElemento) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$getNomeElemento',
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
        ),
        //SizedBox(width:100),
        Center(
          child: Text(
            '$getQuantita',
            style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
          ),
        ),
        //SizedBox(width:100),
        Text(
          '$getCostoElemento\$',
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic, ),
        ),
        SizedBox(width: 30),

      ],
    );
  }

}