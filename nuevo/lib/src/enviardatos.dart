import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class enviarDatos {
  enviar(data) async {
    try {
      var url = 'http://192.168.10.173';
      final http.Response response = await http.post(url, body: data);
      //print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        //print(jsonDecode(response.body));
        return true;
      } else {
        throw Exception('Error al enviar informacion');
      }
    } on SocketException catch (_) {
      print('error en la conexion');
      return false;
    }
  }
}
