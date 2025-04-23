import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/api_services/login_service.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/constant/assets.dart';
import 'package:signclock/constant/theme.dart';

// import 'package:signclock/otp_login/repository/auth_repo.dart' as authRepo;
import 'package:signclock/otp_login/ui/login_layout.dart';
import 'package:signclock/sign/ui/widgets/input_round_telephone.dart';
import 'package:signclock/widgets/backgroud_wd.dart';
import 'package:signclock/widgets/boton_redondeado.dart';

class LoginUi extends StatefulWidget {
  final LoginLayoutState parentState;

  const LoginUi({super.key, required this.parentState});

  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController phoneNumberController = TextEditingController();

  String parsableNumber = '0';

  bool _isWaiting = false;
  String? _errorMsg;

  late FocusNode phoneNumberFocus;

  late AuthHyBloc _authHyBloc;
  late LoginService _loginService;

  @override
  void initState() {
    phoneNumberFocus = FocusNode();
    super.initState();

    _authHyBloc = context.read<AuthHyBloc>();
    _loginService = LoginService(_authHyBloc);
  }

  void _startLoginProcess(String parsableNumber, int optCode) async {
    setState(() {
      _isWaiting = true;
    });

    // Map<String, dynamic> responseData =
    //     await authRepo.login(parsableNumber, optCode);
    var response = await _loginService.login(parsableNumber, optCode);
    if (response.status == 'success') {
      _responseOk(response.data!['phone_number']);
      return;
    }
    _responseKo(response.msg);
  }

  void _responseOk(String? phoneNumber) {
    Future.delayed(const Duration(seconds: 2), () {
      widget.parentState.notifyChangeToOtpStep(phoneNumber);
    });
  }

  void _responseKo(String msg) {
    setState(() {
      _isWaiting = false;
      _errorMsg = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final logo = Image.asset(
      Assets.logoRotoTopM,
      width: size.width * .75,
    );

    return BackgroundWg(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildTop(),
          logo,
          _buildMsg(),
          const Expanded(child: SizedBox()),
          _buildMyNum(),
          const SizedBox(
            height: 5.0,
          ),
          _buildPostMyNum(),
        ],
      ),
    );
  }

  Widget _buildMsg() {
    if (_isWaiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMsg != null) {
      return Text(_errorMsg!);
    }

    return Container();
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

  Widget _buildMyNum() {
    return InputRoundTelephone(
      key: const Key('loginForm_numTelInput_campoTextoRedondeado'),
      hintText: "Introduce tu número de teléfono",
      onChanged: (value) {
        parsableNumber = value.phoneNumber.toString();
      },
      onSaved: (value) {},
      focusNode: phoneNumberFocus,
      textInputType: TextInputType.phone,
      controller: phoneNumberController,
    );
  }

  Widget _buildPostMyNum() {
    return BotonRedondeado(
      key: const Key('loginForm_submit_botonRedondeado'),
      text: "Enviar",
      press: () {
        _startLoginProcess(parsableNumber, 1111);
      },
    );
  }
}
