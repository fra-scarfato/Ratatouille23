import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Finestra_errore {

  final String title;
  final String content;


  Finestra_errore({required this.title, required this.content});

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title, textAlign: TextAlign.center,),
          content: Text(content),
          backgroundColor: Colors.redAccent,
        )
    );
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });

  }

}