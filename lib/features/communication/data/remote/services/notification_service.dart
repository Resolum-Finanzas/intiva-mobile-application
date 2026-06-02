import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:intiva_mobile_application/features/communication/data/remote/models/notification_dto.dart';

part 'notification_service.g.dart';

@RestApi()
abstract class NotificationService {
  factory NotificationService(Dio dio, {String baseUrl}) =
      _NotificationService;

  @POST('notifications/simulation-report')
  Future<void> sendSimulationReport(@Body() Map<String, dynamic> body);

  @POST('notifications/payment-reminder')
  Future<void> sendPaymentReminder(@Body() Map<String, dynamic> body);

  @GET('notifications/user/{userId}')
  Future<List<NotificationDto>> getNotificationsByUser(
    @Path('userId') int userId,
  );
}
