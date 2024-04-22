import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyect_views_front/AppStyles/app_colors.dart';

import 'package:proyect_views_front/screens/home_page.dart';
import 'package:proyect_views_front/widgets/tarjeta_rec.dart';

class CalendarioPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra de días de la semana
          Container(
            height: 60.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final day = DateTime.now().add(Duration(days: index));
                final isToday = index == 0; // Verifica si es el día actual

                return _buildDayItem(day, isToday);
              },
            ),
          ),
          // Resto del contenido
          Expanded(
            child: ListView(
              children: [
                RecordatorioCard(nombre: "propanol", dosis: "1 comprimido cada 8 horas ")
                
                // Agrega más MedicationCard según sea necesario
              ],
            ),
          ),
          // Sección de navegación entre vistas
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavigationButton(context, Icons.medication, 'Medicamentos', false),
                _buildNavigationButton(context, Icons.calendar_today, 'Calendario', true),
                _buildNavigationButton(context, Icons.notifications, 'Notificaciones', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(DateTime day, bool isToday) {
    final dayFormat = DateFormat.E(); // Formato de día abreviado (Lun, Mar, Mié, ...)
    final dateFormat = DateFormat.d(); // Formato de día del mes (1, 2, 3, ...)

    return Container(
      width: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: isToday ?  AppColors.thirdRectangleColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayFormat.format(day),
            style: TextStyle(
              color: isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Text(
            dateFormat.format(day),
            style: TextStyle(
              color: isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        _navigateToPage(context, label);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isActive ? AppColors.thirdRectangleColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.black,
                  size: 32.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(BuildContext context, String pageName) {
    switch (pageName) {
      case 'Medicamentos':
        Route route = MaterialPageRoute(builder: (_) => HomePage());
          Navigator.pushReplacement(context, route);
        break;
      case 'Calendario':
        // Ya estás en la página de Calendario, no es necesario navegar
        break;
      
    }
  }
}

