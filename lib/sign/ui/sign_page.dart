import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/chats/utils/dio_client.dart';
import 'package:signclock/sign/bloc_location/location_bloc.dart';
import 'package:signclock/sign/location_repo/location_repository.dart';
import 'package:signclock/api_services/sign_services.dart';

import 'sign_layout.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage>
    with AutomaticKeepAliveClientMixin {
  LocationBloc? _locationBloc;
  final LocationRepository _locationRepository = LocationRepository();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initLocationBloc();
  }

  void _initLocationBloc() {
    final authBloc = context.read<AuthHyBloc>();
    final dioClient = DioClient(authBloc);

    if (authBloc.state.isAuthenticated && authBloc.state.user != null) {
      _locationBloc = LocationBloc(
        locationRepository: _locationRepository,
        authBloc: authBloc,
        signServices: SignServices(dioClient.instance, authBloc),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_locationBloc != null && !_locationBloc!.isClosed) {
          _locationBloc!.add(InitEvent());
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final authBloc = context.read<AuthHyBloc>();
    final dioClient = DioClient(authBloc);

    if (authBloc.state.user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_locationBloc == null) {
      _initLocationBloc();
    }

    return BlocProvider<LocationBloc>.value(
      value: _locationBloc ??
          LocationBloc(
            locationRepository: _locationRepository,
            authBloc: authBloc,
            signServices: SignServices(dioClient.instance, authBloc),
          ),
      child: const SignLayout(),
    );
  }
}
