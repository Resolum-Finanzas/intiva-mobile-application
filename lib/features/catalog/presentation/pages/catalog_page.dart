import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/bloc/catalog_state.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/widgets/catalog_header.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/widgets/vehicle_list.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CatalogBloc>()..add(LoadVehicles()),
      child: const _CatalogView(),
    );
  }
}

class _CatalogView extends StatelessWidget {
  const _CatalogView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CatalogHeader(),
            Expanded(
              child: BlocBuilder<CatalogBloc, CatalogState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return const SizedBox.shrink();

                    case Status.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case Status.failure:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 8),
                            IntivaText.body(
                              state.message ?? 'Ocurrió un error',
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<CatalogBloc>()
                                    .add(LoadVehicles());
                              },
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      );

                    case Status.success:
                      return VehicleList(
                        vehicles: state.vehicles,
                        onVehicleTap: (id) {
                          context.push('/catalog/$id');
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}