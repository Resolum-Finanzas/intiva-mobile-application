import 'package:json_annotation/json_annotation.dart';
import 'payment_period_dto.dart';

part 'payment_schedule_dto.g.dart';

@JsonSerializable()
class PaymentScheduleDto {
  final double totalInterest;
  final double totalAmortization;
  final double totalDesgravamen;
  final double totalVehicularInsurance;
  final double totalPayment;
  final double graceInterest;
  final List<PaymentPeriodDto> periods;

  const PaymentScheduleDto({
    required this.totalInterest,
    required this.totalAmortization,
    required this.totalDesgravamen,
    required this.totalVehicularInsurance,
    required this.totalPayment,
    required this.graceInterest,
    required this.periods,
  });

  factory PaymentScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentScheduleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentScheduleDtoToJson(this);
}
