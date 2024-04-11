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
  print(url);
  final response=await http.post(url,
    headers: {"Accept":"Application/json"},
    body: {'nombre':nombre,'password':password,'correo':correo,'celular':celular,'edad':edad.toString()}
  );
  


   var decodedData=jsonDecode(response.body);
   
  return decodedData;
}