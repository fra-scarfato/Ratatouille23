import 'package:flutter/material.dart';

class Finestra_errore extends StatelessWidget{

  final String message;

  const Finestra_errore({super.key, required this.message});

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
          const Icon(Icons.cancel),
          const SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );
  }

}