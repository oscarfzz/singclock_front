import 'package:flutter/material.dart';
import 'package:signclock/model/regfi_model.dart';
import 'listado_item_widget.dart';

class ListadoListWidget extends StatelessWidget {
  final ScrollController listScrollController = ScrollController();
  final List<RegFiModel> _registros;

  ListadoListWidget(this._registros, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _registros.length,
      itemBuilder: (context, index) => ListadoItemWidget(_registros[index]),
      reverse: true, // OJO
      controller: listScrollController,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
