import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/controllers/Menu_view_controller.dart';

import '../../models/menu/Categoria.dart';
import '../../models/menu/Elemento.dart';


class CategorieBar_parent extends StatefulWidget{
  final List<Categoria> listaCategorie;
  final Menu_view_controller menu_view_controller;

  //final Function(Categoria) fun;



  CategorieBar_parent({
    Key? key,
    required this.listaCategorie,
    required this.menu_view_controller
    //required this.fun,
  }) : super(key: key);
  @override
  CategorieBar createState() => new CategorieBar();
  }



class CategorieBar extends State<CategorieBar_parent>{

  List<bool> list = [];
  @override
  void initState() {
    if (widget.listaCategorie.isNotEmpty) {
      for(int i=0; i<widget.listaCategorie.length; i++){
        list.add(false);
      }
      list[0]=true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.listaCategorie.length,
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
                  widget.menu_view_controller.set_selected(widget.listaCategorie[index]);
                  setState(() {
                  for(int i=0; i<list.length; i++){
                    if(i!=index){
                      list[i]=false;
                    } else {
                      list[index]=true;
                    }
                  }
                });},
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(30)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.listaCategorie[index].get_nome(),
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