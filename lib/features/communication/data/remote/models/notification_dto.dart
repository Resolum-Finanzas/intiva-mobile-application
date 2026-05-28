import 'package:json_annotation/json_annotation.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification_status.dart';

part 'notification_dto.g.dart';

/// Data Transfer Object for a [Notification] as returned by the API.
///
/// Annotated with [JsonSerializable] for code-generated JSON handling.
/// Call [toDomain] to convert to the domain [Notification] model.
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

  /// Creates a [NotificationDto] with all required fields.
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

  /// Deserialises a [NotificationDto] from a JSON map.
  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  /// Serialises this instance to a JSON map.
  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);

  /// Converts this DTO to the domain [Notification] model.
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

  /// Maps a raw status string to a [NotificationStatus] enum value.
  static NotificationStatus _parseStatus(String raw) =>
      switch (raw.toLowerCase()) {
        'sent' => NotificationStatus.sent,
        'failed' => NotificationStatus.failed,
        _ => NotificationStatus.pending,
      };
}
