import 'package:json_annotation/json_annotation.dart';
import 'payment_period_dto.dart';

part 'payment_schedule_dto.g.dart';

/// Data Transfer Object representing the full payment schedule for a loan simulation.
@JsonSerializable()
class PaymentScheduleDto {

  final double totalInterest;
  final double totalAmortization;
  final double totalDesgravamen;
  final double totalVehicularInsurance;
  final double totalPayment;
  final double graceInterest;
  final List<PaymentPeriodDto> periods;

  /// Creates a [PaymentScheduleDto] with all required fields.
  const PaymentScheduleDto({
    required this.totalInterest,
    required this.totalAmortization,
    required this.totalDesgravamen,
    required this.totalVehicularInsurance,
    required this.totalPayment,
    required this.graceInterest,
    required this.periods,
  });

  /// Creates a [PaymentScheduleDto] from a JSON map.
  factory PaymentScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentScheduleDtoFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$PaymentScheduleDtoToJson(this);
}
