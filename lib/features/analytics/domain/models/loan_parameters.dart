/// Encapsulates all user-configurable parameters for a loan simulation request.
///
/// This value object is built from the simulator form and passed to the
/// repository to create a new simulation. No financial computation is
/// performed here — all math is delegated to the backend.
class LoanParameters {

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
  final DateTime loanStartDate;

  /// Creates a [LoanParameters] instance with all required fields.
  const LoanParameters({
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

  /// Returns the financed amount derived from [vehiclePrice] and [initialPaymentPercentage].
  double get financedAmount =>
      vehiclePrice * (1 - initialPaymentPercentage / 100);
}
