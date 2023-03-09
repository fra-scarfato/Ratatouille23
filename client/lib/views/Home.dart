import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login_ui.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    return Scaffold(
        backgroundColor: Colors.transparent,
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
                  height: 30,
                ),
                ElevatedButton(

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_ui()));
                    },
                    child: Text(
                      'COMINCIA ORA',
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