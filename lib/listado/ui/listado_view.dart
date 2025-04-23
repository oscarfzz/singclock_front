import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/api_services/listings_service.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/widgets/header_logo_layout.dart';

import '../bloc/listado_bloc.dart';
import 'widgets/listado_list_widget.dart';

class ListadoView extends StatelessWidget {
  const ListadoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListadoBloc>(
      create: (context) => ListadoBloc(
        authHyBloc: context.read<AuthHyBloc>(),
        listingService: ListingService(context.read<AuthHyBloc>()),
      )..add(LoadListadoEvent()),
      child: const _ListadoBody(),
    );
  }
}

class _ListadoBody extends StatelessWidget {
  const _ListadoBody();

  void _showErrorMessage(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ListadoBloc, ListadoState>(
        listener: (context, state) {
          if (state is ListadoErrorState) {
            _showErrorMessage(context, state.message!);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.message!)),
            // );
          }
        },
        builder: (BuildContext context, ListadoState state) {
          if (state is ListadoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListadoLoadedState) {
            return HeaderLogoLayout(child: ListadoListWidget(state.signList));
          } else if (state is ListadoErrorState) {
            return const Center(
              child: Text("Registros, cero"),
            );
          } else if (state is ListadoEmptyState) {
            return const Center(
              child: Text("No hay registros."),
            );
          } else {
            return const Center(
              child: Text("Estado desconocido."),
            );
          }
        },
      ),
    );
  }
}
