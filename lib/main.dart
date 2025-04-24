import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/blocs/app/app_state.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/root_screen.dart';
import 'package:signclock/constant/theme.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'otp_login/ui/login_layout.dart';

// import 'package:rollbar_flutter/rollbar.dart' show Rollbar, RollbarFlutter;
// import 'package:rollbar_flutter/rollbar.dart' as rollbar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  //AppState.init();
  //final appState = AppState.init();
  final authBloc = AuthHyBloc();
  // await authBloc.load(); para que ???

  // no se si es necesario esto.....
  final appState = AppState.init(
    status: authBloc.state.isAuthenticated
        ? AppStatus.identified
        : AppStatus.unidentified,
    phoneModel: authBloc.state.user,
    token: authBloc.state.token,
  );

  appState.subscribe((newState) {
    authBloc.add(AuthHyEvent.appStateChanged(newState));
  });
  // const config = rollbar.Config(
  //   accessToken: 'de879c63aaa24cdb9345ffea10e3290f',
  //   environment: 'development',
  //   codeVersion: String.fromEnvironment('CODE_VERSION', defaultValue: '1.0.0'),
  //   handleUncaughtErrors: true,
  //   includePlatformLogs: true,
  // );

  // Run app with Rollbar
  // await RollbarFlutter.run(config, () {
  //   runApp(AppView(authBloc: authBloc));
  // });
  // no error tracking
  runApp(AppView(authBloc: authBloc));
}

class AppView extends StatelessWidget {
  final AuthHyBloc authBloc;
  const AppView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    // Proporcionar el authBloc globalmente
    return BlocProvider<AuthHyBloc>.value(
      value: authBloc,
      // Usar un Builder para obtener un context con acceso a AuthHyBloc
      child: Builder(
        builder: (context) {
           // Usar MaterialApp dentro del Builder
           return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: kPrimaryColor,
              primarySwatch: Palette.kToDark,
            ),
            // Usar BlocListener para navegación dinámica
            home: BlocListener<AuthHyBloc, AuthHyState>(
              // Añadir listenWhen para evitar bucles si la navegación causa reconstrucción
              listenWhen: (previous, current) => previous.isAuthenticated != current.isAuthenticated,
              listener: (context, state) {
                // Navega según el estado de autenticación
                if (state.isAuthenticated) {
                   // Solo navega si no estamos ya en RootScreen (o usa una forma más robusta de verificar)
                   // Usaremos pushNamedAndRemoveUntil para asegurar limpieza
                   Navigator.of(context).pushNamedAndRemoveUntil(RootScreen.ROUTE, (route) => false);
                } else {
                  // Si no está autenticado, siempre vamos a Login y eliminamos rutas anteriores.
                   Navigator.of(context).pushNamedAndRemoveUntil(LoginLayout.ROUTE, (route) => false);
                }
              },
              // El hijo inicial depende del estado inicial (similar a initialRoute)
              // Accede al estado usando context.watch o context.read si no necesitas reconstruir aquí
              child: context.watch<AuthHyBloc>().state.isAuthenticated 
                     ? const RootScreen() 
                     : const LoginLayout(),
            ),
            // Definir rutas para la navegación por nombre
            routes: {
              RootScreen.ROUTE: (context) => const RootScreen(),
              LoginLayout.ROUTE: (context) => const LoginLayout(),
            },
          );
        }
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  // @override
  // void onCreate(BlocBase bloc) {
  //   super.onCreate(bloc);
  //   print('onCreate -- ${bloc.runtimeType}\n\n');
  // }

  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   print('onChange -- ${bloc.runtimeType}, $change\n\n');
  // }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error\n\n');
    super.onError(bloc, error, stackTrace);
  }

  // @override
  // void onClose(BlocBase bloc) {
  //   super.onClose(bloc);
  //   print('onClose -- ${bloc.runtimeType}\n\n');
  // }
}
