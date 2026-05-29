/// This file contains the API endpoint constants used throughout the application.
/// It centralizes all the API paths, making it easier to manage and update them in one place.
abstract class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://intiva.free.beeceptor.com/api/v1/';

  // IAM
  static const String signIn = '/authentication/sign-in';
  static const String signUp = '/authentication/sign-up';

  // Catalog
  static const String vehicles = '/vehicles';
  static const String vehicleById = '/vehicles/{id}';

  // Simulador
  static const String simulate = '/simulate';

  // Profiles
  static const String profile = '/users/me';

  // Simulations
  static const String simulationById = '/simulations/{id}';
  static const String simulationsByUser = '/simulations/user/{userId}';
  static const String simulationSchedule = '/simulations/{id}/schedule';

  // Notifications
  static const String notifications = '/notifications';
  static const String notificationsByUser = '/notifications/user/{userId}';
  static const String simulationReport = '/notifications/simulation-report';
  static const String paymentReminder = '/notifications/payment-reminder';

  // Bank rates
  static const String bankRateConfig = '/bank-rates/{bankEntity}';
}
