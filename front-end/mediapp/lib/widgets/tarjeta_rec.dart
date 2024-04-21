import 'package:flutter/material.dart';


class RecordatorioCard extends StatelessWidget {
  final String nombre;
  final String dosis;

  const RecordatorioCard({
    required this.nombre,
    required this.dosis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
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
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            _showMedicationDetails(context);
          },
        ),
      ),
    );
  }

  void _showMedicationDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(nombre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dosis: $dosis'),
              SizedBox(height: 8.0),
              // Agrega más detalles según sea necesario
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
