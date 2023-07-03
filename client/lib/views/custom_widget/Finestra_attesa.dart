import 'package:flutter/material.dart';

class Finestra_attesa {
  final BuildContext context;


  Finestra_attesa(this.context);

  void showDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
    );
  }

  void hideProgressDialogue() {
    Navigator.of(context).pop(Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),);}


}