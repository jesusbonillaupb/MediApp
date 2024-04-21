import 'package:flutter/material.dart';
import 'package:proyect_views_front/AppStyles/app_colors.dart';

class MedicationCard extends StatelessWidget {
  final String nombre;
  final String dosis;
  final int idmed;
  final VoidCallback editarAction;
  final VoidCallback deleteAction;

  const MedicationCard({
    required this.nombre,
    required this.dosis,
    required this.editarAction,
    required this.deleteAction,
    required this.idmed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.boxColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.local_hospital, color: Colors.white),
        ),
        title: Text(
          nombre,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          'Dosis: $dosis',
          style: TextStyle(color: Colors.black87),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: editarAction,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteAction,
            ),
          ],
        ),
      ),
    );
  }
}
