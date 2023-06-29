import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';

import '../../models/Ordinazione.dart';
import '../../models/Utente.dart';

class ordinazioni_cucina_presi_in_carica_card extends StatefulWidget{
  List<Ordinazione> ord;
  Utente utente;
  ordinazioni_cucina_presi_in_carica_card({Key? key, required this.ord, required this.utente}): super(key: key);
  @override
  ordinazioni_cucina_card_presi_in_carica_state createState() => ordinazioni_cucina_card_presi_in_carica_state();
}

class ordinazioni_cucina_card_presi_in_carica_state extends State<ordinazioni_cucina_presi_in_carica_card>{
  late Ordinazione_controller ordinazione_controller;

  @override
  void initState() {
    ordinazione_controller = Ordinazione_controller(utente: widget.utente);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-195,
      child: ListView(
        shrinkWrap: true,
        children: [
          ...ordini_cucina_card(widget.ord),
        ],
      ),

    );
  }

  List<Card> ordini_cucina_card(List<Ordinazione> ord){
    List<Card> list=[];
    for(int i=0;i<ord.length;i++){
      if(/*ord[i].get_gestore_ordinazione()==this*/ord[i].get_stato() == 'Preso in carica'){list.add(Card(
          color: Colors.white,
          elevation: 30.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
          child:Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(width:170),
                      Text(
                        'Quantità',
                        style: GoogleFonts.roboto( fontSize: 36, fontStyle: FontStyle.italic),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height:16),
                  Row(
                    children: [
                      Container(
                        width: 604,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: lista_elementi(ord[i]),

                        ),
                      ),
                      SizedBox(width:114),
                      Column(
                        children: [
                          statoOrdine(ord[i]),
                          SizedBox(height: 50,)
                        ],
                      ),


                    ],
                  )
                ],
              )
          )

      ));};
    }
    return list;
  }

  List<Widget> lista_elementi(Ordinazione ordinazione) {
    double costo=ordinazione.get_costo_totale();
    List<Widget> list=[];
    for(int i=0 ;i< ordinazione.get_lista_elementi().length; i++){
      if (i!=ordinazione.get_lista_elementi().length-1) {
        list.add(buildRiga(ordinazione.get_elemento(i).nome,ordinazione.get_quantita_elemento(i)));
        list.add(Divider(color: Colors.orange,));
      }
      else{
        list.add(buildRiga(ordinazione.get_elemento(i).nome,ordinazione.get_quantita_elemento(i)));
        list.add(Divider(color: Colors.orange,));

      }
    };
    return list;
  }

  Widget buildRiga(String get_nome_elemento, int get_quantita) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$get_nome_elemento',
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
        ),
        SizedBox(width:30),
        Center(
          child: Text(
            '$get_quantita',
            style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(width: 30),

      ],
    );
  }

  Widget statoOrdine(Ordinazione ord) {
    String stato = ord.get_stato();
    Widget bottone_evadi = ElevatedButton(

        onPressed: () {ord.set_stato('Evaso'); /*ordinazione_controller.modifica_ordinazione(ord);*/},
        child: Text(
          '           EVADI           ',
          style:TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),

        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),


        )

    );



      return bottone_evadi;


  }

}