/// Lightweight summary of a loan simulation, used in history lists.
class SimulationSummary {

  final String id;
  final String vehicleName;
  final double financedAmount;
  final double teaPercentage;
  final int termMonths;
  final double estimatedMonthlyPayment;
  final DateTime createdAt;

  /// Creates a [SimulationSummary] with all required fields.
  const SimulationSummary({
    required this.id,
    required this.vehicleName,
    required this.financedAmount,
    required this.teaPercentage,
    required this.termMonths,
    required this.estimatedMonthlyPayment,
    required this.createdAt,
  });
}
