import 'package:flutter/material.dart';

class MiBoton extends StatelessWidget {
  final String texto;
  final Color colorTexto;
  final Color colorFondo;
  const MiBoton({
    Key? key,
    required this.texto,
    required this.colorTexto,
    required this.colorFondo,
    
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        
      },
      style:ElevatedButton.styleFrom(
        foregroundColor: colorTexto, backgroundColor: colorFondo, 
      ),
       child: Text(
        texto,
        style: const TextStyle(fontWeight: FontWeight.bold),
       ),
       );
  }
}