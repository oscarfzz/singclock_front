import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/auth_hydrated/auth_hy_bloc.dart';
import 'constant/theme.dart';
import 'otp_login/ui/login_layout.dart';
import 'root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageDirectory = kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: storageDirectory,
  );
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthHyBloc>(
      create: (context) => AuthHyBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: kPrimaryColor,
          primarySwatch: Palette.kToDark,
        ),
        routes: {
          '/': (context) => const AuthNavigator(),
          RootScreen.route: (context) => const RootScreen(),
          LoginLayout.route: (context) => const LoginLayout(),
        },
      ),
    );
  }
}

class AuthNavigator extends StatefulWidget {
  const AuthNavigator({super.key});

  @override
  State<AuthNavigator> createState() => _AuthNavigatorState();
}

class _AuthNavigatorState extends State<AuthNavigator> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuthState();
  }

  void _navigateBasedOnAuthState() {
    final state = context.read<AuthHyBloc>().state;

    Future.microtask(() {
      if (!mounted) return;

      final route = (state.isAuthenticated && state.user != null)
          ? RootScreen.route
          : LoginLayout.route;

      Navigator.of(context).pushNamedAndRemoveUntil(route, (r) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthHyBloc, AuthHyState>(
      listenWhen: (previous, current) =>
          previous.isAuthenticated != current.isAuthenticated ||
          (previous.user == null) != (current.user == null),
      listener: (context, state) {
        if (!mounted) return;

        final route = (state.isAuthenticated && state.user != null)
            ? RootScreen.route
            : LoginLayout.route;

        Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- ${bloc.runtimeType}, $error\n\n');
    }
    super.onError(bloc, error, stackTrace);
  }
}
