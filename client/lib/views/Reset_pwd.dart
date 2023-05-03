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
import 'custom_widget/Finestra_errore.dart';

class Reset_pwd_ui extends StatefulWidget {
  const Reset_pwd_ui({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  Reset_pwd createState() => Reset_pwd();
}

class Reset_pwd extends State<Reset_pwd_ui> {
  TextEditingController passwordController = TextEditingController();
  String fullPassword = '';
  BorderSide borderPassword = BorderSide.none;
  Color passwordHintTextColor = CupertinoColors.systemGrey;
  Amplify_controller amplify_controller = new Amplify_controller();
  Utente_controller _utente_controller = new Utente_controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gestisci la tua attività in modo semplice e veloce',
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
                    ])),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 509,
              height: 91,
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: borderPassword,
                        borderRadius: BorderRadius.circular(50)),
                    hintText: 'Inserisci la nuova password',
                    hintStyle: TextStyle(color: passwordHintTextColor)),
                onChanged: (text) {
                  setState(() {
                    fullPassword = text;
                  });
                },
              ),
            ),
            //bottone_arancione_con_testo(text: 'ACCEDI', route: pagina_iniziale())
            ElevatedButton(
                onPressed: () async {
                  if (fullPassword == '') {
                    setState(() {
                      borderPassword = BorderSide(color: Colors.red, width: 5);
                      passwordHintTextColor = Colors.red;
                    });
                  } else {
                    try {
                      showDialogue(context);
                      await amplify_controller.resetPassword(fullPassword);
                      Utente utente =
                          await amplify_controller.fetchCurrentUserAttributes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  pagina_iniziale(utente)));
                    } catch (error) {
                      //TODO: Finestra errore
                      error.toString();
                      Finestra_errore(title: 'Errore!', content: "Reset password non riuscito",);
                    }
                  }
                },
                child: Text(
                  'CAMBIA PASSWORD',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ))
          ],
        )));
  }


  void showDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void hideProgressDialogue(BuildContext context) {
    Navigator.of(context).pop(
      Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
