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
  ordinazioni_cucina_card_presi_in_carica_ui createState() => ordinazioni_cucina_card_presi_in_carica_ui();
}

class ordinazioni_cucina_card_presi_in_carica_ui extends State<ordinazioni_cucina_presi_in_carica_card>{
  late Ordinazione_controller ordinazione_controller;

  @override
  void initState() {
    ordinazione_controller = Ordinazione_controller(utente: widget.utente);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
          child:Padding(
              padding: const EdgeInsets.all(15),
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
                      const SizedBox(width:170),
                      Text(
                        'Quantità',
                        style: GoogleFonts.roboto( fontSize: 36, fontStyle: FontStyle.italic),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height:16),
                  Row(
                    children: [
                      SizedBox(
                        width: 604,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: lista_elementi(ord[i]),

                        ),
                      ),
                      const SizedBox(width:114),
                      Column(
                        children: [
                          statoOrdine(ord[i]),
                          const SizedBox(height: 50,)
                        ],
                      ),


                    ],
                  )
                ],
              )
          )

      ));}
    }
    return list;
  }

  List<Widget> lista_elementi(Ordinazione ordinazione) {
    List<Widget> list=[];
    for(int i=0 ;i< ordinazione.get_lista_elementi().length; i++){
      if (i!=ordinazione.get_lista_elementi().length-1) {
        list.add(buildRiga(ordinazione.get_elemento(i).nome,ordinazione.get_quantita_elemento(i)));
        list.add(const Divider(color: Colors.orange,));
      }
      else{
        list.add(buildRiga(ordinazione.get_elemento(i).nome,ordinazione.get_quantita_elemento(i)));
        list.add(const Divider(color: Colors.orange,));

      }
    }
    return list;
  }

  Widget buildRiga(String get_nome_elemento, int get_quantita) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          get_nome_elemento,
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
        ),
        const SizedBox(width:30),
        Center(
          child: Text(
            '$get_quantita',
            style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(width: 30),

      ],
    );
  }

  Widget statoOrdine(Ordinazione ord) {
    Widget bottone_evadi = ElevatedButton(

        onPressed: () {ord.set_stato('Evasa'); /*ordinazione_controller.modifica_ordinazione(ord);*/},

        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),


        ),
        child: const Text(
          '           EVADI           ',
          style:TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        )

    );



      return bottone_evadi;


  }

}