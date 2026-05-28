import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/bank_rate_card.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/insurance_rate_table.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/interest_range_table.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';

/// The default configuration page for the Intiva app, displaying BCP
/// institutional rate conditions in a read-only format.
///
/// Accessible from the bottom navigation tab 3 and from the profile page
/// menu item "Configuración". No BLoC or API call is needed — all data is
/// hardcoded from official BCP documentation to ensure accuracy and offline
/// access.
///
/// The page is split into two visual sections:
/// - **Ajustes Generales** — locked currency and rate-type settings.
/// - **Condiciones de las tasas en BCP** — three [BankRateCard] widgets
///   covering desgravamen rates, vehicular insurance rates, and interest
///   ranges by financed amount.
///
/// This is a static page with no reuse concern, so [AppColors] constants are
/// used directly (consistent with the catalog_page.dart pattern).
class ConfigurationPage extends StatelessWidget {
  /// Creates a [ConfigurationPage].
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ConfigurationView();
  }
}
class _ConfigurationView extends StatelessWidget {
  const _ConfigurationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: const _ConfigurationContent(),
    );
  }
}

class _ConfigurationContent extends StatelessWidget {
  const _ConfigurationContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 20),
              child: Text(
                'Configuración',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const Text(
            'Ajustes Generales',
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            color: Colors.white,
            child: Column(
              children: [
                const _SettingTile(
                  icon: Icons.monetization_on_outlined,
                  subtitle: 'Moneda',
                  title: 'Dólares (USD)',
                ),
                const Divider(
                  height: 1,
                  color: Color(0xFFE0E0E0),
                  indent: 16,
                ),
                const _SettingTile(
                  icon: Icons.percent,
                  subtitle: 'Tipo de Tasa',
                  title: 'Tasa Efectiva (TEA)',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Condiciones de las tasas en BCP',
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          BankRateCard(
            headerColor: AppColors.secondary,
            headerIcon: Icons.shield_outlined,
            headerTitle: 'Tasas del seguro de desgravamen',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntivaText.body(
                  'Seguro que cubre el saldo deudor del préstamo '
                  'en caso de fallecimiento o invalidez total y permanente.',
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                const Text(
                  'TASA VIGENTE',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: 40,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '0.077% mensual',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'Vigente desde el 01 de junio de 2025',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          BankRateCard(
            headerColor: AppColors.secondary,
            headerIcon: Icons.directions_car_outlined,
            headerTitle: 'Tasas del seguro vehicular',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntivaText.body(
                  'Tasas anuales diferenciadas según el nivel de '
                  'riesgo asignado al perfil del cliente y vehículo.',
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 12),
                const InsuranceRateTable(),
              ],
            ),
          ),

          const SizedBox(height: 16),
          BankRateCard(
            headerColor: AppColors.primary,
            headerIcon: Icons.bar_chart,
            headerTitle: 'Tasas de interés según monto',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntivaText.body(
                  'Rangos de tasas aplicables según el monto '
                  'total financiado en dólares americanos.',
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 12),
                const InterestRangeTable(),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// A read-only list tile displaying a locked configuration setting.
///
/// Shows an icon in a rounded container using [AppColors.primaryLight] as the
/// background and [AppColors.primary] as the icon tint. A [subtitle] label
/// describes the setting category (e.g. "Moneda") while [title] shows the
/// current value (e.g. "Dólares (USD)"). A lock icon in the trailing position
/// communicates to the user that this setting cannot be modified.
///
/// This widget is intentionally disabled ([ListTile.enabled] = false) to
/// prevent any tap interaction, reinforcing the read-only nature of the
/// configuration screen.
class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String subtitle;
  final String title;

  /// Creates a [_SettingTile].
  const _SettingTile({
    required this.icon,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: false,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      subtitle: IntivaText.caption(subtitle, color: Colors.grey[600]),
      title: IntivaText.body(title),
      trailing: Icon(Icons.lock_outline, color: Colors.grey[400], size: 18),
    );
  }
}
