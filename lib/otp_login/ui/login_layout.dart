import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signclock/model/phone_model.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/otp_login/ui/login_ui.dart';
import 'package:signclock/otp_login/ui/otp_ui.dart';

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

  void notifyChangeToOtpStep(String phoneNumberTemp) {
    setState(() {
      _isInLoginStep = false;
      _phoneNumberTemp = phoneNumberTemp;
    });
  }

  void notifySuccessLogin(PhoneModel phoneModelTemp, String? token) {
    if (mounted && !_authHyBloc.isClosed) {
        _authHyBloc.add(Authenticated(
          isAuthenticated: true, token: token, user: phoneModelTemp));
    } else {
       print("Condition failed (without delay): mounted=$mounted, isClosed=${_authHyBloc.isClosed}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isInLoginStep
          ? LoginUi(parentState: this)
          : OtpUi(
                parentState: this,
                phoneNumberTemp: _phoneNumberTemp,
              ),
    );
  }
}
