import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:ratatouille23/views/aggiungi_piatto.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_attesa.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_conferma.dart';
import 'package:ratatouille23/views/custom_widget/slide_button.dart';


import '../../models/Utente.dart';
import '../../models/menu/Categoria.dart';
import 'Finestra_errore.dart';
import 'elimina_categoria.dart';

class bottone_gestione_menu_admin extends StatefulWidget{
  final List<Categoria> listaCategorie;
  final Menu_controller menu_controller;
  final Utente utente;

  const bottone_gestione_menu_admin({Key? key, required this.listaCategorie,required this.utente, required this.menu_controller}) : super(key : key);

  @override
  bottone_gestione_menu_admin_state createState() => bottone_gestione_menu_admin_state();

}

class bottone_gestione_menu_admin_state extends State<bottone_gestione_menu_admin>{



  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const registra_elemento()));
        _displayFunzioni(context, widget.menu_controller);

      },
      child: const Icon(
        Icons.sticky_note_2_outlined,
        color: Colors.black,
        size: 60,
      ),

      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

      ),
    );
  }

  Future _displayFunzioni(BuildContext context, Menu_controller menu_controller){
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
              duration: const Duration(milliseconds: 450),
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
                          const SizedBox(height: 8),
                          ElevatedButton(

                            onPressed: () {
                              _displayAddCategoria(context, menu_controller);

                            },

                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 60,
                            ),


                          ),] ,
                      )
                  ),
                  //slide_button(vertical_offset: 80, horizontal_offset: 0, text: 'Aggiungi categoria', route: , icon: Icons.add),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      slide_button(vertical_offset: 40, horizontal_offset: 40, text: 'Aggiungi piatto', route:  /*displayAggiungiCategoria*/aggiungi_piattoUI(listaCategorie: widget.listaCategorie, utente: widget.utente, menu_controller: menu_controller), icon: Icons.add),
                      const SizedBox(
                        height: 8,
                        width: 150,
                      ),
                      slide_button(vertical_offset: 40, horizontal_offset: -40, text: 'Elimina categoria', route: Elimina_categoria(listaCategorie: widget.listaCategorie, utente: widget.utente, menu_controller: widget.menu_controller,), icon: Icons.delete_outline_outlined),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //_displayAddCategoria(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 60,
                    ),

                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                    ),
                  ),

                  const SizedBox(
                    height: 60,
                  )
                ],
              ),

            ),
          );

        }
    );
  }


  Future<void> _displayAddCategoria(BuildContext context, Menu_controller menu_controller){

    TextEditingController nomeCategoriaController = TextEditingController();
    String nomeCategoria = '';
    Color borderSideColorNome = CupertinoColors.systemGrey3;
    Color hintColorNome = CupertinoColors.systemGrey3;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Center(

                child:Padding(

                  padding: const EdgeInsetsDirectional.all(30.0),
                  child: Text(
                    "Aggiungi una nuova categoria",
                    style: GoogleFonts.roboto(fontSize: 44, color: Colors.orange),
                  ),
                )
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Nome categoria',
                  style: GoogleFonts.roboto(fontSize: 44,),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Spacer(),
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
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            actions: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height:40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'ANNULLA',
                            style:TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          )
                      ),
                      const SizedBox(width:80),
                      ElevatedButton(
                          onPressed: () async {
                            if(nomeCategoria==''){
                              setState(() {
                                borderSideColorNome=  Colors.red;
                                hintColorNome= Colors.red;
                              });
                            }
                            var attesa = Finestra_attesa(context);
                            FToast toast = FToast();
                            toast.init(context);
                            try{
                              attesa.showDialogue();
                              await menu_controller.aggiungiCategoria(nomeCategoria,/*widget.utente.get_idRistorante*/ widget.utente.get_id_ristorante());
                              attesa.hideProgressDialogue();
                              Fluttertoast.cancel();
                              toast.showToast(
                                  child: const Finestra_conferma(message: "Categoria aggiunta correttamente"),
                                  toastDuration: const Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                              Navigator.pop(context);
                            }catch (error){
                              attesa.hideProgressDialogue();
                              Fluttertoast.cancel();
                              toast.showToast(
                                  child: const Finestra_errore(message: "Errore nell'aggiunta della categoria"),
                                  toastDuration: const Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                            }
                            },
                          child: const Text(
                            'AGGIUNGI',
                            style:TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          )
                      ),

                    ],
                  ),
                  const SizedBox(height:40)
                ],)
            ],
          );}

    );


  }


  
}
