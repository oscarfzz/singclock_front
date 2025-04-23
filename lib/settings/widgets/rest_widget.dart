import 'package:flutter/material.dart';
import 'package:signclock/settings/widgets/text_input_rounded.dart';

class RestWidget extends StatelessWidget {
  final bool restPact;
  final TextEditingController restMinutesCtr;
  final ValueChanged<bool?> onChanged;

  const RestWidget({
    super.key,
    required this.restPact,
    required this.restMinutesCtr,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text("Descansos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        ),
        ListTile(
          title: const Text("Descansos como trabajo efectivo"),
          leading: Checkbox(
            value: restPact,
            onChanged: onChanged,
          ),
        ),
        TextInputRounded(
          hintText: "Minutos de descanso",
          controller: restMinutesCtr,
        ),
      ],
    );
  }
}
