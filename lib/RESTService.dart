import 'dart:convert';

import 'package:http/http.dart' as http;

// Import the CalculationData class
import 'calculation_data.dart';

class RESTService {
  static Future<Object> sendData(String illuminance, String area) async {
    final response = await http.get(Uri.parse(
        'https://drone-api.vercel.app/calculation?illuminance=$illuminance&area=$area'));
    if (response.statusCode == 200) {
      return CalculationData.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return false;
    }
  }
}
