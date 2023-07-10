import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import '../../models/Ordinazione.dart';
import '../../models/Utente.dart';
import 'finestra_nessun_elemento.dart';

class ordinazioni_cucina_card extends StatefulWidget{
  final List<Ordinazione> ord;
  final Ordinazione_controller ordinazione_controller;
  final Utente utente;

  const ordinazioni_cucina_card({Key? key, required this.ord, required this.ordinazione_controller, required this.utente}): super(key: key);
  @override
  ordinazioni_cucina_card_ui createState() => ordinazioni_cucina_card_ui();
}

class ordinazioni_cucina_card_ui extends State<ordinazioni_cucina_card>{
  late Ordinazione_controller ordinazione_controller;

  @override
  void initState() {
    ordinazione_controller = widget.ordinazione_controller;
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
      List<Widget> listaElementi = lista_elementi(ord[i]);
      listaElementi.add(const SizedBox(height: 30,));
      listaElementi.add(Row(
        children: [
          Text("Note: ", style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
          Text(ord[i].get_note(), style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic,),)
        ],
      ));
      list.add(Card(
          color: Colors.white,
          elevation: 30.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
          child:Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 604,
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: listaElementi,
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              statoOrdine(ord[i], ordinazione_controller),
                              const SizedBox(height: 50,)
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ],
              )
          )

      ));
    }
    if(list.isNotEmpty){
      return list;
    } else {
     list.add(
       const Card(
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

  Widget statoOrdine(Ordinazione ord, Ordinazione_controller ordinazioneController) {
    String stato = ord.get_stato();
    Widget bottone_evadi = ElevatedButton(

        onPressed: () {
          setState(() {
          ordinazioneController.evadiOrdinazione(ord);
        });
          ordinazione_controller.modifica_ordinazione_cucina(ord);
          },
        child: const Text(
          '           EVADI           ',
          style:TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),

        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          minimumSize: const Size(500,90),
        )

    );

    Widget bottone_prendi_in_carica= ElevatedButton(
        onPressed: () {
          setState(() {
          ordinazioneController.prendiInCaricoOrdinazione(ord);
        });
          ordinazione_controller.modifica_ordinazione_cucina(ord);
          },

        child: const Text(
          'PRENDI IN CARICA',
          style:TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),

        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          minimumSize: const Size(500,90),
        )

    );

    Widget bottone_gia_preso_in_carica= const Row(
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

    if(stato == "In attesa"){
      return bottone_prendi_in_carica;
    }
    else if(stato == "Presa in carico" && ord.get_gestore_ordinazione()!.get_id() == widget.utente.get_id()){
      return bottone_evadi;
    }
    else {
      return bottone_gia_preso_in_carica;
    }

  }

}