import 'package:flutter/material.dart';
import 'radio_tile_widget.dart';
import 'enum_day.dart'; // Asegúrate de importar tu enum DayType

class DayTypeWidget extends StatelessWidget {
  final DayType dayType;
  final ValueChanged<DayType?> onChanged;

  const DayTypeWidget({
    super.key,
    required this.dayType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text("Jornada",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        ),
        RadioTileWidget<DayType>(
          title: 'Tiempo parcial',
          value: DayType.parcial,
          groupValue: dayType,
          onChanged: onChanged,
        ),
        RadioTileWidget<DayType>(
          title: 'Tiempo completo',
          value: DayType.completa,
          groupValue: dayType,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
