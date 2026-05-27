import 'package:json_annotation/json_annotation.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/payment_schedule_dto.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/payment_schedule.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/payment_period.dart';

part 'loan_simulation_dto.g.dart';

@JsonSerializable()
class LoanSimulationDto {
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
  final String createdAt;
  final PaymentScheduleDto? schedule;

  /// Creates a [LoanSimulationDto] with all required fields.
  const LoanSimulationDto({
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

  /// Creates a [LoanSimulationDto] from a JSON map.
  factory LoanSimulationDto.fromJson(Map<String, dynamic> json) =>
      _$LoanSimulationDtoFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$LoanSimulationDtoToJson(this);

  /// Maps this DTO to the domain [LoanSimulation] model.
  LoanSimulation toDomain() => LoanSimulation(
        id: id,
        vehicleId: vehicleId,
        vehicleName: vehicleName,
        vehiclePrice: vehiclePrice,
        financedAmount: financedAmount,
        bankEntity: bankEntity,
        teaPercentage: teaPercentage,
        tceaPercentage: tceaPercentage,
        termMonths: termMonths,
        balloonPaymentAmount: balloonPaymentAmount,
        van: van,
        tir: tir,
        graceInterest: graceInterest,
        createdAt: DateTime.parse(createdAt),
        schedule: schedule == null
            ? null
            : PaymentSchedule(
                totalInterest: schedule!.totalInterest,
                totalAmortization: schedule!.totalAmortization,
                totalDesgravamen: schedule!.totalDesgravamen,
                totalVehicularInsurance: schedule!.totalVehicularInsurance,
                totalPayment: schedule!.totalPayment,
                graceInterest: schedule!.graceInterest,
                periods: schedule!.periods
                    .map(
                      (p) => PaymentPeriod(
                        periodNumber: p.periodNumber,
                        paymentDate: DateTime.parse(p.paymentDate),
                        initialBalance: p.initialBalance,
                        interest: p.interest,
                        amortization: p.amortization,
                        desgravamenInsurance: p.desgravamenInsurance,
                        vehicularInsurance: p.vehicularInsurance,
                        totalPayment: p.totalPayment,
                        finalBalance: p.finalBalance,
                        netFlow: p.netFlow,
                        isBalloon: p.isBalloon,
                        isGracePeriod: p.isGracePeriod,
                      ),
                    )
                    .toList(),
              ),
      );
}
