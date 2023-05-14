import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:ratatouille23/views/Login_ui.dart';
import 'package:ratatouille23/views/aggiungi_piatto.dart';
import 'package:ratatouille23/views/custom_widget/slide_button.dart';
import 'package:ratatouille23/views/menu_vuoto.dart';

import '../../models/Utente.dart';
import '../../models/menu/Categoria.dart';
import '../menu.dart';
import 'Finestra_errore.dart';
import 'bottoni_menu_admin.dart';

class bottone_gestione_menu_admin extends StatefulWidget{
  final List<Categoria>? listaCategorie;

  final Utente utente;

  const bottone_gestione_menu_admin({Key? key, required this.listaCategorie,required this.utente}) : super(key : key);

  @override
  bottone_gestione_menu_admin_state createState() => bottone_gestione_menu_admin_state();

}

class bottone_gestione_menu_admin_state extends State<bottone_gestione_menu_admin>{



  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const registra_elemento()));
        _displayFunzioni(context);

      },
      child: Icon(
        Icons.sticky_note_2_outlined,
        color: Colors.black,
        size: 60,
      ),

      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

      ),
    );
  }

  Future _displayFunzioni(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
            child: AnimationConfiguration.staggeredList(
              duration: Duration(milliseconds: 450),
              position: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideAnimation(
                      verticalOffset: 80,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[Text('Aggiungi categoria', style: GoogleFonts.roboto(fontSize: 24,color: Colors.white),),
                          SizedBox(height: 8),
                          ElevatedButton(

                            onPressed: () {
                              _displayAddCategoria(context);

                            },

                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 60,
                            ),


                          ),] ,
                      )
                  ),
                  //slide_button(vertical_offset: 80, horizontal_offset: 0, text: 'Aggiungi categoria', route: , icon: Icons.add),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      slide_button(vertical_offset: 40, horizontal_offset: 40, text: 'Aggiungi piatto', route:  /*displayAggiungiCategoria*/aggiungi_piatto(listaCategorie: widget.listaCategorie, utente: widget.utente), icon: Icons.add),
                      SizedBox(
                        height: 8,
                        width: 150,
                      ),
                      slide_button(vertical_offset: 40, horizontal_offset: -40, text: 'Elimina categoria', route: menu(utente: widget.utente), icon: Icons.delete_outline_outlined),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //_displayAddCategoria(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 60,
                    ),

                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                    ),
                  ),

                  SizedBox(
                    height: 60,
                  )
                ],
              ),

            ),
          );

        }
    );
  }


  Future<void> _displayAddCategoria(BuildContext context){

    TextEditingController nomeCategoriaController = TextEditingController();
    String nomeCategoria = '';
    Color colore=Colors.black.withOpacity(0.1);
    Color borderSideColorNome = CupertinoColors.systemGrey3;
    Color hintColorNome = CupertinoColors.systemGrey3;
    Menu_controller menu_controller = new Menu_controller();

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
                            color: borderSideColorNome,
                            width: 5.0
                        ),
                        borderRadius: BorderRadius.circular(50),

                      ),
                      hintText: 'Inserisci il nome della categoria',
                        hintStyle: TextStyle(color: hintColorNome)
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
                            if(nomeCategoria==''){
                              setState(() {
                                borderSideColorNome=  Colors.red;
                                hintColorNome= Colors.red;
                              });
                            }
                            try{
                              menu_controller.aggiungiCategoria(nomeCategoria,/*widget.utente.get_idRistorante*/ widget.utente.get_id_ristorante());
                            }catch (error){
                              Finestra_errore(title: 'Errore !', content: 'Errore durante l\'operazione',);
                            }
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
