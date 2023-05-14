import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/controllers/Utente_controller.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_attesa.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_conferma.dart';
import 'package:ratatouille23/views/custom_widget/bottone_arancione_con_testo.dart';
import 'package:ratatouille23/views/pagina_iniziale.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/Utente.dart';
import 'custom_widget/Finestra_errore.dart';

class Reset_pwd_ui extends StatefulWidget {
  const Reset_pwd_ui({Key? key, required this.email, required this.oldPassword}) : super(key: key);

  final String email;
  final String oldPassword;

  @override
  Reset_pwd createState() => Reset_pwd();
}

class Reset_pwd extends State<Reset_pwd_ui> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationController = TextEditingController();
  String fullPassword = '';
  String confirmationCode = '';
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
                controller: confirmationController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: borderPassword,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    hintText: 'Inserisci codice di conferma',
                    hintStyle: TextStyle(color: passwordHintTextColor)
                ),
                onChanged: (text) {
                  setState(() {
                    confirmationCode = text;
                  });
                },
              ),
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
                    var attesa = Finestra_attesa(context);
                    FToast toast = FToast();
                    toast.init(context);
                    try {
                      attesa.showDialogue();
                      await amplify_controller.confirmUser(username: widget.email, confirmationCode: confirmationCode);
                      await amplify_controller.updatePassword(oldPassword: widget.oldPassword, newPassword: fullPassword);
                      Utente utente =
                          await amplify_controller.fetchCurrentUserAttributes();
                      attesa.hideProgressDialogue();
                      Fluttertoast.cancel();
                      toast.showToast(
                          child: Finestra_conferma(message: "Conferma completata"),
                          toastDuration: Duration(seconds: 2),
                          gravity: ToastGravity.BOTTOM);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  pagina_iniziale(utente)));
                    } catch (error) {
                      attesa.hideProgressDialogue();
                      Fluttertoast.cancel();
                      toast.showToast(
                          child: Finestra_errore(message: "Conferma non riuscita"),
                          toastDuration: Duration(seconds: 2),
                          gravity: ToastGravity.BOTTOM);
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


}
