import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

import 'Login_ui.dart';
import 'custom_widget/barra_superiore.dart';

class registra_utente extends StatefulWidget {

  const registra_utente({super.key});

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
      initialRoute: "/",

    );



  }


  @override
  registra_utente_ui createState() => registra_utente_ui();


}

class registra_utente_ui extends State<registra_utente> {

  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String nome = '';
  String cognome = '';
  String mail = '';
  String password = '';
  String ruolo='';
  List <String> items= ['Amministratore','Supervisore','Addetto alla sala','addetto alla cucina'];
  String? selectedItem= 'Amministratore';

  Color borderSideColorNome = CupertinoColors.systemGrey3;
  Color borderSideColorCognome = CupertinoColors.systemGrey3;
  Color borderSideColorMail = CupertinoColors.systemGrey3;
  Color borderSideColorPassword = CupertinoColors.systemGrey3;
  Color borderSideColorRuolo = CupertinoColors.systemGrey3;

  Color hintColorNome = CupertinoColors.systemGrey3;
  Color hintColorCognome = CupertinoColors.systemGrey3;
  Color hintColorMail = CupertinoColors.systemGrey3;
  Color hintColorPassword = CupertinoColors.systemGrey3;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            barra_superiore(text: '',),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Nome',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    SizedBox(height: 30,)],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: nomeController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: borderSideColorNome,
                            width: 5.0
                        ),
                        borderRadius: BorderRadius.circular(50),

                      ),
                      hintText: 'Inserisci il nome',
                      hintStyle: TextStyle(color: hintColorNome)
                    ),
                    onChanged: (text){
                      setState(() {
                        nome=text;
                      });
                    },
                  ) ,
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Cognome',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    SizedBox(height: 30,)],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: cognomeController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: borderSideColorCognome,
                              width: 5.0
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci il cognome',
                        hintStyle: TextStyle(color: hintColorCognome)
                    ),
                    onChanged: (text){
                      setState(() {
                        cognome=text;
                      });
                    },
                  ) ,
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Email',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    SizedBox(height: 30,)],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: borderSideColorMail,
                              width: 5.0
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci il nome',
                        hintStyle: TextStyle(color: hintColorMail)
                    ),
                    onChanged: (text){
                      setState(() {
                        mail=text;
                      });
                    },
                  ) ,
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Password',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    SizedBox(height: 30,)],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: borderSideColorPassword,
                              width: 5.0
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci la password',
                        hintStyle: TextStyle(color: hintColorPassword)
                    ),
                    onChanged: (text){
                      setState(() {
                        password=text;
                      });
                    },
                  ) ,
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                    'Ruolo',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange)
                ),
                Spacer(),
                Container(
                  width: 900,
                  height: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:Border.all( color:borderSideColorRuolo, width: 1)
                  ),
                  padding: EdgeInsets.only(left: 7.0, right: 4.0, top: 3.0),
                  child:DropDown(
                    items: <String>['Amministratore',
                      'Supervisore',
                      'Addetto alla sala',
                      'Addetto alla cucina'],
                    hint: Text('Scegli il ruolo', style: TextStyle(color: CupertinoColors.systemGrey),),
                    icon: Icon(
                      Icons.expand_more,
                      color: Colors.black,
                    ),
                    isExpanded: true,
                    onChanged: (text){
                      setState(() {
                        ruolo=text!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(

                    onPressed: () {
                      if(nome=='' || cognome=='' || mail=='' || password=='' || ruolo==''){
                        if(nome==''){
                          setState(() {
                            borderSideColorNome=  Colors.red;
                            hintColorNome= Colors.red;
                          });
                        }
                        if(cognome==''){
                          setState(() {
                            borderSideColorCognome=  Colors.red;
                            hintColorCognome= Colors.red;
                          });
                        }
                        if(mail==''){
                          setState(() {
                            borderSideColorMail=  Colors.red;
                            hintColorMail= Colors.red;
                          });
                        }
                        if(password==''){
                          setState(() {
                            borderSideColorPassword=  Colors.red;
                            hintColorPassword= Colors.red;
                          });
                        }
                        if(ruolo==''){
                          setState(() {
                            borderSideColorRuolo=  Colors.red;
                          });
                        }
                      }
                      else
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_ui()));
                    },
                    child: Text(
                      'AGGIUNGI UTENTE',
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


                ),

              ],
            ),
            SizedBox(
              height: 2,
            )
          ],
        )
    );



  }
}