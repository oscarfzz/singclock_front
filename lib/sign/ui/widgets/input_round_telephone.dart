import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InputRoundTelephone extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final ValueChanged<PhoneNumber> onChanged;
  final FormFieldSetter<PhoneNumber> onSaved;
  //final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextAlignVertical textAlignVertical;

  const InputRoundTelephone({
    super.key,
    required this.hintText,
    this.icon = Icons.tty,
    this.textInputType = TextInputType.number,
    required this.controller,
    required this.onChanged,
    required this.onSaved,
    required this.focusNode,
    this.textAlignVertical = TextAlignVertical.center,
  });

  @override
  Widget build(BuildContext context) {
    //String initialCountry = 'ES';
    PhoneNumber number = PhoneNumber(isoCode: 'ES');
    return CampoTexto(
      child: InternationalPhoneNumberInput(
        onInputChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: (value) => print(value),
        onInputValidated: (bool value) {
          print(value);
        },
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.bottom,
        inputDecoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          fillColor: Colors.white,
          filled: true,
          hoverColor: Colors.white,
        ),
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: true,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: const TextStyle(color: Colors.white),
        spaceBetweenSelectorAndTextField: 0,
        initialValue: number,
        textFieldController: controller,
        textAlign: TextAlign.center,
        formatInput: false,
        keyboardType: const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputBorder: const OutlineInputBorder(),
      ),
    );
  }
}

class CampoTexto extends StatelessWidget {
  final Widget child;
  const CampoTexto({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 0,
      ),
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 0,
        right: 0,
        bottom: 0,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black),
      ),
      child: child,
    );
  }
}
