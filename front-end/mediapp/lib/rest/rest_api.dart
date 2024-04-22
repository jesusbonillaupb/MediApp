import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyect_views_front/constant/utils.dart';


Future userLogin(String correo,String password) async{
  
  final url=Uri.parse('${Utils.baseUrl}/user/login');
  print(url);
  final response=await http.post(url,
    headers: {"Accept":"Application/json"},
    body: {'correo':correo,'password':password}
  );
  


   var decodedData=jsonDecode(response.body);
   
  return decodedData;
}

Future userRegister(String nombre,String password,String correo, String celular, int edad) async{
  
  final url=Uri.parse('${Utils.baseUrl}/user/register');
  final response=await http.post(url,
    headers: {"Accept":"Application/json"},
    body: {'nombre':nombre,'password':password,'correo':correo,'celular':celular,'edad':edad.toString()}
  );
  


   var decodedData=jsonDecode(response.body);
   
  return decodedData;
}


Future<List<dynamic>> medGet(int id_Usuario) async {
    var url = Uri.parse('${Utils.baseUrl}/med/usermeds/$id_Usuario');
    var response = await http.get(url);
    var medItems = [];
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        medItems = jsonResponse["med"];
        
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return medItems;
  }

Future<List<dynamic>> medAndRecGet(String id_Med) async {
    var url = Uri.parse('${Utils.baseUrl}/rec/medi/$id_Med');
    var response = await http.get(url);
    var medItems = [];
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        medItems = jsonResponse["recordatorio"];
        
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return medItems;
  }
  
Future medRegister(String nombre,String tipo,String usuario,String descripcion, String dosis) async{
  
  final url=Uri.parse('${Utils.baseUrl}/med/register');
  final response=await http.post(url,
    headers: {"Accept":"Application/json"},
    body: {'nombreMed':nombre,'medTipo':tipo,'fk_usuario':usuario,'medDescripcion':descripcion,'medDosis':dosis}
  );
  


   var decodedData=jsonDecode(response.body);
   
  return decodedData;
}
Future recRegister(String diasemana,String hora,String idmed) async{
  
  final url=Uri.parse('${Utils.baseUrl}/rec/register');
  final response=await http.post(url,
    headers: {"Accept":"Application/json"},
    body: {'diaSemana':diasemana,'hora':hora,'fk_med':idmed}
  );
  


   var decodedData=jsonDecode(response.body);
   
  return decodedData;
}

Future medDelete(String medId) async {
  final url = Uri.parse('${Utils.baseUrl}/med/$medId');
  final response = await http.delete(
    url,
    headers: {"Accept": "Application/json"},
  );

  var decodedData = jsonDecode(response.body);
  
  return decodedData;
}

Future recDelete(String idmed,String dia) async {
  final url = Uri.parse('${Utils.baseUrl}/rec/quitardia/$idmed/$dia');
  final response = await http.delete(
    url,
    headers: {"Accept": "Application/json"},
  );

  var decodedData = jsonDecode(response.body);
  
  return decodedData;
}


Future medUpdate(String nombre,String tipo,String idmed,String descripcion, String dosis) async{
  
  final url=Uri.parse('${Utils.baseUrl}/med/cambiar/$idmed');
  final response=await http.put(url,
    headers: {"Accept":"Application/json"},
    body: {'nombremed':nombre,'medtipo':tipo,'meddescripcion':descripcion,'meddosis':dosis}
  );
  


   var decodedData=jsonDecode(response.body);
   
  return decodedData;
}


Future horaUpdate(String idmed,String hora) async{
  
  final url=Uri.parse('${Utils.baseUrl}/rec/cambiar/$idmed');
  final response=await http.put(url,
    headers: {"Accept":"Application/json"},
    body: {'hora':hora}
  );
  


   var decodedData=jsonDecode(response.body);
   
  return decodedData;
}