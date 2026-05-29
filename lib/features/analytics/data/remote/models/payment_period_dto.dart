import 'package:json_annotation/json_annotation.dart';

part 'payment_period_dto.g.dart';

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

  factory PaymentPeriodDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentPeriodDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentPeriodDtoToJson(this);
}
