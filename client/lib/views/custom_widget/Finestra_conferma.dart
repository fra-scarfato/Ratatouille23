import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Finestra_conferma extends StatelessWidget{
  final String message;


  Finestra_conferma({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text(message),
      ],
    ),
    );
  }

}