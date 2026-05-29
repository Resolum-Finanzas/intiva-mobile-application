import 'package:intiva_mobile_application/features/analytics/domain/models/payment_period.dart';

class PaymentSchedule {
  final double totalInterest;
  final double totalAmortization;
  final double totalDesgravamen;
  final double totalVehicularInsurance;
  final double totalPayment;
  final double graceInterest;
  final List<PaymentPeriod> periods;

  const PaymentSchedule({
    required this.totalInterest,
    required this.totalAmortization,
    required this.totalDesgravamen,
    required this.totalVehicularInsurance,
    required this.totalPayment,
    required this.graceInterest,
    required this.periods,
  });
}
