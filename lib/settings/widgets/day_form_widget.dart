import 'package:flutter/material.dart';
import 'package:signclock/settings/widgets/enum_day.dart';
import 'package:signclock/settings/widgets/radio_tile_widget.dart';

class DayFormWidget extends StatelessWidget {
  final DayForm dayForm;
  final ValueChanged<DayForm?> onChanged;

  const DayFormWidget(
      {super.key, required this.dayForm, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioTileWidget<DayForm>(
          title: 'Jornada continua',
          value: DayForm.continua,
          groupValue: dayForm,
          onChanged: onChanged,
        ),
        RadioTileWidget<DayForm>(
          title: 'Jornada partida',
          value: DayForm.partida,
          groupValue: dayForm,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
