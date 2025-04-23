import 'package:flutter/material.dart';
import 'package:signclock/constant/theme.dart';
import 'package:signclock/model/regfi_model.dart';

// ignore: must_be_immutable
class ListadoItemWidget extends StatelessWidget {
  //var index = 0;
  final RegFiModel _unRegistro;

  const ListadoItemWidget(this._unRegistro, {super.key});

  @override
  Widget build(BuildContext context) {
    late String timer = "";

    if (_unRegistro.elapsedTime != "") {
      List<String> timeParts = _unRegistro.elapsedTime.split(":");
      String hours = timeParts[0];
      String minutes = timeParts[1];

      timer = "$hours:$minutes";

      //DateTime _dateTime = DateTime(0, 1, 1, horas, minutos, 0);
      //convert string of time, to DateTime and take onli hour and minutes
    }

    List<String> partesHora = ["", ""];
    if (_unRegistro.currenttime != "") {
      partesHora = _unRegistro.currenttime.split(':');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: _iconEstado(),
        ),
        title: Text(
          "${partesHora[0]}:${partesHora[1]}",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
            "${_unRegistro.currentdate.year}-${_unRegistro.currentdate.month}-${_unRegistro.currentdate.day}"),
        trailing: Text(
          _unRegistro.type != "E"
              //? "${partesTiempo[0]}:${partesTiempo[1]}"
              ? timer
              : "",
          style: const TextStyle(
              color: Colors.red, fontSize: 12.00, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _iconEstado() {
    IconData icono = Icons.logout;
    if (_unRegistro.type == "E") {
      icono = Icons.where_to_vote;
    }
    if (_unRegistro.type == "DE") {
      icono = Icons.keyboard_return;
    }
    if (_unRegistro.type == "DS") {
      icono = Icons.local_cafe;
    }
    return Icon(icono, color: Colors.white);
  }
}
