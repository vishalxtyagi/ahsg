import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService {

  final http.Client httpClient;

  APIService(this.httpClient);

  Future<List> getBuses() async {
    final response = await httpClient.get(
        Uri.https('example.com', 'api/buses')
    );

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error getting buses');
    }
  }

  Future updateAttendance(int studentId, bool isPresent) async {
    // Call API to update attendance
  }

}