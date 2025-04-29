import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/constant/theme.dart';

import 'package:signclock/nav_bar/navigation_cubit.dart';
import 'package:signclock/settings/settings_page.dart';
import 'package:signclock/sign/ui/sign_page.dart';

import 'package:signclock/listado/ui/listado_view.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // convert to multi bloc provider
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<AuthHyBloc>(
          create: (context) => context.read<AuthHyBloc>(),
        ),
      ],
      child: Scaffold(
        //appBar: AppBar(),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.index,
              showUnselectedLabels: true,
              //unselectedLabelStyle: const TextStyle(color: kPrimaryLightColor, fontSize: 14),
              backgroundColor: kPrimaryLightColor,
              fixedColor: kPrimaryColor,
              unselectedItemColor: kPrimaryLightColor,
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
                    BlocProvider.of<NavigationCubit>(context)
                        .navigateTo(0, SignPage());
                    break;
                  case 1:
                    BlocProvider.of<NavigationCubit>(context)
                        .navigateTo(1, const ListadoView());
                    break;
                  case 2:
                    BlocProvider.of<NavigationCubit>(context)
                        .navigateTo(2, const ChatListScreen());
                    break;
                  case 3:
                    BlocProvider.of<NavigationCubit>(context)
                        .navigateTo(3, const SettingsPage());
                    break;
                }
              },
            );
          },
        ),
        body: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
          return state.body;
        }),
      ),
    );
  }
}
