import 'package:flutter/material.dart';

class Finestra_conferma extends StatelessWidget{
  final String message;


  const Finestra_conferma({super.key, required this.message});

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
        const Icon(Icons.check),
        const SizedBox(
          width: 12.0,
        ),
        Text(message),
      ],
    ),
    );
  }

}