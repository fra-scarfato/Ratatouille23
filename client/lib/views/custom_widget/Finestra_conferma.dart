import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Finestra_conferma extends StatefulWidget{
  final String title;
  final String content;
  Finestra_conferma({Key ? key, required this.title, required this.content, }) : super(key : key);
  @override
  Finestra_conferma_ui createState() => Finestra_conferma_ui();
}

class Finestra_conferma_ui extends State<Finestra_conferma>{
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 0), (){
      _showAlert(context);
    });
    return Scaffold();
  }
  Future<void> _showAlert(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
      return AlertDialog(
        title: Text(widget.title, textAlign: TextAlign.center,),
        content: Text(widget.content),
        backgroundColor: Colors.lightGreenAccent,
      );
    });
  }

}