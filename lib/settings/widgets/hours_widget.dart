import 'package:flutter/material.dart';
import 'package:signclock/settings/widgets/text_input_rounded.dart';

class HoursWidget extends StatelessWidget {
  final TextEditingController hoursWeekCtr;
  final TextEditingController hoursYearCtr;
  const HoursWidget({
    super.key,
    required this.hoursWeekCtr,
    required this.hoursYearCtr,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextInputRounded(
          hintText: "Horas semanales",
          controller: hoursWeekCtr,
        ),
        const SizedBox(height: 16),
        TextInputRounded(
          hintText: "Horas anuales",
          controller: hoursYearCtr,
        ),
      ],
    );
  }
}
