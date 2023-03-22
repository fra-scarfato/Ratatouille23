import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/views/Login_ui.dart';
import 'package:ratatouille23/views/custom_widget/slide_button.dart';
import 'package:ratatouille23/views/menu_vuoto.dart';

import 'bottoni_menu_admin.dart';

class bottone_gestione_menu_admin extends StatelessWidget{
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
                  slide_button(vertical_offset: 80, horizontal_offset: 0, text: 'Aggiungi categoria', route:  /*displayAggiungiCategoria*/const menu_vuoto(), icon: Icons.add),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      slide_button(vertical_offset: 40, horizontal_offset: 40, text: 'Aggiungi piatto', route:  /*displayAggiungiCategoria*/const menu_vuoto(), icon: Icons.add),
                      SizedBox(
                        height: 8,
                        width: 150,
                      ),
                      slide_button(vertical_offset: 40, horizontal_offset: -40, text: 'Elimina categoria', route:  /*displayAggiungiCategoria*/const menu_vuoto(), icon: Icons.delete_outline_outlined),
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
}