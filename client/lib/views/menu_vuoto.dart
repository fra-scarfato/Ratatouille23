

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

  TextEditingController nomeCategoriaController = TextEditingController();
  String nomeCategoria='';
  Color colore=Colors.black.withOpacity(0.1);


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

              /*PopupMenuButton<TodoMenuItem>(
            icon: Icon(Icons.sticky_note_2_outlined,
              color: Colors.black,
              size: 60,),
            onSelected: ((valueSelected) {
              //print('valueSelected: ${valueSelected.title}');
            }),
            itemBuilder: (BuildContext context) {
              return foodMenuList.map((TodoMenuItem todoMenuItem) {
                return PopupMenuItem<TodoMenuItem>(
                  value: todoMenuItem,
                  child: Row(
                    children: <Widget>[
                      ElevatedButton(

                        onPressed: () {

                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 60,
                        ),

                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                        ),


                      ),
                      ElevatedButton(

                        onPressed: () {

                        },
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 60,
                        ),

                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                        ),


                      )
                    ],
                  ),
                );
              }).toList();
            },
          ),*/
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


  Future<void> _displayAddCategoria(BuildContext context){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Center(

                child:Padding(

                  padding: EdgeInsetsDirectional.all(30.0),
                  child: Text(
                    "Aggiungi una nuova categoria",
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                )
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Nome categoria',
                  style: GoogleFonts.roboto(fontSize: 44,),
                ),
                SizedBox(
                  width: 50,
                ),
                Spacer(),
                SizedBox(
                  width: 522,
                  height: 54,
                  child: TextFormField(
                    controller: nomeCategoriaController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: CupertinoColors.systemGrey3,
                            width: 5.0
                        ),
                        borderRadius: BorderRadius.circular(50),

                      ),
                      hintText: 'Inserisci il nome della categoria',
                    ),
                    onChanged: (text){
                      setState(() {
                        nomeCategoria=text;
                      });
                    },
                  ) ,
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            actions: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height:40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
                            Navigator.pop(context);
                          },
                          child: Text(
                            'ANNULLA',
                            style:TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          )
                      ),
                      SizedBox(width:80),
                      ElevatedButton(
                          onPressed: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
                          },
                          child: Text(
                            'AGGIUNGI',
                            style:TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          )
                      ),

                    ],
                  ),
                  SizedBox(height:40)
                ],)
            ],
          );}

    );


  }







}

