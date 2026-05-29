import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intiva_mobile_application/core/network/api/resource.dart';
import 'package:intiva_mobile_application/features/iam/domain/models/user.dart';
import 'package:intiva_mobile_application/core/network/api/api_endpoints.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    try {
      final Uri uri = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.signIn);

      final http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        return User.fromJson(json);
      }
      throw HttpException('Unexpected HTTP Status: ${response.statusCode}');
    } on SocketException {
      throw const SocketException('Failed to establish network connection');
    } on FormatException catch (e) {
      throw FormatException('Failed to parse response: $e');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Resource<String>> register(
    String name,
    String email,
    String password,
    String role,
    String businessName,
  ) async {
    final Uri uri = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.signUp);

    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        'businessName': businessName,
        'role': role,
      }),
    );

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      return Success<String>(data: json['message']);
    }
    throw HttpException('Unexpected HTTP Status: ${response.statusCode}');
  }
}
