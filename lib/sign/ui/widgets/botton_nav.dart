import 'package:flutter/material.dart';
import 'package:signclock/constant/theme.dart';

class Bnavigator extends StatefulWidget {
  final Function currentIndex;

  const Bnavigator({super.key, required this.currentIndex});

  @override
  State<Bnavigator> createState() => _BnavigatorState();
}

class _BnavigatorState extends State<Bnavigator> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.fingerprint),
          label: 'Fichar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist_rtl),
          label: 'Listado',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker_notes),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts),
          label: 'Configuración',
        ),
      ],
      currentIndex: _index,
      selectedItemColor: kPrimaryColor,
      onTap: (int i) {
        setState(() {
          _index = i;
          widget.currentIndex(i);
        });
      },
    );
  }
}
