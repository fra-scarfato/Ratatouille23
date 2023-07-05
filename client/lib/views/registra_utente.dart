import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/controllers/Utente_controller.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_conferma.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

import '../models/Utente.dart';
import 'custom_widget/Finestra_attesa.dart';
import 'custom_widget/Finestra_errore.dart';
import 'custom_widget/barra_superiore.dart';

class registra_utenteUI extends StatefulWidget {

  final Utente utente;

  const registra_utenteUI({super.key, required this.utente});

  @override
  registra_utente_ui createState() => registra_utente_ui();


}

class registra_utente_ui extends State<registra_utenteUI> {

  Utente_controller utente_controller = Utente_controller();
  Amplify_controller amplify_controller = Amplify_controller();
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
            const barra_superiore(text: '',),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Nome',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    const SizedBox(height: 30,)],
                ),
                const Spacer(),
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
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Cognome',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    const SizedBox(height: 30,)],
                ),
                const Spacer(),
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
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Email',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    const SizedBox(height: 30,)],
                ),
                const Spacer(),
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
                      hintText: 'Inserisci l\'email',
                        hintStyle: TextStyle(color: hintColorMail)
                    ),
                    onChanged: (text){
                      setState(() {
                        mail=text;
                      });
                    },
                  ) ,
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [Text(
                    'Password',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    const SizedBox(height: 30,)],
                ),
                const Spacer(),
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
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                    'Ruolo',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange)
                ),
                const Spacer(),
                Container(
                  width: 900,
                  height: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:Border.all( color:borderSideColorRuolo, width: 1)
                  ),
                  padding: const EdgeInsets.only(left: 7.0, right: 4.0, top: 3.0),
                  child:DropDown(
                    items: const <String>['Amministratore',
                      'Supervisore',
                      'Addetto alla sala',
                      'Addetto alla cucina'],
                    hint: const Text('Scegli il ruolo', style: TextStyle(color: CupertinoColors.systemGrey),),
                    icon: const Icon(
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
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(

                    onPressed: () async {
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
                      else {
                        var attesa = Finestra_attesa(context);
                        FToast toast = FToast();
                        toast.init(context);
                        try{
                          attesa.showDialogue();
                          await amplify_controller.signUpUser(email: mail, password: password);
                          await utente_controller.aggiungiUtente(nome, cognome, mail, ruolo, widget.utente.get_id_ristorante());
                          attesa.hideProgressDialogue();
                          toast.showToast(
                              child: const Finestra_conferma(message: "Utente aggiunto correttamente"),
                              toastDuration: const Duration(seconds: 2),
                              gravity: ToastGravity.BOTTOM);
                        }catch (error){
                          attesa.hideProgressDialogue();
                          toast.showToast(
                              child: const Finestra_errore(message: "Aggiunta non riuscita"),
                              toastDuration: const Duration(seconds: 2),
                              gravity: ToastGravity.BOTTOM);
                        }
                      }

                    },
                    child: const Text(
                      'AGGIUNGI UTENTE',
                      style:TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                    )


                ),

              ],
            ),
            const SizedBox(
              height: 2,
            )
          ],
        )
    );



  }
}