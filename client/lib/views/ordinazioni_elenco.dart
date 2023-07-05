import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/views/presa_ordinazione.dart';

import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/finestra_nessun_elemento.dart';
import 'custom_widget/ordinazioni_card.dart';

class ordinazioni_elenco extends StatefulWidget{
  final Utente utente;

  const ordinazioni_elenco({super.key, required this.utente});

  @override
  ordinazioni_elenco_state createState() => ordinazioni_elenco_state();
}

class ordinazioni_elenco_state extends State<ordinazioni_elenco>{
  late Ordinazione_controller _ordinazione_controller;

  @override
  void initState() {
    _ordinazione_controller = Ordinazione_controller(utente: widget.utente);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utente utente = widget.utente;
    return FutureBuilder(
        future: _ordinazione_controller.get_ordini_sala(),
        builder: (BuildContext context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done){

            List<Ordinazione> ord = _ordinazione_controller.getListaOrdinazioniSala();

            widget = Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/bubble.png"),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const barra_superiore(text: 'Lista ordinazioni'),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 195,
                        child: ListenableBuilder(
                            listenable: _ordinazione_controller,
                            builder: (context, child) {
                              if(ord.isNotEmpty){
                                return ordinazioni_card(ord: ord, utente: utente, ordinazione_controller: _ordinazione_controller,);
                              } else {
                                return const finestra_nessun_elemento(
                                    string1: 'NON HAI REGISTRATO',
                                    string2: 'NESSUNA ORDINAZIONE',
                                    string3: 'REGISTRA UNA NUOVA',
                                    string4: 'ORDINAZIONE CLICCANDO IL',
                                    string5: 'BOTTONE');
                              }
                          },

                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            displaySelezionaTavolo(context);
                          },
                          child: const Text(
                            'REGISTRA NUOVA ORDINAZIONE',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                          )
                      )
                    ],
                  )
              ),
            );
          } else {
            widget = Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return widget;
        }
    );
  }

  Future<void> displaySelezionaTavolo(BuildContext context) {
    TextEditingController numeroTavoloController = TextEditingController();
    String numeroTavolo = '';
    BorderSide borderSideColorNumeroTavolo = const BorderSide(color: CupertinoColors.systemGrey, width: 5 );
    Color hintColorNumeroTavolo = CupertinoColors.systemGrey;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
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
                          borderSide: borderSideColorNumeroTavolo,
                          borderRadius: BorderRadius.circular(50),

                        ),
                        hintText: 'Inserisci numero del tavolo',
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
                            if(numeroTavolo=='' || !isNumber(numeroTavolo)){
                              setState(() {
                                borderSideColorNumeroTavolo=  const BorderSide(color: Colors.red, width: 5 );
                                hintColorNumeroTavolo= Colors.red;
                              });
                            }else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Presa_ordinazione(
                                          numeroTavolo: numeroTavolo,
                                          utente: widget.utente, ordinazione_controller: _ordinazione_controller,)));
                            }
                          },
                          child: const Text(
                            'PROSEGUI',
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

  bool isNumber(String numeroTavolo) {
    return (int.tryParse(numeroTavolo) != null) && (int.tryParse(numeroTavolo)! > 0);
  }

}