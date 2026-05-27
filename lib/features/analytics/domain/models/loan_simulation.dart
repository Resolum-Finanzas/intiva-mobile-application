import 'package:intiva_mobile_application/features/analytics/domain/models/payment_schedule.dart';

/// Full domain model for a loan simulation, optionally including its payment schedule.
class LoanSimulation {

  final String id;
  final String vehicleId;
  final String vehicleName;
  final double vehiclePrice;
  final double financedAmount;
  final String bankEntity;
  final double teaPercentage;
  final double tceaPercentage;
  final int termMonths;
  final double balloonPaymentAmount;
  final double van;
  final double tir;
  final double graceInterest;
  final DateTime createdAt;

  /// Full payment schedule; populated after `calculateSchedule` is called.
  final PaymentSchedule? schedule;

  /// Creates a [LoanSimulation] with all required fields.
  const LoanSimulation({
    required this.id,
    required this.vehicleId,
    required this.vehicleName,
    required this.vehiclePrice,
    required this.financedAmount,
    required this.bankEntity,
    required this.teaPercentage,
    required this.tceaPercentage,
    required this.termMonths,
    required this.balloonPaymentAmount,
    required this.van,
    required this.tir,
    required this.graceInterest,
    required this.createdAt,
    this.schedule,
  });
}
