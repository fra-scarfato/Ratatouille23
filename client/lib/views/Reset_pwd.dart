
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/controllers/Utente_controller.dart';
import 'package:ratatouille23/views/custom_widget/bottone_arancione_con_testo.dart';
import 'package:ratatouille23/views/pagina_iniziale.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/Utente.dart';

class Reset_pwd_ui extends StatefulWidget {

  const Reset_pwd_ui({Key? key,/*required this.utente,*/required this.id, required this.nome, required this.cognome, required this.email, required this.password, required this.ruolo, required this.id_ristorante}) : super(key : key);
  //final Utente utente;
  final int id;
  final String nome;
  final String cognome;
  final String email;
  final String password;
  final String ruolo;
  final int id_ristorante;

  @override
  Reset_pwd createState() => Reset_pwd();


}



class Reset_pwd extends State<Reset_pwd_ui>{

  TextEditingController passwordController = TextEditingController();
  String fullPassword = '';
  BorderSide borderPassword= BorderSide.none;
  Color passwordHintTextColor= CupertinoColors.systemGrey;
  Amplify_controller amplify_controller = new Amplify_controller();
  Utente_controller _utente_controller = new Utente_controller();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                    'Gestisci la tua attività in modo semplice e veloce',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 10.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ]

                    )
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 509,
                  height: 91,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword ,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: borderPassword,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        hintText: 'Inserisci la nuova password',
                        hintStyle: TextStyle(color: passwordHintTextColor)
                    ),
                    onChanged: (text){
                      setState(() {
                        fullPassword=text;
                      });
                    },
                  ) ,
                ),
                //bottone_arancione_con_testo(text: 'ACCEDI', route: pagina_iniziale())
                ElevatedButton(
                    onPressed: () async {
                        if(fullPassword==''){
                          setState(() {
                            borderPassword=  BorderSide(color: Colors.red, width: 5 );
                            passwordHintTextColor= Colors.red;
                          });
                      } else {
                        try{
                            _utente_controller.resetPassword(/*widget.utente*/widget.id, widget.nome, widget.cognome, widget.email, widget.password, widget.ruolo, widget.id_ristorante, fullPassword);//perche non usare aggiorna_utente?
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>pagina_iniziale_ui()));
                          }catch (error){
                          //TODO: Finestra errore
                          finestra_errore();
                           }
                        }

                    },
                    child: Text(
                      'CAMBIA PASSWORD',
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
        )
    );
  }

  Future<void> finestra_errore() async {
    return showDialog(
        context: context,
        builder: (context){
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
            title: Center(
              child: Padding(
                padding: EdgeInsetsDirectional.all(30.0),
                child: Text(
                  "Errore durante l'operazione",
                  style: GoogleFonts.roboto(fontSize: 44, color: Colors.black),
                ),
              ),
            ),
          );
        }
    );
  }
}