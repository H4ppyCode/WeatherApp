import 'dart:convert';
import 'package:http/http.dart' as http;

class TimezoneService {
  static const BASE_URL = 'https://api.api-ninjas.com/v1/timezone';
  static const BASE_URL2 = 'https://api.api-ninjas.com/v1/geocoding';
  // static const BASE_URL2 = 'https://api-adresse.data.gouv.fr/search/';

  final String API_KEY = 'nptAnEdTPnndJJT1Il1sQg==SgSNi5yThRX0qD6L';

  TimezoneService();

  Future<String> getCoordinates(String city) async {
    final response = await http.get(
      Uri.parse('$BASE_URL2?city=$city'),
      headers: {'X-Api-Key': API_KEY},
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching getcoordinate data');
    } else {
      final data = jsonDecode(response.body);
      print(data);
      final lat = data[0]['latitude'].toString();
      final long = data[0]['longitude'].toString();
      print(lat);
      print(long);
      return getTimeZone(lat, long);
    }
  }

  Future<String> getCoordinatesLatLong(String city) async {
    final response = await http.get(
      Uri.parse('$BASE_URL2?city=$city'),
      headers: {'X-Api-Key': API_KEY},
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching getcoordinate data');
    } else {
      final data = jsonDecode(response.body);
      print(data);
      final lat = data[0]['latitude'].toString();
      final long = data[0]['longitude'].toString();
      print(lat);
      print(long);
      return lat + ';' + long;
    }
  }
  // Future<String> getCoordinates(String city) async {
  //   final response = await http.get(
  //     Uri.parse('$BASE_URL2?q=$city'),
  //   );
  //   print(response.request.toString());
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Error fetching getcoordinate data');
  //   } else {
  //     final data = jsonDecode(response.body);
  //     final long = data['features'][0]['geometry']['coordinates'][0].toString();
  //     final lat = data['features'][0]['geometry']['coordinates'][1].toString();
  //     return getTimeZone(lat, long);
  //   }
  // }

  Future<String> getTimeZone(String lat, String long) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?lat=$lat&lon=$long'),
      headers: {'X-Api-Key': API_KEY},
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching timezone data');
    } else {
      final data = jsonDecode(response.body);
      print(data['timezone'].toString());
      return data['timezone'].toString();
    }
  }
}
