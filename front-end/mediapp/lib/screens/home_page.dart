import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:proyect_views_front/AppStyles/app_colors.dart';
import 'package:proyect_views_front/rest/rest_api.dart';
import 'package:proyect_views_front/screens/calendario.dart';
import 'package:proyect_views_front/widgets/tarjeta_medicacion.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late SharedPreferences _prefs;
  //String _userName = ''; // Variable para almacenar el nombre de usuario
  int _userid = 0;
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // Método para inicializar SharedPreferences y recuperar el nombre de usuario
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mis medicamentos',
              style: TextStyle(color: AppColors.firstRectangleColor)),
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
            // Sección de barra de búsqueda

            // Sección de cajas de medicamentos
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          FutureBuilder<List<dynamic>>(
                            future: medGet(_userid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                    return Column(
                                      children: [
                                        MedicationCard(
                                            nombre: medicamento['med_Nombre'],
                                            dosis: medicamento["med_Dosis"],
                                            idmed: medicamento["idMedicamento"],
                                            deleteAction: (){
                                              delMed(medicamento["idMedicamento"].toString());
                                            },
                                            editarAction: () {
                                              
                                            })
                                            
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),

                          // Agrega más MedicationCard según sea necesario
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.firstRectangleColor,
                        ),
                        padding: EdgeInsets.all(2.0),
                        child: IconButton(
                          icon: Icon(Icons.add,
                              color: Colors.white), // Ícono con color blanco
                          onPressed: () {
                            _showAddMedicationDialog(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sección de navegación entre vistas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavigationButton(context, Icons.medication,
                      'Medicamentos', true), // Destacar la primera vista
                  _buildNavigationButton(context, Icons.calendar_month_outlined,
                      'Calendario', false),
                  _buildNavigationButton(
                      context, Icons.notifications, 'Notificaciones', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMedicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _buildAddMedicationDialog(
          context,
          'Agregar Medicamento',
          _userid.toString(),
          'Agregar',
        );
      },
    );
  }

  void _showEditMedicationDialog(BuildContext context, String name, String type,
      List<String> days, String time, String description, String dosage) {
    showDialog(
      context: context,
      builder: (context) {
        return _buildEditMedicationDialog(
            context, 'Editar Medicamento', 'Guardar Cambios',
            initialName: name,
            initialType: type,
            initialDays: days,
            initialTime: time,
            initialDescription: description,
            initialDosage: dosage);
      },
    );
  }

  Widget _buildAddMedicationDialog(
    BuildContext context,
    String title,
    String id_Usuario,
    String confirmLabel, {
    String? initialName,
    String? initialType,
    List<String>? initialDays,
    String? initialHour,
    String? initialMinute,
    String? initialAmOrPm,
    String? initialDescription,
    String? initialDosage,
  }) {
    TextEditingController nameController =
        TextEditingController(text: initialName);
    TextEditingController typeController =
        TextEditingController(text: initialType);
    TextEditingController descriptionController =
        TextEditingController(text: initialDescription);
    TextEditingController dosageController =
        TextEditingController(text: initialDosage);
    TextEditingController hourController =
        TextEditingController(text: initialHour);
    TextEditingController minuteController =
        TextEditingController(text: initialMinute);
    List<dynamic> _selectedDays = [];
    String? _selectedAmOrPM = "AM";

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre del Medicamento'),
            ),
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'Tipo de Medicamento'),
            ),
            MultiSelectFormField(
              autovalidate: AutovalidateMode.always,
              dataSource: const [
                {'display': 'Lunes', 'value': 'Lunes'},
                {'display': 'Martes', 'value': 'Martes'},
                {'display': 'Miércoles', 'value': 'Miércoles'},
                {'display': 'Jueves', 'value': 'Jueves'},
                {'display': 'Viernes', 'value': 'Viernes'},
                {'display': 'Sábado', 'value': 'Sábado'},
                {'display': 'Domingo', 'value': 'Domingo'},
              ],
              title: Text("Días"),
              textField: 'display',
              valueField: 'value',
              okButtonLabel: 'Aceptar',
              cancelButtonLabel: 'Cancelar',
              hintWidget: Text('Seleccione los días'),
              initialValue: _selectedDays,
              onSaved: (value) {
                setState(() {
                  _selectedDays = value;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: hourController,
                    decoration: InputDecoration(labelText: 'Hora'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: minuteController,
                    decoration: InputDecoration(labelText: 'Minutos'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'AM',
                    items: ['AM', 'PM'].map((period) {
                      return DropdownMenuItem<String>(
                        value: period,
                        child: Text(period),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAmOrPM = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'AM/PM'),
                  ),
                ),
              ],
            ),
            TextField(
                controller: descriptionController,
                decoration:
                    InputDecoration(labelText: 'Descripcion(opcional)')),
            TextField(
                controller: dosageController,
                decoration: InputDecoration(labelText: 'Dosis')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            hourController.text.isNotEmpty &&
                    minuteController.text.isNotEmpty &&
                    _selectedDays.isNotEmpty &&
                    nameController.text.isNotEmpty &&
                    typeController.text.isNotEmpty &&
                    int.parse(hourController.text) >= 1 &&
                    int.parse(hourController.text) <= 12 &&
                    int.parse(minuteController.text) >= 0 &&
                    int.parse(minuteController.text) <= 59 &&
                    dosageController.text.isNotEmpty
                ? addMed(
                    context,
                    id_Usuario,
                    nameController.text,
                    typeController.text,
                    descriptionController.text.isNotEmpty
                        ? descriptionController.text
                        : "",
                    dosageController.text,
                    _selectedDays,
                    hourController.text,
                    minuteController.text,
                    _selectedAmOrPM)
                : Fluttertoast.showToast(
                    msg: 'Campo(s) sin llenar u hora invalida',
                    textColor: Colors.red);
            ;
          },
          child: Text(confirmLabel),
        ),
      ],
    );
  }

  Widget _buildEditMedicationDialog(
    BuildContext context,
    String title,
    String confirmLabel, {
    String? initialName,
    String? initialType,
    List<String>? initialDays,
    String? initialTime,
    String? initialDescription,
    String? initialDosage,
  }) {
    TextEditingController nameController =
        TextEditingController(text: initialName);
    TextEditingController typeController =
        TextEditingController(text: initialType);
    TextEditingController descriptionController =
        TextEditingController(text: initialDescription);
    TextEditingController dosageController =
        TextEditingController(text: initialDosage);

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration:
                    InputDecoration(labelText: 'Nombre del Medicamento')),
            TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Tipo de Medicamento')),
            MultiSelectFormField(
              autovalidate:
                  AutovalidateMode.always, // Modo de validación automática
              dataSource: const [
                {'display': 'Lunes', 'value': 'Lunes'},
                {'display': 'Martes', 'value': 'Martes'},
                {'display': 'Miércoles', 'value': 'Miércoles'},
                {'display': 'Jueves', 'value': 'Jueves'},
                {'display': 'Viernes', 'value': 'Viernes'},
                {'display': 'Sábado', 'value': 'Sábado'},
                {'display': 'Domingo', 'value': 'Domingo'},
              ],
              textField: 'display',
              valueField: 'value',
              okButtonLabel: 'Aceptar',
              cancelButtonLabel: 'Cancelar',
              hintWidget: Text('Seleccione los días'),
              onSaved: (value) {
                // Handle dropdown value change
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: TextEditingController(text: initialTime),
                      decoration: InputDecoration(labelText: 'Hora')),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                      controller: TextEditingController(text: initialTime),
                      decoration: InputDecoration(labelText: 'Minutos')),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'AM',
                    items: ['AM', 'PM'].map((period) {
                      return DropdownMenuItem<String>(
                        value: period,
                        child: Text(period),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Handle dropdown value change
                    },
                    decoration: InputDecoration(labelText: 'AM/PM'),
                  ),
                ),
              ],
            ),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descripción')),
            TextField(
                controller: dosageController,
                decoration: InputDecoration(labelText: 'Dosis')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            print(nameController.text);
            print(descriptionController.text);
            print(dosageController.text);
            Navigator.of(context).pop();
          },
          child: Text(confirmLabel),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Route route = MaterialPageRoute(builder: (_) => CalendarioPage());
          Navigator.pushReplacement(context, route);
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  isActive ? AppColors.thirdRectangleColor : Colors.transparent,
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

  // agregar medicamento
  addMed(BuildContext context,String user,String nombre,String tipo,String descripcion,String dosis,List<dynamic> dias,String hour,String minute,String? amOrPm) async {
    // formatear hora
    String tardeOManana = amOrPm.toString();
    String horaFormateada = formatearHora(hour, tardeOManana);
    String minutoFormateado = formatearMinuto(minute);
    // esto sera lo que se le enviara al api en hora
    String horaRecordatorio =
        horaFormateada + ":" + minutoFormateado + ":" + "00";
    // ingresar info medicamentos
    var res = await medRegister(nombre, tipo, user, descripcion, dosis);
    if (res['success']) {
      Fluttertoast.showToast(
          msg: 'Medicamento registrado', textColor: Colors.green);
      //res['med'] es el id del medicamento que se acaba de insertar
      int nRecActuales = 0;
      int nRecEsperados = dias.length;
      // agregar cada uno de los recordatorios
      dias.forEach((diaSemana) async {
        var resRec = await recRegister(
            diaSemana, horaRecordatorio, res['med'].toString());

        if (resRec['success']) {
          nRecActuales++;
          // cuando esten todos los recordatorios agregados mostrar el mensaje de confirmacion y cerrar
          if (nRecActuales == nRecEsperados) {
            Fluttertoast.showToast(
                msg: 'Recordatorio(s) agregado(s)', textColor: Colors.green);
            Navigator.of(context).pop();
            setState(() {});
          }
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: 'Fallo al registrar, intentalo denuevo', textColor: Colors.red);
    }
  }

  // borrar medicamento y todos sus recordatorios
  delMed(String id) async {
    var res = await medDelete(id);
    if (res['success']) {
      Fluttertoast.showToast(
          msg: 'Medicamento eliminado', textColor: Colors.green);
      setState(() {});
    }else{
      Fluttertoast.showToast(
          msg: 'Fallo al eliminar el medicamento', textColor: Colors.red);

    }
  }

  String formatearHora(String hour, String tardeOManana) {
    //si son las 12 de la noche transformar la hora a 00
    if (tardeOManana == "AM" && hour == "12") {
      String horaFormateada = "00";
      return horaFormateada;
    }
    // si es de tarde y no son las 12
    if (tardeOManana == "PM" && hour != "12") {
      int horaNumeros = int.parse(hour) + 12;
      String horaFormateada = horaNumeros.toString();
      return horaFormateada;
    }
    // si es un solo numero se agrega un 0 antes
    if (tardeOManana == "AM" && hour.length == 1) {
      String horaFormateada = "0" + hour;
      return horaFormateada;
    }
    // si no pasa nada de eso, significa que es de mañana y tiene  2 digitos
    return hour;
  }

  String formatearMinuto(String minute) {
    //si es un solo digito, se agrega un 0
    if (minute.length == 1) {
      String minutoFormateado = "0" + minute;
      return minutoFormateado;
    }
    return minute;
  }
}
