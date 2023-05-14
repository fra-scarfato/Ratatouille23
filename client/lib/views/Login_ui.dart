
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/controllers/Utente_controller.dart';
import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/views/Reset_pwd.dart';
import 'package:ratatouille23/views/custom_widget/bottone_arancione_con_testo.dart';
import 'package:ratatouille23/views/pagina_iniziale.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'custom_widget/Finestra_errore.dart';

class Login_ui extends StatefulWidget {

  const Login_ui({super.key});

  @override
  Login createState() => Login();


}

class Login extends State<Login_ui>{
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String fullMail = '';
  String fullPassword = '';
  BorderSide borderMail= BorderSide.none;
  Color mailHintTextColor= CupertinoColors.systemGrey;
  BorderSide borderPassword= BorderSide.none;
  Color passwordHintTextColor= CupertinoColors.systemGrey;
  Amplify_controller amplify_controller = new Amplify_controller();
  
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
    Navigator.of(context).pop(Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),);}

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
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: borderMail,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci email',
                      hintStyle: TextStyle(color: mailHintTextColor)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (text){
                      setState(() {
                        fullMail=text;
                      });
                    },
                  ) ,
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
                      hintText: 'Inserisci la password',
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
                      if(fullMail=='' || fullPassword==''){
                        if(fullMail==''){
                          setState(() {
                            borderMail=  BorderSide(color: Colors.red, width: 5 );
                            mailHintTextColor= Colors.red;
                          });
                        }
                        if(fullPassword==''){
                          setState(() {
                            borderPassword=  BorderSide(color: Colors.red, width: 5 );
                            passwordHintTextColor= Colors.red;
                          });
                        }
                      } else {
                        try{
                          showDialogue(context);
                          var result = await amplify_controller.signInUser(fullMail, fullPassword);
                          if(result.nextStep.signInStep == AuthSignInStep.confirmSignUp) {
                            hideProgressDialogue(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Reset_pwd_ui(email: fullMail, oldPassword: fullPassword)));
                          }
                          else if(result.nextStep.signInStep == AuthSignInStep.done) {
                            Utente utente = await amplify_controller.fetchCurrentUserAttributes();
                            hideProgressDialogue(context);
                            if(utente.get_ruolo() == "Amministratore" || utente.get_ruolo() == "Supervisore") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  pagina_iniziale(utente)));
                            } else if (utente.get_ruolo() == "Addetto alla sala") {
                              //TODO: Prende solo le ordinazioni
                            } else {
                              //TODO: Cuoco
                            }
                          }
                        }catch (error){
                          hideProgressDialogue(context);
                          Finestra_errore(title: 'Errore!', content: "Mail o password sbagliata",).showAlert(context);
                        }
                      }
                         
                      },
                    child: Text(
                      'ACCEDI',
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
}