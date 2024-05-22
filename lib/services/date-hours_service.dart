import 'dart:convert';
import 'package:http/http.dart' as http;

class TimeService {
  static const BASE_URL = 'https://api.api-ninjas.com/v1/worldtime';
  static const API_KEY = 'BsLXzFaYhcvLUlaMbkPoyg==bA4w50uJU0sSkjpp';

  Future<String> getCityTime(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?timezone=$cityName'),
      headers: {'X-Api-Key': API_KEY},
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching time data: ${response.reasonPhrase}');
    } else {
      final data = jsonDecode(response.body);
      return data['datetime'];
    }
  }
}
