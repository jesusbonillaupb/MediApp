import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class MiCampoTexto extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String tipo;
  final List<String> opciones;
  String? selectedOption;

  MiCampoTexto({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.tipo,
    this.opciones = const ['Opcion 1', 'Opcion 2'],
    this.selectedOption,
  }) : super(key: key);

  @override
  _MiCampoTextoState createState() => _MiCampoTextoState();
}

class _MiCampoTextoState extends State<MiCampoTexto> {
  @override
  Widget build(BuildContext context) {
    return _buildContenido();
  }

  Widget _buildContenido() {
    // Dependiendo del tipo, el boton sera difernte
    switch (widget.tipo) {
      case ('Texto'):
        return campoTexto();
      case ('Contrasena'):
        return campoContrasena();
      case ('Celular'):
        return campoTelefono();
      case ('Seleccion'):
        return campoSelect();
      case ('Edad'):
        return campoEdad();
      //encaso de que se coloque algun otro tipo, se asumira que es un campo texto
      default:
        return campoTexto();
    }
  }

  // Tipos de campo
  //Tipo texto
  Widget campoTexto() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  widget.labelText,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Tipo contrasena
  Widget campoContrasena() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  widget.labelText,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Campo Telefono
  Widget campoTelefono() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  widget.labelText,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.phone, // Permite solo números
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], // Acepta solo dígitos
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget campoEdad() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  widget.labelText,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  style: const TextStyle(
                    color: Color(0xFF04364A), // Color hexadecimal #04364A
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.phone, // Permite solo números
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], // Acepta solo dígitos
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Si se trata de un selector
  Widget campoSelect() {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFB2E7FA),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelText,
                style: const TextStyle(
                  color: Color(0xFF04364A), // Color hexadecimal #04364A
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              DropdownButton<String>(
                value: widget.selectedOption,
                items: widget.opciones.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role,
                      style: const TextStyle(
                        color: Color(0xFF04364A), // Color hexadecimal #04364A
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    widget.selectedOption = value;
                    widget.controller.text = value!; 
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
