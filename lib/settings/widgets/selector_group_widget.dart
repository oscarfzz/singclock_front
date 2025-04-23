import 'package:flutter/material.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/model/group_model.dart';

class SelectorGroupWidget extends StatelessWidget {
  final GroupModel selectedGroup;
  final List<GroupModel> groupList;
  final Function(int) onGroupChanged;
  const SelectorGroupWidget({
    super.key,
    required this.selectedGroup,
    required this.groupList,
    required this.onGroupChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<GroupModel>(
      value: selectedGroup,
      items: groupList.map((groupDatum) {
        return DropdownMenuItem<GroupModel>(
          value: groupDatum,
          child: Text(groupDatum.groupName!),
        );
      }).toList(),
      onChanged: (newValue) {
        AuthHyBloc().add(AuthHyEvent.updateUser(
          groupId: newValue!.id,
          groupName: newValue.groupName,
          adminPhoneId: newValue.adminPhoneId,
          groupCheck: newValue.groupCheck,
          groupLat: newValue.groupLat,
          groupLon: newValue.groupLon,
        ));
        onGroupChanged(newValue.id);
      },
    );
  }
}
