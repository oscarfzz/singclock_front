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
  String? _tokenTemp;

  late AuthHyBloc _authHyBloc;

  @override
  void initState() {
    _authHyBloc = context.read<AuthHyBloc>();

    super.initState();
  }

  void notifyChangeToOtpStep(String? phoneNumberTemp, String? tokenTemp) {
    setState(() {
      _isInLoginStep = false;
      _phoneNumberTemp = phoneNumberTemp;
      _tokenTemp = tokenTemp;
    });
  }

  void notifySuccessLogin(PhoneModel phoneModelTemp, String? token) {
    _authHyBloc.add(Authenticated(
        isAuthenticated: true, token: token, user: phoneModelTemp));
    AppState().authenticate(phoneModelTemp, token);
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      body: _isInLoginStep
          ? LoginUi(parentState: this)
          : OtpUi(
                parentState: this,
                phoneNumberTemp: _phoneNumberTemp,
                tokenTemp: _tokenTemp,
              ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
