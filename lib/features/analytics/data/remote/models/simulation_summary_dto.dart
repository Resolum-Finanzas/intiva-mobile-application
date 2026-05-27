import 'package:json_annotation/json_annotation.dart';

part 'simulation_summary_dto.g.dart';

/// Data Transfer Object for a lightweight simulation summary shown in history lists.
@JsonSerializable()
class SimulationSummaryDto {
  final String id;
  final String vehicleName;
  final double financedAmount;
  final double teaPercentage;
  final int termMonths;
  final double estimatedMonthlyPayment;
  final String createdAt;

  /// Creates a [SimulationSummaryDto] with all required fields.
  const SimulationSummaryDto({
    required this.id,
    required this.vehicleName,
    required this.financedAmount,
    required this.teaPercentage,
    required this.termMonths,
    required this.estimatedMonthlyPayment,
    required this.createdAt,
  });

  /// Creates a [SimulationSummaryDto] from a JSON map.
  factory SimulationSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$SimulationSummaryDtoFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$SimulationSummaryDtoToJson(this);
}
