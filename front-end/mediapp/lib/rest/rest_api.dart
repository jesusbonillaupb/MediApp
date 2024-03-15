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