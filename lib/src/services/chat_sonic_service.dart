import 'package:http/http.dart' as http;
import 'dart:convert';


Future<Map<String, dynamic>?> sonciChatService(String requestMsg) async {
  final Map<String, dynamic> decodedResp;

  String rout = "http://172.16.90.55:4000/api/";

  var url = '${rout}chatSonic/';

  Map<String, String> header = {
    "apikey": "123456",
  };

  try {
    final http.Response resp = await http.post(Uri.parse(url),
        body: {'message': requestMsg}, headers: header);
    decodedResp = jsonDecode(resp.body);


    /* isTyping = false;
    setState(() {});*/

    print(decodedResp);
    return decodedResp;
  } catch (err) {

  }
}