import 'package:http/http.dart' as http;
import 'package:nations_app/src/token.dart';

class CountryRepo {
  Future<http.Response> getCountries() async {
    try {
      final url = Uri.parse('https://restfulcountries.com/api/v1/countries');
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: headers);
      // print(response.body);

      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
