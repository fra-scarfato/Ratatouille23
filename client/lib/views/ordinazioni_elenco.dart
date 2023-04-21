import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';
import 'package:ratatouille23/views/ordinazioni_vuoto.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import '../models/menu/Elemento.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/ordinazioni_card.dart';

class ordinazioni_elenco extends StatefulWidget{

  // @override
  // Widget build(BuildContext context) {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     builder: (context, child) =>
  //         ResponsiveWrapper.builder(
  //           child,
  //           maxWidth: 1200,
  //           minWidth: 480,
  //           defaultScale: true,
  //           breakpoints: [
  //             ResponsiveBreakpoint.resize(480, name: MOBILE),
  //             ResponsiveBreakpoint.autoScale(800, name: TABLET),
  //             ResponsiveBreakpoint.resize(1000, name: DESKTOP),
  //           ],
  //
  //         ),
  //
  //
  //
  //    // initialRoute: "/",
  //
  //   );
  // }

  @override
  ordinazioni_elenco_state createState() => ordinazioni_elenco_state();
}

class ordinazioni_elenco_state extends State<ordinazioni_elenco>{
  Ordinazione_controller ordinazione_controller = Ordinazione_controller();
  Ordinazione_service ordinazione_service = Ordinazione_service();
  // List<Elemento_ordinato> elem=[Elemento_ordinato(5656, Elemento(47,'pera','frutto dolce',1.5,'',37), 1),Elemento_ordinato(5656, Elemento(42,'mela','frutto dolce',1.3,'',31), 3)];
  //
  // late List<Ordinazione> ord=[Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),
  //   Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45))]; //= ordinazione_controller.getAll_ordini() as List<Ordinazione>;//ord = getall_ordini
  /*@override
  void initState() {
    Future.delayed(Duration.zero,() async {
      ord = await ordinazione_service.elenco_ordinazioni();
    });
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
              height: MediaQuery.of(context).size.height-195,
              // child: ordinazioni_card(ord: ord),

            ),
            ElevatedButton(

                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
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
    BorderSide borderSideColorNumeroTavolo = BorderSide(color: CupertinoColors.systemGrey, width: 5 );
    Color hintColorNumeroTavolo = CupertinoColors.systemGrey;

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
                            if(numeroTavolo==''){
                              setState(() {
                                print('oh');
                                borderSideColorNumeroTavolo=  BorderSide(color: Colors.red, width: 5 );
                                hintColorNumeroTavolo= Colors.red;
                              });
                            }
                            print(int.parse(numeroTavolo));
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu(numerotavolo.toInt()));
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

}