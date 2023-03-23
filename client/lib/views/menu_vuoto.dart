

import 'dart:ui';
import 'package:ratatouille23/views/barra_superiore.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'custom_widget/bottone_gestione_menu_admin.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class menu_vuoto extends StatefulWidget {
  const menu_vuoto({super.key});

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
        primarySwatch: Colors.orange,

      ),
      builder: (context, child) =>
          ResponsiveWrapper.builder(
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



      initialRoute: "/",

    );
  }


  @override
  menu_vuoto_ui createState() => menu_vuoto_ui();

}



class menu_vuoto_ui extends State<menu_vuoto>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bubble.png"),

            ),

          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              barra_superiore(),
              finestra_nessun_elemento(string1: 'NON CI SONO PIATTI', string2: 'NEL TUO MENU', string3: 'CREA UNA CATEGORIA E', string4: 'AGGIUNGI UN NUOVO PIATTO', string5: 'CLICCANDO IL BOTTONE'),
              SizedBox(height:35),
              bottone_gestione_menu_admin(),
              SizedBox(
                height: 8,
              )

            ],
          )
      ),
    );
  }










}

