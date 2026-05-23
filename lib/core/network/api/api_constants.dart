/// This file contains the API endpoint constants used throughout the application.
/// It centralizes all the API paths, making it easier to manage and update them in one place.
abstract class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';

  // IAM
  static const String signIn = '/authentication/sign-in';
  static const String signUp = '/authentication/sign-up';

  // Catalog
  static const String vehicles = '/vehicles';
  static String vehicleDetail(String id) => '/vehicles/$id';

  // Simulador
  static const String simulate = '/simulate';

  // Profiles
  static const String profile = '/users/me';
}
