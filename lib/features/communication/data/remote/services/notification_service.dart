import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:intiva_mobile_application/features/communication/data/remote/models/notification_dto.dart';

part 'notification_service.g.dart';

/// Retrofit-annotated service for the notifications API.
///
/// All methods return raw DTOs or void; mapping to domain models is the
/// responsibility of the repository layer.
@RestApi()
abstract class NotificationService {
  /// Creates a [NotificationService] bound to the given [dio] client.
  ///
  /// An optional [baseUrl] overrides the client's base URL.
  factory NotificationService(Dio dio, {String baseUrl}) =
      _NotificationService;

  /// Sends a simulation report email.
  ///
  /// [body] must contain `simulationId` (String) and `recipientEmail` (String).
  @POST('notifications/simulation-report')
  Future<void> sendSimulationReport(@Body() Map<String, dynamic> body);

  /// Sends a payment reminder notification.
  ///
  /// [body] must contain `simulationId` (String) and `userId` (int).
  @POST('notifications/payment-reminder')
  Future<void> sendPaymentReminder(@Body() Map<String, dynamic> body);

  /// Returns all notifications for the user identified by [userId].
  @GET('notifications/user/{userId}')
  Future<List<NotificationDto>> getNotificationsByUser(
    @Path('userId') int userId,
  );
}
