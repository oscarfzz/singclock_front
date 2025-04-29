import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:signclock/constant/theme.dart';

import 'package:signclock/nav_bar/navigation_cubit.dart';
import 'package:signclock/settings/settings_page.dart';
import 'package:signclock/sign/ui/sign_page.dart';

import 'package:signclock/listado/ui/listado_view.dart';
import 'package:signclock/otp_login/ui/login_layout.dart';

import 'blocs/auth_hydrated/auth_hy_bloc.dart';
import 'chats/ui/chat_list_screen.dart';

class RootScreen extends StatefulWidget {
  static const String route = 'root_screen';

  const RootScreen({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: RootScreen());

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late NavigationCubit _navigationCubit;
  bool _isProcessingNavigation = false;

  @override
  void initState() {
    super.initState();
    _navigationCubit = NavigationCubit();
  }

  @override
  void dispose() {
    _navigationCubit.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyAuthentication(forceVerify: false);
    });
  }

  void _verifyAuthentication({bool forceVerify = false}) {
    if (!mounted || _isProcessingNavigation) return;

    try {
      final authBloc = context.read<AuthHyBloc>();
      final currentState = authBloc.state;

      final bool stateValid = currentState.isAuthenticated &&
          currentState.user != null &&
          currentState.token != null;

      if (!stateValid) {
        if (forceVerify ||
            !currentState.isAuthenticated ||
            currentState.user == null) {
          _isProcessingNavigation = true;

          Future.microtask(() {
            if (!mounted) {
              _isProcessingNavigation = false;
              return;
            }

            Navigator.of(context)
                .pushNamedAndRemoveUntil(
              LoginLayout.route,
              (route) => false,
            )
                .then((_) {
              _isProcessingNavigation = false;
            });
          });
        }
      } else if (forceVerify) {
        _navigationCubit.navigateTo(0, SignPage());
      }
    } catch (e) {
      _isProcessingNavigation = false;
      if (kDebugMode) {
        print("RootScreen: Error al verificar autenticación: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentAuthBloc = context.read<AuthHyBloc>();

    return BlocListener<AuthHyBloc, AuthHyState>(
      listener: (context, state) {
        if (!_isProcessingNavigation &&
            (!state.isAuthenticated || state.user == null)) {
          if (kDebugMode) {
            print(
                "RootScreen: Cambio en estado de autenticación detectado - isAuthenticated=${state.isAuthenticated}, hasUser=${state.user != null}");
          }

          _isProcessingNavigation = true;

          Future.microtask(() {
            if (mounted) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                LoginLayout.route,
                (route) => false,
              )
                  .then((_) {
                _isProcessingNavigation = false;
              });
            } else {
              _isProcessingNavigation = false;
            }
          });
        }
      },
      child: BlocProvider<NavigationCubit>.value(
        value: _navigationCubit,
        child: BlocProvider<AuthHyBloc>.value(
          value: currentAuthBloc,
          child: Builder(builder: (innerContext) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _verifyAuthentication(forceVerify: true);
            });

            return Scaffold(
              appBar: AppBar(
                title: BlocBuilder<AuthHyBloc, AuthHyState>(
                  builder: (context, state) {
                    final username = state.user?.phoneNumber ?? 'SignClock';
                    return Text('Bienvenido, $username');
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => _verifyAuthentication(forceVerify: true),
                  ),
                ],
              ),
              bottomNavigationBar:
                  BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  return BottomNavigationBar(
                    currentIndex: state.index,
                    showUnselectedLabels: true,
                    backgroundColor: kPrimaryLightColor,
                    fixedColor: kPrimaryColor,
                    unselectedItemColor: Colors.grey,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.fingerprint),
                        label: 'Fichar',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.checklist_rtl),
                        label: 'Listado',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.speaker_notes),
                        label: 'Chat',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.manage_accounts),
                        label: 'Configuración',
                      ),
                    ],
                    onTap: (index) {
                      switch (index) {
                        case 0:
                          _navigationCubit.navigateTo(0, SignPage());
                          break;
                        case 1:
                          _navigationCubit.navigateTo(1, const ListadoView());
                          break;
                        case 2:
                          _navigationCubit.navigateTo(
                              2, const ChatListScreen());
                          break;
                        case 3:
                          _navigationCubit.navigateTo(3, const SettingsPage());
                          break;
                      }
                    },
                  );
                },
              ),
              body: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  return state.body;
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
