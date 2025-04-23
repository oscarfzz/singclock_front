import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signclock/model/phone_model.dart';
import 'package:signclock/blocs/app/app_state.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/otp_login/ui/login_ui.dart';
import 'package:signclock/otp_login/ui/otp_ui.dart';
import 'package:signclock/root_screen.dart';

class LoginLayout extends StatefulWidget {
  static const String ROUTE = 'ot_login_screen';

  const LoginLayout({super.key});

  @override
  State<StatefulWidget> createState() => LoginLayoutState();
}

class LoginLayoutState extends State<LoginLayout> {
  bool _isInLoginStep = true;
  String? _phoneNumberTemp;

  late AuthHyBloc _authHyBloc;

  @override
  void initState() {
    _authHyBloc = context.read<AuthHyBloc>();

    super.initState();
  }

  void notifyChangeToOtpStep(String? phoneNumberTemp) {
    setState(() {
      _isInLoginStep = false;
      _phoneNumberTemp = phoneNumberTemp;
    });
  }

  void notifySuccessLogin(PhoneModel phoneModelTemp, String token) {
    _authHyBloc.add(Authenticated(
        isAuthenticated: true, token: token, user: phoneModelTemp));

    // AppState().authenticate(TelInfoModel.fromJson(telInfoModelTemp));
    AppState().authenticate(phoneModelTemp, token);
    Navigator.pushNamed(context, RootScreen.ROUTE);
  }

  @override
  Widget build(Object context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthHyBloc>(
          create: (context) => _authHyBloc,
        )
      ],
      child: Scaffold(
        body: _isInLoginStep
            ? LoginUi(parentState: this)
            : OtpUi(
                parentState: this,
                phoneNumberTemp: _phoneNumberTemp!,
              ),
      ),
    );
  }

  @override
  void dispose() {
    _authHyBloc.close();
    super.dispose();
  }
}
