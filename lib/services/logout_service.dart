import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/otp_login/ui/login_layout.dart';

class LogoutService {
  static Future<void> logout(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthHyBloc>(context);
    final navigator = Navigator.of(context);
    final isContextMounted = context.mounted;

    if (!authBloc.isClosed) {
      authBloc.add(const Unauthenticated());
      await Future.delayed(const Duration(milliseconds: 300));

      if (authBloc.state.isAuthenticated ||
          authBloc.state.user != null ||
          authBloc.state.token != null) {
        authBloc.add(const Unauthenticated());
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }

    await _clearStorage();
    await Future.delayed(const Duration(milliseconds: 300));

    if (isContextMounted && navigator.mounted) {
      navigator.pushNamedAndRemoveUntil(
        LoginLayout.route,
        (route) => false,
      );
    }
  }

  static Future<void> _clearStorage() async {
    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        await HydratedBloc.storage.delete('auth_hydrated_bloc');
        await HydratedBloc.storage.clear();
        return;
      } catch (_) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
  }

  static void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro que deseas cerrar la sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _showLoadingAndLogout(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  static void _showLoadingAndLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    logout(context).catchError((error) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cerrar sesión: $error')),
        );
      }
    });
  }
}
