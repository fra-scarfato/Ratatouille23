import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_widget/barra_superiore.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class ordinazioni_vuoto extends StatefulWidget{
  const ordinazioni_vuoto({super.key});
  @override
  ordinazioni_vuoto_state createState() => ordinazioni_vuoto_state();
}

class ordinazioni_vuoto_state extends State<ordinazioni_vuoto>{

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bubble.png"),

            ),

          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const barra_superiore(text: '',),
              const finestra_nessun_elemento(string1: 'NON HAI REGISTRATO', string2: 'NESSUNA ORDINAZIONE', string3: 'REGISTRA UNA NUOVA', string4: 'ORDINAZIONE CLICCANDO IL', string5: 'BOTTONE'),
              const SizedBox(height:35),
              ElevatedButton(

                  onPressed: () {
                    displaySelezionaTavolo(context);
                  },
                  child: const Text(
                    'REGISTRA NUOVA ORDINAZIONE',
                    style:TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                  )

              ),
              const SizedBox(
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
      Color borderSideColorNumeroTavolo = CupertinoColors.systemGrey3;
      Color hintColorNumeroTavolo = CupertinoColors.systemGrey3;

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Center(

                  child:Padding(

                    padding: const EdgeInsetsDirectional.all(30.0),
                    child: Text(
                      "A quale tavolo si riferisce l'ordine?",
                      style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                    ),
                  )
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Numero Tavolo',
                    style: GoogleFonts.roboto(fontSize: 44,),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Spacer(),
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
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              actions: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height:40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'ANNULLA',
                              style:TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            )
                        ),
                        const SizedBox(width:80),
                        ElevatedButton(
                            onPressed: () {
                              if(numeroTavolo==''){
                                setState(() {
                                  borderSideColorNumeroTavolo=  Colors.red;
                                  hintColorNumeroTavolo= Colors.red;
                                });
                              }
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu(numerotavolo.toInt()));
                            },
                            child: const Text(
                              'Prosegui',
                              style:TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            )
                        ),

                      ],
                    ),
                    const SizedBox(height:40)
                  ],)
              ],
            );}

      );



  }

}