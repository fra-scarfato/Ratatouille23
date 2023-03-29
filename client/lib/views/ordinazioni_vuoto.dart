import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/views/custom_widget/bottone_arancione_con_testo.dart';
import 'package:ratatouille23/views/menu_vuoto.dart';

import 'custom_widget/barra_superiore.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class ordinazioni_vuoto extends StatefulWidget{
  const ordinazioni_vuoto({super.key});
  ordinazioni_vuoto_state createState() => ordinazioni_vuoto_state();
}

class ordinazioni_vuoto_state extends State<ordinazioni_vuoto>{

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bubble.png"),

            ),

          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              barra_superiore(text: '',),
              finestra_nessun_elemento(string1: 'NON HAI REGISTRATO', string2: 'NESSUNA ORDINAZIONE', string3: 'REGISTRA UNA NUOVA', string4: 'ORDINAZIONE CLICCANDO IL', string5: 'BOTTONE'),
              SizedBox(height:35),
              ElevatedButton(

                  onPressed: () {
                    displaySelezionaTavolo(context);
                  },
                  child: Text(
                    'REGISTRA NUOVA ORDINAZIONE',
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

              ),
              SizedBox(
                height: 8,
              )

            ],
          )
      ),
    );

  }

  Future<void> displaySelezionaTavolo(BuildContext context) {


      TextEditingController numeroTavoloController = TextEditingController();
      String numeroTavolo = '';
      Color colore=Colors.black.withOpacity(0.1);
      Color borderSideColorNumeroTavolo = CupertinoColors.systemGrey3;
      Color hintColorNumeroTavolo = CupertinoColors.systemGrey3;

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Center(

                  child:Padding(

                    padding: EdgeInsetsDirectional.all(30.0),
                    child: Text(
                      "A quale tavolo si riferisce l'ordine?",
                      style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                    ),
                  )
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Numero Tavolo',
                    style: GoogleFonts.roboto(fontSize: 44,),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Spacer(),
                  SizedBox(
                    width: 522,
                    height: 54,
                    child: TextFormField(
                      controller: numeroTavoloController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: borderSideColorNumeroTavolo,
                                width: 5.0
                            ),
                            borderRadius: BorderRadius.circular(50),

                          ),
                          hintText: 'Inserisci il nome della categoria',
                          hintStyle: TextStyle(color: hintColorNumeroTavolo)
                      ),
                      onChanged: (text){
                        setState(() {
                          numeroTavolo=text;
                        });
                      },
                    ) ,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              actions: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height:40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
                              Navigator.pop(context);
                            },
                            child: Text(
                              'ANNULLA',
                              style:TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            )
                        ),
                        SizedBox(width:80),
                        ElevatedButton(
                            onPressed: () {
                              if(numeroTavolo==''){
                                setState(() {
                                  borderSideColorNumeroTavolo=  Colors.red;
                                  hintColorNumeroTavolo= Colors.red;
                                });
                              }
                              print(int.parse(numeroTavolo));
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu(numerotavolo.toInt()));
                            },
                            child: Text(
                              'Prosegui',
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
                        ),

                      ],
                    ),
                    SizedBox(height:40)
                  ],)
              ],
            );}

      );



  }

}