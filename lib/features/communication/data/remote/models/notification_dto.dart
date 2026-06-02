import 'package:json_annotation/json_annotation.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification_status.dart';

part 'notification_dto.g.dart';

@JsonSerializable()
class NotificationDto {
  final String id;
  final String emailAddress;
  final String subject;
  final String htmlContent;
  final String recipientName;
  final int relatedEntityId;
  final String status;
  final String createdAt;

  const NotificationDto({
    required this.id,
    required this.emailAddress,
    required this.subject,
    required this.htmlContent,
    required this.recipientName,
    required this.relatedEntityId,
    required this.status,
    required this.createdAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);

  Notification toDomain() => Notification(
        id: id,
        emailAddress: emailAddress,
        subject: subject,
        htmlContent: htmlContent,
        recipientName: recipientName,
        relatedEntityId: relatedEntityId,
        status: _parseStatus(status),
        createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      );

  static NotificationStatus _parseStatus(String raw) =>
      switch (raw.toLowerCase()) {
        'sent' => NotificationStatus.sent,
        'failed' => NotificationStatus.failed,
        _ => NotificationStatus.pending,
      };
}
