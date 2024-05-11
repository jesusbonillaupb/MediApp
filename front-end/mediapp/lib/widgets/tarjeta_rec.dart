import 'package:flutter/material.dart';

class RecordatorioCard extends StatelessWidget {
  final String nombre;
  final String dosis;
  final String hora;
  final String tipo;
  final String descripcion;

  const RecordatorioCard({
    required this.nombre,
    required this.dosis,
    required this.hora,
    required this.tipo,
    required this.descripcion,
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
          hora,
          style: TextStyle(
              color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
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
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Dosis',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ': $dosis',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.0),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Tipo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ': $tipo',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.0),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Hora a tomar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ': $hora',
                    ),
                  ],
                ),
              ),
              if (descripcion != "")
              const SizedBox(height: 6.0),
                if (descripcion != "")
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Descripción:\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '$descripcion',
                      ),
                    ],
                  ),
                ),
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
