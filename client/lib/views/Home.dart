import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/views/custom_widget/bottone_arancione_con_testo.dart';
import 'package:ratatouille23/views/pagina_iniziale.dart';

import 'Login_ui.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Amplify_controller amplify_controller = Amplify_controller();
    return FutureBuilder(
        future: amplify_controller.fetchAuthSession(),
        builder: (BuildContext context, snapshot) {




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
                              if(snapshot.data!) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => pagina_iniziale_ui()));
                              } else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login_ui()));
                              }

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
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                            )

                        )
                      ],
                    )
                )
            );
          }

    );
  }
}