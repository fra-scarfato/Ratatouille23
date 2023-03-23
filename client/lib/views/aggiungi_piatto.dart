import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';

import 'barra_superiore.dart';
import 'menu_vuoto.dart';

class aggiungi_piatto extends StatefulWidget{
  @override
  aggiungi_piatto_state createState() => aggiungi_piatto_state();
}

class aggiungi_piatto_state extends State<aggiungi_piatto>{

  TextEditingController nomeController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController descrizioneController = TextEditingController();
  TextEditingController allergeniController = TextEditingController();
  String nome = '';
  String costo = '';
  String descrizione = '';
  String allergeni = '';
  String categoria='';
  List <String> items= ['Primi','Secondi','Contorni','Frutta','Dolci']; //List<Categoria>
  String? selectedItem= 'Seleziona la categoria';

  Color borderSideColorNome = CupertinoColors.systemGrey3;
  Color borderSideColorCosto = CupertinoColors.systemGrey3;
  Color borderSideColorCategoria = CupertinoColors.systemGrey3;
  Color hintColorNome = CupertinoColors.systemGrey3;
  Color hintColorCosto = CupertinoColors.systemGrey3;
  Color hintColorCategoria = CupertinoColors.systemGrey3;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            barra_superiore(),
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
                      hintText: 'Inserisci il nome dell\'elemento',
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
                    'Costo',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    SizedBox(height: 30,)],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: costoController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: borderSideColorCosto,
                              width: 5.0
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci il costo dell\'elemento',
                      hintStyle: TextStyle(color: hintColorCosto)
                    ),
                    onChanged: (text){
                      setState(() {
                        costo=text;
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
                    'Descrizione',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    SizedBox(height: 30,)],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: descrizioneController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: CupertinoColors.systemGrey3,
                              width: 5.0
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci la descrizione dell\' elemento',
                    ),
                    onChanged: (text){
                      setState(() {
                        descrizione=text;
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
                    'Allergeni',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                    SizedBox(height: 30,)],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: allergeniController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: CupertinoColors.systemGrey3,
                              width: 5.0
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci gli allergeni presenti nell\'elemento',
                    ),
                    onChanged: (text){
                      setState(() {
                        allergeni=text;
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
                    'Categoria',
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange)
                ),
                Spacer(),
                Container(
                  width: 900,
                  height: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:Border.all( color:borderSideColorCategoria, width: 1)
                  ),
                  padding: EdgeInsets.only(left: 7.0, right: 4.0, top: 3.0),
                  child:DropDown(
                    items: items, //<String>['Primi','Secondi','Contorni','Frutta','Dolci'],
                    hint: Text('Seleziona la categoria', style: TextStyle(color: hintColorCategoria),),
                    icon: Icon(
                      Icons.expand_more,
                      color: Colors.black,
                    ),
                    isExpanded: true,
                    onChanged: (text){
                      setState(() {
                        categoria=text!;
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
                      if(nome=='' || costo=='' || categoria == '' ){
                        if(nome==''){
                          setState(() {
                            borderSideColorNome=Colors.red;
                            hintColorNome=Colors.red;
                          });
                        }
                        if(costo==''){
                          setState(() {
                            borderSideColorCosto=Colors.red;
                            hintColorCosto=Colors.red;
                          });
                        }
                        if(categoria==''){
                          setState(() {
                            borderSideColorCategoria=Colors.red;
                            hintColorCategoria=Colors.red;
                          });
                        }
                      }
                      else
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const menu_vuoto()));
                    },
                    child: Text(
                      'AGGIUNGI PIATTO',
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