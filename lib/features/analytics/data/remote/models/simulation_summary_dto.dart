import 'package:json_annotation/json_annotation.dart';

part 'simulation_summary_dto.g.dart';

@JsonSerializable()
class SimulationSummaryDto {
  final String id;
  final String vehicleName;
  final double financedAmount;
  final double teaPercentage;
  final int termMonths;
  final double estimatedMonthlyPayment;
  final String createdAt;

  const SimulationSummaryDto({
    required this.id,
    required this.vehicleName,
    required this.financedAmount,
    required this.teaPercentage,
    required this.termMonths,
    required this.estimatedMonthlyPayment,
    required this.createdAt,
  });

  factory SimulationSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$SimulationSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SimulationSummaryDtoToJson(this);
}
