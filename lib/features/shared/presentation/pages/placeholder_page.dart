import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intiva_mobile_application/core/navigation/router/router_names.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_button.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/dropdown_field.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/toggle_row.dart';

class PlaceholderPage extends StatefulWidget {
  final String name;
  const PlaceholderPage({super.key, required this.name});

  @override
  State<PlaceholderPage> createState() => _PlaceholderPageState();
}

class _PlaceholderPageState extends State<PlaceholderPage> {
  bool seguroActivo = false;
  bool graciaActivo = false;
  String frecuencia = 'mensual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntivaText.display('${widget.name} Page'),
            const SizedBox(height: 4),
            IntivaText.body('Este Page es unicamente para probar los widgets reutilizables de Intiva', color: Colors.grey),
            const Divider(height: 32),

            DropdownField<String>(
              label: 'Frecuencia de Pago',
              value: frecuencia,
              items: const [
                DropdownMenuItem(value: 'mensual', child: Text('Mensual')),
                DropdownMenuItem(value: 'quincenal', child: Text('Quincenal')),
                DropdownMenuItem(value: 'semanal', child: Text('Semanal')),
              ],
              onChanged: (v) => setState(() => frecuencia = v!),
            ),
            const SizedBox(height: 20),

            ToggleRow(
              icon: Icons.shield_outlined,
              title: 'Seguro de Desgravamen',
              subtitle: 'Tasa mensual fija de 0.077%',
              value: seguroActivo,
              onChanged: (v) => setState(() => seguroActivo = v),
            ),
            const SizedBox(height: 12),
            ToggleRow(
              icon: Icons.calendar_month_outlined,
              title: 'Periodo de Gracia',
              value: graciaActivo,
              onChanged: (v) => setState(() => graciaActivo = v),
            ),
            const SizedBox(height: 32),

            IntivaButton(label: 'Ir a Inicio', onPressed: () => context.go(RouteNames.home)),
            const SizedBox(height: 12),
            IntivaButton(
              label: 'No hago nada w',
              variant: IntivaButtonVariant.outlined,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
