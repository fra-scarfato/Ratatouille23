import 'package:flutter/material.dart';

class barra_superiore extends StatelessWidget{
  final String text;
  const barra_superiore({Key? key, required this.text}): super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0),
          ),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.orangeAccent,
                Colors.yellow
              ]
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
            ),
            IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            const Spacer(),
            Text(
              text,
              style:const TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ),
            const Spacer(),
          ],
        )
    );
  }
}