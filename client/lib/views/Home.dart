import 'package:flutter/material.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_attesa.dart';
import 'package:ratatouille23/views/pagina_inizialeUI.dart';

import '../models/Utente.dart';
import 'Login_ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Amplify_controller amplify_controller = Amplify_controller();
    return FutureBuilder(
        future: amplify_controller.fetchAuthSession(),
        builder: (BuildContext context, snapshot) {
          Widget widgetDaTornare;
          if (snapshot.connectionState == ConnectionState.done){
            widgetDaTornare = Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
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
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(

                            onPressed: () async {
                              var attesa = Finestra_attesa(context);
                              if(snapshot.data!) {
                                attesa.showDialogue();
                                Utente utente  = await amplify_controller.fetchCurrentUserAttributes();
                                attesa.hideProgressDialogue();
                                Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/pagina_iniziale"),builder: (context) => pagina_inizialeUI(utente)));
                              } else {
                                Navigator.push(context, createRoute(const Login_ui(), "/login"));
                              }

                            },

                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                            ),
                            child: const Text(
                              'COMINCIA ORA',
                              style:TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            )

                        )
                      ],
                    )
                )
            );
          } else {
            widgetDaTornare = Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
            return widgetDaTornare;
          }

    );
  }

  Route createRoute(Widget page, String route) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds:600),
      settings: RouteSettings(name: route),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}