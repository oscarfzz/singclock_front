import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:signclock/chats/ui/chat_list_screen.dart';
import 'package:signclock/constant/theme.dart';
import 'package:signclock/models/phone_model.dart';
import 'package:signclock/models/api_response_model.dart';

import 'package:signclock/api_services/chat_service.dart';

import '../../blocs/auth_hydrated/auth_hy_bloc.dart';
import '../../nav_bar/navigation_cubit.dart';
import '../../sign/ui/widgets/input_round_telephone.dart';
import '../../widgets/header_logo_title_layout.dart';
import '../model/chat_model.dart';

class AddChat extends StatefulWidget {
  const AddChat({super.key});

  @override
  State<StatefulWidget> createState() => AddChatState();
}

class AddChatState extends State<AddChat> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Contact? _contact;
  String? parsableNumber;

  void _createChat() async {
    try {
      final params = _validateParams();

      final authBloc = BlocProvider.of<AuthHyBloc>(context);
      final chatService = ChatService(authBloc);

      final ChatModel chat = await _createGroup(
          chatService, authBloc.state.user!.phoneId, params.$1);

      await _addUserToGroup(
          chatService, chat.chatId, params.$2, authBloc.state.user!);
    } catch (ex) {
      return;
    }

    if (!mounted) return;

    // Reemplazar la navegación de esta pantalla por la de edición de integrantes del grupo
    BlocProvider.of<NavigationCubit>(context)
        .navigateTo(2, const ChatListScreen());
  }

  (String, String) _validateParams() {
    String? name = _validateName();

    if (name == null) {
      _showErrorMessage(
          'El nombre del empleado debe tener más de dos caracteres.');
      throw Exception();
    }

    String? phone = _validatePhone();

    if (phone == null) {
      _showErrorMessage('El teléfono del empleado debe ser válido.');
      throw Exception();
    }

    return (name, phone);
  }

  Future<ChatModel> _createGroup(
      ChatService chatService, int phoneId, String chatName) async {
    late ApiResponseModel<ChatModel?> response;

    try {
      response = await chatService.createChat(phoneId, chatName);
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      _showErrorMessage(
          'Error inesperado, disculpe las molestias (cc). ${ex.toString()}');
      throw Exception();
    }

    if (response.status != 'success') {
      _showErrorMessage(response.msg);
      throw Exception();
    }

    return response.data!;
  }

  Future<void> _addUserToGroup(
    ChatService chatService,
    int chatId,
    String addPhoneNumber,
    PhoneModel user,
  ) async {
    ApiResponseModel<ChatModel?> response;
    try {
      response = await chatService.addUserToChat(chatId, addPhoneNumber, user);
      // response = await ChatRepository()
      //     .addUserToChat(chatId, addPhoneNumber, user, token);
    } catch (ex) {
      _showErrorMessage('Error inesperado, disculpe las molestias. (autg)');
      if (kDebugMode) {
        print(ex.toString());
      }
      throw Exception();
    }

    if (response.status != "success") {
      _showErrorMessage(response.msg);
      throw Exception();
    }
  }

  void _selectContact() async {
    if (!await FlutterContacts.requestPermission()) {
      return;
    }

    Contact? contact;

    try {
      contact = await FlutterContacts.openExternalPick();
    } catch (ex) {
      if (kDebugMode) {
        print('No se han obtenido permisos para leer contactos');
      }
    }

    setState(() {
      _contact = contact;
      _nameController.text = _contact?.displayName ?? '';
      _phoneController.text = _contact!.phones[0].number;
    });
  }

  String? _validateName() {
    String chatName = _nameController.text;
    chatName = chatName.trim();
    return (chatName.length < 3) ? null : chatName;
  }

  String? _validatePhone() {
    String phoneNumber = _phoneController.text;

    // quitar espacios
    phoneNumber = phoneNumber.replaceAll(' ', '');
    phoneNumber = phoneNumber.trim(); //??

    return (phoneNumber.length < 6) ? null : phoneNumber;
  }

  void _showErrorMessage(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final double elementsWidthSize = MediaQuery.of(context).size.width * 0.9;

    return HeaderLogoTitleLayout(
        title: 'Añadir empleado',
        child: Column(
          children: [
            ..._buildAddContactBtn(elementsWidthSize),
            ..._buildTextFiled(
              controller: _nameController,
              title: 'Nombre',
              hint: 'Nombre del empleado',
              elementsWidthSize: elementsWidthSize,
            ),
            ..._buildAddTelephoneField(
              controller: _phoneController,
              title: 'Teléfono',
              hint: 'Teléfono del empleado',
              elementsWidthSize: elementsWidthSize,
              formKey: formKey,
              enabled: false,
            ),
            _buildWhiteSpace(),
            _buildSaveButton(elementsWidthSize, formKey),
          ],
        ));
  }

  List<Widget> _buildTextFiled(
      {required TextEditingController controller,
      required String title,
      required String hint,
      required double elementsWidthSize,
      bool enabled = true}) {
    return [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      SizedBox(
        width: elementsWidthSize,
        child: TextField(
          controller: controller,
          enabled: enabled,
          cursorColor: kPrimaryColor,
          style: const TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.all(10),
            filled: true,
            fillColor: const Color.fromARGB(255, 241, 241, 241),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildAddTelephoneField(
      {required TextEditingController controller,
      required String title,
      required String hint,
      required double elementsWidthSize,
      required GlobalKey<FormState> formKey,
      bool enabled = true}) {
    FocusNode myNumFocus = FocusNode();
    return [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      SizedBox(
          width: elementsWidthSize,
          height: 55,
          child: Form(
            key: formKey,
            child: InputRoundTelephone(
              key: const Key('addChatForm_numTelInput_campoTextoRedondeado'),
              hintText: hint,
              onChanged: (value) {
                return;
              },
              onSaved: (value) {
                parsableNumber = value!.phoneNumber.toString();
                setState(() {
                  _phoneController.text = parsableNumber!;
                });
              },
              focusNode: myNumFocus,
              textInputType: TextInputType.phone,
              textAlignVertical: TextAlignVertical.bottom,
              controller: controller,
            ),
          )),
    ];
  }

  List<Widget> _buildAddContactBtn(double elementsWidthSize) {
    return [
      const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Contacto de la agenda',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      SizedBox(
        width: elementsWidthSize,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color.fromARGB(255, 176, 220, 252),
            foregroundColor: const Color.fromARGB(255, 84, 84, 84),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 76, 178, 250),
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: const Text(
            'Seleccionar contacto',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            _selectContact();
          },
        ),
      ),
    ];
  }

  Widget _buildWhiteSpace() {
    return const Expanded(
      child: SizedBox(),
    );
  }

  Widget _buildSaveButton(
      double elementsWidthSize, GlobalKey<FormState> formKey) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 20),
      child: SizedBox(
        width: elementsWidthSize,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(
                color: kPrimaryColor,
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
          onPressed: () {
            formKey.currentState!.save();
            // formKey.currentState!.validate() == false
            //     ? null
            //     : _contact != null
            //         ? _createChat()
            //         : null;
            _contact != null ? _createChat() : null;
          },
          child: const Text(
            'Guardar',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
