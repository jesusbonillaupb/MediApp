import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyect_views_front/AppStyles/app_colors.dart';
import 'package:proyect_views_front/rest/rest_api.dart';
import 'package:proyect_views_front/screens/home_page.dart';
import 'package:proyect_views_front/widgets/tarjeta_rec.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  late SharedPreferences _prefs;
  int selectedDayIndex = 0;
  // ignore: unused_field
  int _userid = 0;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    initializeDateFormatting('es_ES', null); // Inicialización para español
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      //_userName = _prefs.getString('username') ?? '';
      _userid = _prefs.getInt('userid') ?? 0;
    });
  }

  // Método para eliminar los datos de sesión y redirigir a la pantalla de inicio
  void _logout() {
    _prefs.clear(); // Borra todos los datos guardados en SharedPreferences
    Navigator.popUntil(context,
        ModalRoute.withName('/')); // Redirige a la pantalla de bienvenida
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario',style: TextStyle(color: AppColors.firstRectangleColor)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //barra calendario
          Container(
            height: 60.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final day = DateTime.now().add(Duration(days: index));
                final isToday = index == selectedDayIndex;
                return _buildDayItem(day, isToday, () {
                  setState(() {
                    selectedDayIndex = index;
                  });
                });
              },
            ),
          ),
          // Texto para mostrar el día de la semana seleccionado
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              _getSelectedDayOfWeek(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // recordatorios
          Expanded(
            child: ListView(
              children: [
                FutureBuilder<List<dynamic>>(
                  future: dayMeds(_userid, _getSelectedDayOfWeek()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null) {
                      return const Text('No hay datos disponibles');
                    } else {
                      List<dynamic> medicamentos = snapshot.data!;

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: medicamentos.length,
                        itemBuilder: (context, index) {
                          final medicamento = medicamentos[index];
                          String tiempo = medicamento['re_Hora'];
                          List<String> partes = tiempo.split(':');
                          String hora = partes[0];
                          String minuto = partes[1];

                          String horaDesFormateada = desFormatearHora(hora);
                          String minutoDesFormateado = minuto;
                          String amOrPm = determinarAmPm(hora);

                          String horaCompleto= horaDesFormateada + ":"+minutoDesFormateado+" "+amOrPm;
                          return Column(
                            children: [
                              RecordatorioCard(
                                nombre: medicamento['med_Nombre'],
                                dosis: medicamento['med_Dosis'],
                                hora: horaCompleto,
                                descripcion: medicamento['med_Descripcion'],
                                tipo: medicamento['med_Tipo'],
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavigationButton(
                    context, Icons.medication, 'Medicamentos', false),
                _buildNavigationButton(
                    context, Icons.calendar_today, 'Calendario', true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getSelectedDayOfWeek() {
    final selectedDay = DateTime.now().add(Duration(days: selectedDayIndex));
    final dateFormat = DateFormat.EEEE('es_ES');
    String dayOfWeek = dateFormat.format(selectedDay);
    dayOfWeek =
        dayOfWeek.substring(0, 1).toUpperCase() + dayOfWeek.substring(1);
    return dayOfWeek;
  }

  Widget _buildDayItem(DateTime day, bool isToday, Function() onTap) {
    final dayFormat = DateFormat.E('es_ES');
    final dateFormat = DateFormat.d();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: isToday ? AppColors.firstRectangleColor : Colors.transparent,
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
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        _navigateToPage(context, label);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  isActive ? AppColors.firstRectangleColor : Colors.transparent,
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
        break;
    }
  }

  String desFormatearHora(String hour) {
    // si es 00 se remplaza por un 12
    if (hour == "00") {
      String horaDesFormateada = "12";
      return horaDesFormateada;
    }
    // si es mayor a 12 se le resta 12
    int horaNumeros = int.parse(hour);
    if (horaNumeros > 12) {
      int horaNumeroCor = horaNumeros - 12;
      String horaDesFormateada = horaNumeroCor.toString();
      return horaDesFormateada;
    }
    // sino se asume que es de mañana y se deja quieto
    return hour;
  }
  String determinarAmPm(String hour) {
    // si es mayor a 12 es PM
    if (int.parse(hour) >= 12) {
      return "PM";
    }

    return "AM";
  }
}
