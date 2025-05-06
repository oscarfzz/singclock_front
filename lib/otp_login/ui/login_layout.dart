import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:signclock/models/phone_model.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/otp_login/ui/login_ui.dart';
import 'package:signclock/otp_login/ui/otp_ui.dart';
import 'package:signclock/root_screen.dart';

class LoginLayout extends StatefulWidget {
  static const String route = 'ot_login_screen';

  const LoginLayout({super.key});

  @override
  State<StatefulWidget> createState() => LoginLayoutState();
}

class LoginLayoutState extends State<LoginLayout> {
  bool _isInLoginStep = true;
  String? _phoneNumberTemp;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _checkAuthBloc();
  }

  void _checkAuthBloc() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      try {
        final authBloc = context.read<AuthHyBloc>();
        if (authBloc.isClosed) {
          if (kDebugMode) {
            print('LoginLayout: ADVERTENCIA - AuthHyBloc está cerrado');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('LoginLayout: Error al acceder a AuthHyBloc: $e');
        }
      }
    });
  }

  void notifyChangeToOtpStep(String phoneNumberTemp) {
    setState(() {
      _isInLoginStep = false;
      _phoneNumberTemp = phoneNumberTemp;
    });
  }

  void notifySuccessLogin(PhoneModel phoneModelTemp, String? token) {
    if (_isAuthenticating) return;
    if (token == null || token.isEmpty) {
      _showErrorAndReset("Error de autenticación: Token inválido");
      return;
    }

    setState(() => _isAuthenticating = true);

    _processAuthentication(phoneModelTemp, token);
  }

  void _processAuthentication(PhoneModel phoneModel, String token) {
    if (!mounted) return;

    try {
      final authBloc = BlocProvider.of<AuthHyBloc>(context);

      if (authBloc.isClosed) {
        _handleClosedBloc();
        return;
      }

      authBloc.add(const Unauthenticated());
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;
        authBloc.add(Authenticated(
            isAuthenticated: true, token: token, user: phoneModel));
        _verifyAuthenticationResult(authBloc);
      });
    } catch (e) {
      _showErrorAndReset("Error de autenticación: $e");
    }
  }

  void _verifyAuthenticationResult(AuthHyBloc authBloc) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      final currentState = authBloc.state;

      if (currentState.isAuthenticated &&
          currentState.user != null &&
          currentState.token != null) {
        _navigateToMainScreen();
      } else {
        // Autenticación fallida
        _showErrorAndReset(
            "La autenticación falló. Por favor, intenta nuevamente.");
      }

      // Restablecer estado
      if (mounted) {
        setState(() => _isAuthenticating = false);
      }
    });
  }

  void _handleClosedBloc() {
    Future.microtask(() {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(LoginLayout.route);
    });

    setState(() => _isAuthenticating = false);
  }

  void _navigateToMainScreen() {
    Future.microtask(() {
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        RootScreen.route,
        (route) => false,
      );
    });
  }

  void _showErrorAndReset(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      setState(() {
        _isInLoginStep = true;
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isAuthenticating) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Iniciando sesión...'),
          ],
        ),
      );
    }

    return _isInLoginStep
        ? LoginUi(parentState: this)
        : OtpUi(
            parentState: this,
            phoneNumberTemp: _phoneNumberTemp,
          );
  }
}
