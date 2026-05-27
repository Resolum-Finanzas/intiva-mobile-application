/// Represents a single payment period within a loan amortisation schedule.
class PaymentPeriod {

  final int periodNumber;
  final DateTime paymentDate;
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

  /// Creates a [PaymentPeriod] with all required fields.
  const PaymentPeriod({
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
}
