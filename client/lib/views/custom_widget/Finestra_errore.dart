import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Finestra_errore extends StatelessWidget{

  final String message;

  Finestra_errore({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cancel),
          SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );
  }

}