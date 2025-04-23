import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/sign/bloc_location/location_bloc.dart';
import 'package:signclock/sign/location_repo/location_repository.dart';
import 'package:signclock/api_services/sign_services.dart';

import 'sign_layout.dart';

class SignPage extends StatelessWidget {
  SignPage({super.key});

  final LocationRepository _locationRepository = LocationRepository();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthHyBloc>(context);

    return BlocProvider<LocationBloc>(
        create: (_) => LocationBloc(
              locationRepository: _locationRepository,
              authBloc: authBloc,
              signServices: SignServices(authBloc),
            ),
        child: const SignLayout());
  }
}
