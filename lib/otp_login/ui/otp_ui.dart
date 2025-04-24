import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:signclock/api_services/login_service.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/constant/assets.dart';

import 'package:signclock/constant/theme.dart';
import 'package:signclock/model/phone_model.dart';
// import 'package:signclock/otp_login/repository/auth_repo.dart' as authRepo;
import 'package:signclock/otp_login/ui/login_layout.dart';
import 'package:signclock/widgets/boton_redondeado.dart';
import 'package:signclock/widgets/backgroud_wd.dart';

class OtpUi extends StatefulWidget {
  final LoginLayoutState parentState;
  final String? phoneNumberTemp;
  final String? tokenTemp;

  // final String myToken;

  OtpUi({
    super.key,
    required this.parentState,
    required this.phoneNumberTemp,
    this.tokenTemp,
  });

  @override
  _OtpUiState createState() => _OtpUiState();
}

class _OtpUiState extends State<OtpUi> {
  TextEditingController phoneCodeController = TextEditingController();

  late AuthHyBloc _authHyBloc;
  late LoginService _loginService;

  @override
  void initState() {
    _authHyBloc = context.read<AuthHyBloc>();
    _loginService = LoginService(_authHyBloc);

    super.initState();
  }

  void _startSubmit() async {
    if (widget.phoneNumberTemp == null) {
      _responseKo("Error: Número de teléfono no disponible.");
      return;
    }

    String phoneCodeOtp = phoneCodeController.text.toString();

    try {
      // responseData puede ser Map o null ¿como lo manejo?
      // Map<String, dynamic> responseData =
      //     await authRepo.otp(widget.phoneNumberTemp, phoneCodeOtp);
      final response =
          await _loginService.otp(widget.phoneNumberTemp!, phoneCodeOtp);

      if (response.status == "success") {
        // Pasa el token recibido de la etapa anterior (Login), no el de la respuesta OTP (que es null)
        // _responseOk(PhoneModel.fromJson(response.data!), response.token); // Original
        _responseOk(PhoneModel.fromJson(response.data!), widget.tokenTemp);
        return;
      }

      _responseKo(response.msg);
    } catch (e) {
      _responseKo(e.toString());
    }
  }

  void _responseOk(PhoneModel data, String? token) {
    widget.parentState.notifySuccessLogin(data, token);
  }

  void _responseKo(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.phoneNumberTemp == null) {
      return const Scaffold(
        body: Center(
          child: Text("Error: No se recibió el número de teléfono."),
        ),
      );
    }

    Size size = MediaQuery.of(context).size;

    final logo = Image.asset(
      Assets.logoRotoTopM,
      width: size.width * .75,
    );

    final sendOTP = BotonRedondeado(
      //widget ElevatedButton
      key: const Key('LoginForm_btnCode'),
      text: "Registrarme",
      press: () {
        _startSubmit();
      },
    );

    return Scaffold(
      body: BackgroundWg(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildTop(),
            logo,
            const Expanded(child: SizedBox()),
            _buildMyCode(),
            const SizedBox(
              height: 5.0,
            ),
            sendOTP,
          ],
        ),
      ),
    );
  }

  Row _buildTop() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.phone_outlined,
          color: kPrimaryColor,
          size: 35.0,
          semanticLabel: 'Reloj',
        ),
        SizedBox(
          width: 30.0,
        ),
        Text(
          '···',
          style: TextStyle(
            fontSize: 40,
            color: Colors.black45,
          ),
        ),
        SizedBox(
          width: 30.0,
        ),
        Icon(
          Icons.tag,
          color: Colors.black45,
          size: 35.0,
        ),
        SizedBox(
          width: 30.0,
        ),
        Text(
          '···',
          style: TextStyle(fontSize: 40, color: Colors.black45),
        ),
        SizedBox(
          width: 30.0,
        ),
        Icon(
          Icons.settings_outlined,
          color: Colors.black45,
          size: 35.0,
        ),
      ],
    );
  }

  Widget _buildMyCode() {
    return PinCodeTextField(
      appContext: context,
      controller: phoneCodeController,
      pastedTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      length: 4,
      animationType: AnimationType.fade,
      enableActiveFill: true,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        fieldHeight: 50,
        fieldWidth: 40,
        inactiveColor: Colors.black,
        activeColor: Colors.black,
        selectedColor: Colors.white,
        selectedFillColor: Colors.black12,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      onCompleted: (value) {},
      onChanged: (value) {
        //parsableCode = value.toString();
      },
      validator: (v) {
        if (v!.length < 3) {
          return "validando...";
        } else {
          return null;
        }
      },
      beforeTextPaste: (text) {
        return true;
      },
    );
  }
}
