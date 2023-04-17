import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratatouille23/views/custom_widget/bottone_arancione_con_testo.dart';
import 'package:ratatouille23/views/pagina_iniziale.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class Login_ui extends StatefulWidget {

  const Login_ui({super.key});

  @override
  Login createState() => Login();


}

class Login extends State<Login_ui>{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String fullMail = '';
  String fullPassword = '';
  BorderSide borderMail= BorderSide.none;
  Color mailHintTextColor= CupertinoColors.systemGrey;
  BorderSide borderPassword= BorderSide.none;
  Color passwordHintTextColor= CupertinoColors.systemGrey;

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
                    onPressed: () {
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
                      } else
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  pagina_iniziale_ui()));
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