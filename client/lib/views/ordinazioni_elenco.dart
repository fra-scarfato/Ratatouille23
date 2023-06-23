import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/controllers/Ordinazione_elenco_view_controller.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';
import 'package:ratatouille23/views/ordinazioni_vuoto.dart';
import 'package:ratatouille23/views/presa_ordinazione.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import '../models/menu/Elemento.dart';
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
  Ordinazione_controller _ordinazione_controller = new Ordinazione_controller();
  Ordinazione_elenco_view_controller _ordinazione_elenco_view_controller = Ordinazione_elenco_view_controller();

  List<Elemento_ordinato> elem=[Elemento_ordinato(5656, Elemento(47,'pera','frutto dolce',1.5,'',Categoria(1,'n',[],1)), 1),Elemento_ordinato(5656, Elemento(42,'mela','frutto dolce',1.3,'',Categoria(1,'n',[],1)), 3)];

  @override
  Widget build(BuildContext context) {
    Utente utente = widget.utente;
    // _ordinazione_elenco_view_controller.set_ordinazioni([Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so',45)),
    //   Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so',45)),
    //   Ordinazione(001, 3, 'boh nota molto lunga per appesantire chi legge e chi scrive e per testtare la grafica che sembra fatta da un babbeo', elem, Utente(01,'er','va','ap','so',45)),
    //   Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so',45))]);
    // List<Ordinazione> ord = _ordinazione_elenco_view_controller.get_ordinazioni();
    return FutureBuilder(
        future: _ordinazione_controller.getAll_ordini(utente),
        builder: (BuildContext context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done){
            _ordinazione_elenco_view_controller.set_ordinazioni(snapshot.data);
            List<Ordinazione> ord = _ordinazione_elenco_view_controller.get_ordinazioni();

            widget = Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/bubble.png"),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      barra_superiore(text: 'Lista ordinazioni'),
                      SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 195,
                        child: ListenableBuilder(
                            listenable: _ordinazione_elenco_view_controller,
                            builder: (context, child) {
                              if(ord.isNotEmpty){
                                return ordinazioni_card(ord: ord);
                              } else {
                                return finestra_nessun_elemento(
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
                          child: Text(
                            'REGISTRA NUOVA ORDINAZIONE',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
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
              child: Center(
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
    Color colore=Colors.black.withOpacity(0.1);
    BorderSide borderSideColorNumeroTavolo = BorderSide(color: CupertinoColors.systemGrey, width: 5 );
    Color hintColorNumeroTavolo = CupertinoColors.systemGrey;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
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
                            if(numeroTavolo=='' || !isNumber(numeroTavolo)){
                              setState(() {
                                borderSideColorNumeroTavolo=  BorderSide(color: Colors.red, width: 5 );
                                hintColorNumeroTavolo= Colors.red;
                              });
                            }else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Presa_ordinazione(
                                          numeroTavolo: numeroTavolo,
                                          utente: widget.utente)));
                            }
                          },
                          child: Text(
                            'PROSEGUI',
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

  bool isNumber(String numeroTavolo) {
    return (int.tryParse(numeroTavolo) != null) && (int.tryParse(numeroTavolo)! > 0);
  }

}