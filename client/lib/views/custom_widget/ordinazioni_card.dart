import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/Ordinazione.dart';

class ordinazioni_card extends StatefulWidget{
  List<Ordinazione> ord;
  ordinazioni_card({Key? key, required this.ord}): super(key: key);
  @override
  ordinazioni_card_state createState() => ordinazioni_card_state();
  }

class ordinazioni_card_state extends State<ordinazioni_card>{
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
                          onPressed: (){},
                          icon: Icon(
                            Icons.mode_edit_outlined,
                            size: 50,
                          )
                      ),
                      SizedBox(width:16),
                      IconButton(
                          onPressed: (){},
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

  Widget buildRiga(String get_nome_elemento, int get_quantita, double get_costo_elemento) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$get_nome_elemento',
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
        ),
        //SizedBox(width:100),
        Center(
          child: Text(
            '$get_quantita',
            style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
          ),
        ),
        //SizedBox(width:100),
        Text(
          '$get_costo_elemento\$',
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic, ),
        ),
        SizedBox(width: 30),

      ],
    );
  }

}