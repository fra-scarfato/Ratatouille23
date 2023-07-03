import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/views/Reset_pwd.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_attesa.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_conferma.dart';
import 'package:ratatouille23/views/pagina_inizialeUI.dart';

import 'custom_widget/Finestra_errore.dart';

class Login_ui extends StatefulWidget {
  const Login_ui({super.key});

  @override
  Login createState() => Login();
}

class Login extends State<Login_ui> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String fullMail = '';
  String fullPassword = '';
  BorderSide borderMail = BorderSide.none;
  Color mailHintTextColor = CupertinoColors.systemGrey;
  BorderSide borderPassword = BorderSide.none;
  Color passwordHintTextColor = CupertinoColors.systemGrey;
  Amplify_controller amplify_controller = Amplify_controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Gestisci la tua attività in modo semplice e veloce',
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
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 509,
              height: 91,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: borderMail,
                        borderRadius: BorderRadius.circular(50)),
                    hintText: 'Inserisci email',
                    hintStyle: TextStyle(color: mailHintTextColor)),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  setState(() {
                    fullMail = text;
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
                    hintText: 'Inserisci la password',
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
                  if (fullMail == '' || fullPassword == '') {
                    if (fullMail == '') {
                      setState(() {
                        borderMail = const BorderSide(color: Colors.red, width: 5);
                        mailHintTextColor = Colors.red;
                      });
                    }
                    if (fullPassword == '') {
                      setState(() {
                        borderPassword =
                            const BorderSide(color: Colors.red, width: 5);
                        passwordHintTextColor = Colors.red;
                      });
                    }
                  } else {
                    var attesa = Finestra_attesa(context);
                    FToast toast = FToast();
                    toast.init(context);
                    try {
                      attesa.showDialogue();
                      var result = await amplify_controller.signInUser(
                          fullMail, fullPassword);
                      if (result.nextStep.signInStep ==
                          AuthSignInStep.confirmSignUp) {
                        attesa.hideProgressDialogue();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reset_pwd_ui(
                                    email: fullMail,
                                    oldPassword: fullPassword)));
                      } else if (result.nextStep.signInStep ==
                          AuthSignInStep.done) {
                        Utente utente = await amplify_controller
                            .fetchCurrentUserAttributes();
                        attesa.hideProgressDialogue();
                        toast.showToast(
                            child: const Finestra_conferma(message: "Accesso completato"),
                            toastDuration: const Duration(seconds: 2),
                            gravity: ToastGravity.BOTTOM);
                        if (utente.get_ruolo() == "Amministratore" ||
                            utente.get_ruolo() == "Supervisore") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      pagina_inizialeUI(utente)));
                        } else if (utente.get_ruolo() == "Addetto alla sala") {
                          //TODO: Prende solo le ordinazioni
                        } else {
                          //TODO: Cuoco
                        }
                      }
                    } on AmplifyException {
                      attesa.hideProgressDialogue();
                      toast.showToast(
                          child: const Finestra_errore(message: 'Email o password sbagliati'),
                          toastDuration: const Duration(seconds: 2),
                          gravity: ToastGravity.BOTTOM);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text(
                  'ACCEDI',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ))
          ],
        )));
  }
}
