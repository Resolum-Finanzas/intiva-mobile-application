import 'package:json_annotation/json_annotation.dart';

part 'create_loan_simulation_dto.g.dart';

@JsonSerializable()
class CreateLoanSimulationDto {
  final String vehicleId;
  final String vehicleName;
  final double vehiclePrice;
  final double initialPaymentPercentage;
  final String bankEntity;
  final double teaPercentage;
  final int termMonths;
  final double balloonPaymentPercentage;
  final bool vehicularInsuranceEnabled;
  final double vehicularInsuranceRate;
  final bool desgravamenInsuranceEnabled;
  final bool gracePeriodEnabled;
  final String? gracePeriodType;
  final int? gracePeriodMonths;
  final String loanStartDate;
  const CreateLoanSimulationDto({
    required this.vehicleId,
    required this.vehicleName,
    required this.vehiclePrice,
    required this.initialPaymentPercentage,
    required this.bankEntity,
    required this.teaPercentage,
    required this.termMonths,
    required this.balloonPaymentPercentage,
    required this.vehicularInsuranceEnabled,
    required this.vehicularInsuranceRate,
    required this.desgravamenInsuranceEnabled,
    required this.gracePeriodEnabled,
    this.gracePeriodType,
    this.gracePeriodMonths,
    required this.loanStartDate,
  });
  factory CreateLoanSimulationDto.fromJson(Map<String, dynamic> json) =>
      _$CreateLoanSimulationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateLoanSimulationDtoToJson(this);
}
