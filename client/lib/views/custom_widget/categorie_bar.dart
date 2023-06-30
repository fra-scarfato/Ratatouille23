import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controllers/Menu_controller.dart';
import '../../models/menu/Categoria.dart';
import '../../models/menu/Elemento.dart';


class CategorieBar_parent extends StatefulWidget{
  final Menu_controller menu_controller;

  //final Function(Categoria) fun;



  CategorieBar_parent({
    Key? key,
    required this.menu_controller
    //required this.fun,
  }) : super(key: key);
  @override
  CategorieBar createState() => new CategorieBar();
  }



class CategorieBar extends State<CategorieBar_parent>{
  List<Categoria> listaCategorie = <Categoria>[];
  List<bool> list = [];

  @override
  Widget build(BuildContext context) {
    listaCategorie = widget.menu_controller.getCategorieDaVisualizzare();
    if (listaCategorie.isNotEmpty) {
      for(int i=0; i<listaCategorie.length; i++){
        list.add(false);
      }
      list[0]=true;
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          listaCategorie.length,
              (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              child: ListTile(
                tileColor: Colors.yellow.shade200,
                selectedTileColor: Colors.yellow,
                selectedColor: Colors.black,
                selected: list[index],
                onTap: (){
                  setState(() {
                  for(int i=0; i<list.length; i++){
                    if(i!=index){
                      list[i]=false;
                    } else {
                      list[index]=true;
                    }
                  }
                  widget.menu_controller.set_selected(listaCategorie[index]);
                });},
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(30)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      listaCategorie[index].get_nome(),
                      style: GoogleFonts.roboto(fontSize: 34, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}