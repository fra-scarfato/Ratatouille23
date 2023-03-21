import 'package:flutter/material.dart';
import 'package:ratatouille23/views/custom_widget/bottoni_gestione.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';







class pagina_iniziale extends StatelessWidget {
  const pagina_iniziale({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:  AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.orange

          ),


        ),

        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],

        ),

        home: pagina_iniziale_ui()
    );



  }
}

class pagina_iniziale_ui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Ratatouille23',
                style:GoogleFonts.sendFlowers(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              SizedBox(
                width: 400,
              ),
              IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottoni_gestione(route: const registra_utente(), text: 'AGGIUNGI UTENTE', color1: Colors.orangeAccent, color2: Colors.yellow, icon: Icons.person_add_alt_1_outlined),
              bottoni_gestione(route: const ordinazioni(), text: 'ORDINAZIONI', color1: Colors.pink, color2: Colors.deepOrange, icon: Icons.checklist_outlined),
              bottoni_gestione(route: const menu_vuoto(), text: 'MENU', color1: Colors.lightBlue, color2: Colors.lightBlueAccent, icon: Icons.menu_book),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bottoni_gestione(route: const lista_ordinazioni_cucina(), text: 'CUCINA', color1: Colors.purple, color2: Colors.purpleAccent, icon: Icons.cake_outlined),
              SizedBox(width: 30,),
              bottoni_gestione(route: route, text: 'STATISTICHE', color1: Colors.green, color2: Colors.lightGreen, icon: Icons.query_stats_outlined)
            ],
          )
        ],
      ),
    );
  }


}
