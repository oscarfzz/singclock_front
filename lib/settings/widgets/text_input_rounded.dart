import 'package:flutter/material.dart';

class TextInputRounded extends StatelessWidget {
  final String hintText;
  final String? initValue;
  final TextEditingController _controller;

  const TextInputRounded({
    super.key,
    required this.hintText,
    required TextEditingController controller,
    this.initValue = '',
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(80),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0x77aaaaaa), blurRadius: 4, spreadRadius: 5),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: TextField(
            key: UniqueKey(),
            controller: _controller,
            keyboardType: TextInputType.number,
            maxLength: 40,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(80),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
