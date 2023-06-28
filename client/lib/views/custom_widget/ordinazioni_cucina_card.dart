import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/controllers/Ordinazione_elenco_cucina_view_controller.dart';
import '../../models/Ordinazione.dart';
import 'finestra_nessun_elemento.dart';

class ordinazioni_cucina_card extends StatefulWidget{
  final List<Ordinazione> ord;
  final String richiesta;
  final Ordinazione_elenco_cucina_view_controller ordinazione_elenco_cucina_view_controller;
  const ordinazioni_cucina_card({Key? key, required this.ord, required this.richiesta, required this.ordinazione_elenco_cucina_view_controller}): super(key: key);
  @override
  ordinazioni_cucina_card_state createState() => ordinazioni_cucina_card_state();
}

class ordinazioni_cucina_card_state extends State<ordinazioni_cucina_card>{
  Ordinazione_controller ordinazione_controller=Ordinazione_controller();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-195,
      child: ListView(
        shrinkWrap: true,
        children: [
          ...ordini_cucina_card(widget.ord, widget.richiesta, widget.ordinazione_elenco_cucina_view_controller),
        ],
      ),

    );
  }

  List<Card> ordini_cucina_card(List<Ordinazione> ord, String richiesta, Ordinazione_elenco_cucina_view_controller ordinazione_elenco_cucina_view_controller){
    List<Card> list=[];
    String daEscludere = "";
    if(richiesta == "IN ATTESA"){
      daEscludere = 'Preso in carica';
    } else if(richiesta == "PRESI IN CARICO"){
      daEscludere = 'In attesa';
    }
    for(int i=0;i<ord.length;i++){
      if((ord[i].get_stato() != 'Evaso') && (ord[i].get_stato() != daEscludere)){list.add(Card(
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
                          statoOrdine(ord[i], ordinazione_elenco_cucina_view_controller),
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
    if(list.isNotEmpty){
      return list;
    } else {
     list.add(
       Card(
         child: finestra_nessun_elemento(
             string1: 'NON SONO',
             string2: 'PRESENTI ORDINAZIONI',
             string3: '',
             string4: '',
             string5: ''),
       )
     );
     return list;
    }
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

  Widget statoOrdine(Ordinazione ord, Ordinazione_elenco_cucina_view_controller ordinazione_elenco_cucina_view_controller) {
    String stato = ord.get_stato();
    Widget bottone_evadi = ElevatedButton(

        onPressed: () {setState(() {
          // ord.set_stato('Evaso');
          ordinazione_elenco_cucina_view_controller.set_stato(ord, 'Evaso');
        }); /*ordinazione_controller.modifica_ordinazione(ord);*/},
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

    Widget bottone_prendi_in_carica= ElevatedButton(
        onPressed: () {setState(() {
          // ord.set_stato('Preso in carica');
          ordinazione_elenco_cucina_view_controller.set_stato(ord, 'Preso in carica');
        }); /*ordinazione_controller.modifica_ordinazione(ord);*/},

        child: Text(
          'PRENDI IN CARICA',
          style:TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),

        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

        )

    );

    Widget bottone_gia_preso_in_carica= Row(
      children: [
        SizedBox(width: 30,),
        Column(
          children: [
            Icon(Icons.timer_outlined, size: 100,),
            Text('Gia preso in carica', style: TextStyle(fontSize: 24),)
          ],
        ),
      ],
    );

    if(stato == 'In attesa'){
      return bottone_prendi_in_carica;
    }
    else if(stato == 'Preso in carica'){
      return bottone_evadi;
    }
    else return bottone_gia_preso_in_carica;

  }

}