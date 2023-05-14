import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/menu/Categoria.dart';

class CategorieBar extends StatelessWidget{
  final List<Categoria> listaCategorie;

  CategorieBar({
    Key? key,
    required this.listaCategorie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          listaCategorie!.length,
              (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: categoria_card(
                nomeCategoria: listaCategorie![index].get_nome(),
                press: () {},
                selectedFirst: index == 0 ? true : false),
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
  final VoidCallback press;
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
          onTap: press,
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
