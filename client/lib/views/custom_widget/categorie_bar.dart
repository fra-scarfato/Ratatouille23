import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/menu/Categoria.dart';


class CategorieBar_parent extends StatefulWidget{
  final List<Categoria> listaCategorie;
  // final Function(Categoria) fun;



  CategorieBar_parent({
    Key? key,
    required this.listaCategorie,
    // required this.fun,
  }) : super(key: key);
  @override
  CategorieBar createState() => new CategorieBar();
  }



class CategorieBar extends State<CategorieBar_parent>{

  List<bool> list = [];
  @override
  void initState() {
    for(int i=0; i<widget.listaCategorie.length; i++){
      list.add(false);
    }
    list[0]=true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.listaCategorie!.length,
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
                  // widget.fun(widget.listaCategorie![index]);
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
                      widget.listaCategorie![index].get_nome(),
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

class categoria_card extends StatelessWidget {
  const categoria_card(
      {Key? key,
      required this.nomeCategoria,
      required this.press,
      required this.selectedFirst})
      : super(key: key);

  final String nomeCategoria;
  final Function press;
  final bool selectedFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ListTile(
          tileColor: Colors.yellow.shade200,
          selectedTileColor: Colors.yellow,
          selectedColor: Colors.black,
          selected: selectedFirst,
          onTap: (){press;},
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nomeCategoria,
                style:
                    GoogleFonts.roboto(fontSize: 34, fontStyle: FontStyle.italic),
              ),
            ],
          ),
      ),
    );
  }
}
