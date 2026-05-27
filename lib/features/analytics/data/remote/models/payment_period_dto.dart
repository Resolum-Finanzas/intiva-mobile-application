import 'package:json_annotation/json_annotation.dart';

part 'payment_period_dto.g.dart';

/// Data Transfer Object representing a single payment period in a loan schedule.
@JsonSerializable()
class PaymentPeriodDto {
  final int periodNumber;
  final String paymentDate;
  final double initialBalance;
  final double interest;
  final double amortization;
  final double desgravamenInsurance;
  final double vehicularInsurance;
  final double totalPayment;
  final double finalBalance;
  final double netFlow;
  final bool isBalloon;
  final bool isGracePeriod;

  /// Creates a [PaymentPeriodDto] with all required fields.
  const PaymentPeriodDto({
    required this.periodNumber,
    required this.paymentDate,
    required this.initialBalance,
    required this.interest,
    required this.amortization,
    required this.desgravamenInsurance,
    required this.vehicularInsurance,
    required this.totalPayment,
    required this.finalBalance,
    required this.netFlow,
    required this.isBalloon,
    required this.isGracePeriod,
  });

  /// Creates a [PaymentPeriodDto] from a JSON map.
  factory PaymentPeriodDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentPeriodDtoFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$PaymentPeriodDtoToJson(this);
}
