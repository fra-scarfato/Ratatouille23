import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/views/pagina_iniziale.dart';

import '../../models/Ordinazione.dart';

class Visualizza_riepilogo extends StatefulWidget{
  final Ordinazione ordinazione;
  Visualizza_riepilogo(this.ordinazione);
  Visualizza_riepilogo_state createState() => Visualizza_riepilogo_state();
}

class Visualizza_riepilogo_state extends State<Visualizza_riepilogo>{
  TextEditingController noteController= TextEditingController();
  String note='';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
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
                          '${widget.ordinazione.get_tavolo()}',
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
                        children: lista_elementi(widget.ordinazione),

                      ),
                    ),
                    SizedBox(
                      width: 509,
                      height: 200,
                      child: TextFormField(
                        controller: noteController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: CupertinoColors.systemGrey, width: 5),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            hintText: 'Inserisci email',
                            hintStyle: TextStyle(color: CupertinoColors.systemGrey)
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (text){
                          setState(() {
                            note=text;
                          });
                        },
                      ) ,
                    ),



                  ],
                )
            )

        ),
        ElevatedButton(

            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pagina_iniziale_ui()));
            },
            child: Text(
              'CONFERMA ORDINE',
              style:TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),

            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              backgroundColor: Colors.orange,
              //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

            )

        )
      ],
    );
  }


  List<Widget> lista_elementi(Ordinazione ordinazione) {
    double costo=ordinazione.get_costo_totale();
    List<Widget> list=[];
    for(int i=0 ;i< ordinazione.get_lista_elementi().length; i++){
      if (i!=ordinazione.get_lista_elementi().length-1) {
        list.add(buildRiga(ordinazione.get_elemento(i).get_nome(),ordinazione.get_quantita_elemento(i),ordinazione.get_elemento(i).get_costo()));
        list.add(Divider(color: Colors.orange,));
      }
      else{
        list.add(buildRiga(ordinazione.get_elemento(i).get_nome(),ordinazione.get_quantita_elemento(i),ordinazione.get_elemento(i).get_costo()));
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