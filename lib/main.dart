import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/root_screen.dart';
import 'package:signclock/constant/theme.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'otp_login/ui/login_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  final authBloc = AuthHyBloc();
  runApp(AppView(authBloc: authBloc));
}

class AppView extends StatelessWidget {
  final AuthHyBloc authBloc;
  const AppView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthHyBloc>.value(
      value: authBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: kPrimaryColor,
          primarySwatch: Palette.kToDark,
        ),
        routes: {
          RootScreen.route: (context) => const RootScreen(),
          LoginLayout.route: (context) => const LoginLayout(),
        },
        home: const AuthNavigator(),
      ),
    );
  }
}

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthHyBloc, AuthHyState>(
      listenWhen: (previous, current) =>
          previous.isAuthenticated != current.isAuthenticated,
      listener: (context, state) {
        if (state.isAuthenticated) {
          Navigator.of(context).pushReplacementNamed(RootScreen.route);
        } else {
          Navigator.of(context).pushReplacementNamed(LoginLayout.route);
        }
      },
      child: context.select((AuthHyBloc bloc) => bloc.state.isAuthenticated)
          ? const RootScreen()
          : const LoginLayout(),
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
