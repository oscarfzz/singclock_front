// file: settings_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signclock/api_services/settings_service.dart';

import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/model/phone_model.dart';
import 'package:signclock/model/group_model.dart';

import 'package:signclock/settings/widgets/selector_group_widget.dart';
import 'package:signclock/settings/widgets/top_screen_stt.dart';

import './widgets/enum_day.dart';
import 'package:signclock/services/logout_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AuthHyBloc _authHyBloc;
  late SettingsService _settingsService;

  PhoneModel? _user;

  DayType _dayType = DayType.completa;
  DayForm _dayForm = DayForm.continua;

  final TextEditingController restMinutesCtr = TextEditingController();
  final TextEditingController hoursWeekCtr = TextEditingController();
  final TextEditingController hoursYearCtr = TextEditingController();

  bool _restPact = false;
  bool _admin = false;
  bool _edit = true;
  bool _isLoadingGroups = true;

  List<GroupModel> _groupList = [];
  GroupModel? _selectedGroup;

  @override
  void initState() {
    super.initState();

    _authHyBloc = context.read<AuthHyBloc>();
    _settingsService = SettingsService(_authHyBloc);
    // _user = _authHyBloc.state.user;
    if (kDebugMode) {
      print("User: $_user");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_authHyBloc.state.user != null) {
        _loadData();
      } else {
        _showSnackBar("Usuario no disponible");
      }
    });
  }

  @override
  void dispose() {
    restMinutesCtr.dispose();
    hoursWeekCtr.dispose();
    hoursYearCtr.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final currentUser = _authHyBloc.state.user;
    if (currentUser == null) {
      _showSnackBar('Usuario no disponible');
      return;
    }

    setState(() => _isLoadingGroups = true);
    try {
      final groupList = await _settingsService.getGroupsList(_user!.phoneId);

      if (groupList.status == "error") {
        _showSnackBar('Error al cargar datos e-1');
        return;
      }

      setState(() {
        _groupList = groupList.data ?? [];
        if (_groupList.isNotEmpty && _groupList.first.id != 1) {
          _setGroupData(_user!.groupId);
        }
      });
    } finally {
      setState(() => _isLoadingGroups = false);
    }
  }

  void _setGroupData(int? groupId) {
    if (groupId == null) return;

    final group = _groupList.firstWhere((g) => g.id == groupId);
    setState(() {
      _selectedGroup = group;
      hoursWeekCtr.text = group.hoursWeek.toString();
      hoursYearCtr.text = group.hoursYear.toString();
      restMinutesCtr.text = group.restMinutes.toString();
      _restPact = group.restPact ?? false;
      _admin = group.adminPhoneId == _user?.phoneId;
      _edit = _user?.lastSign == "S";
      _dayType = group.dayType == "P" ? DayType.parcial : DayType.completa;
      _dayForm = group.dayForm == "P" ? DayForm.partida : DayForm.continua;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthHyBloc, AuthHyState>(
        builder: (context, state) {
          final user = state.user;
          return Column(
            children: [
              const Expanded(flex: 1, child: TopScreenStt()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 27.0),
                    child: Column(
                      children: [
                        _isLoadingGroups
                            ? _buildLoadingIndicator()
                            : (_groupList.isEmpty)
                                ? _buildNoCompanyMessage()
                                : _buildForm(),
                        const SizedBox(height: 20),
                        StaticInfoWidget(user: user),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildNoCompanyMessage() {
    return Center(
      child: Text(
        'Sin datos',
        style:
            Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildInfo(),
        if (_selectedGroup != null)
          SelectorGroupWidget(
            selectedGroup: _selectedGroup!,
            groupList: _groupList,
            onGroupChanged: (groupId) => _edit ? _setGroupData(groupId) : null,
          ),
        if (_admin) _buildGeoVallaButton(),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
        Text(
          _user!.userName,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          _user!.phoneNumber,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              fontSize: 24.0),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Column(
      children: [
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _edit ? _updateGroup : null,
          style: ElevatedButton.styleFrom(
            foregroundColor:
                _edit ? Theme.of(context).primaryColor : Colors.grey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Guardar'),
              if (!_edit) const Icon(Icons.warning, color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGeoVallaButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_selectedGroup != null &&
            _selectedGroup!.groupPhoneId != null &&
            _selectedGroup!.groupLat != null &&
            _selectedGroup!.groupLon != null) {
          final response = await _settingsService.setGeoFence(
            _selectedGroup!.groupPhoneId!,
            _selectedGroup!.groupLat!,
            _selectedGroup!.groupLon!,
            100,
          );
          _showSnackBar(response.status == "success"
              ? 'Geovalla establecida'
              : 'Error al establecer geovalla');
        } else {
          _showSnackBar('Grupo no disponible');
        }
      },
      child: const Text('Establecer GeoValla'),
    );
  }

  Future<void> _updateGroup() async {
    if (_selectedGroup != null) {
      setState(() => _isLoadingGroups = true);

      final group = _selectedGroup!.copyWith(
        dayType: _dayType == DayType.parcial ? "P" : "C",
        dayForm: _dayForm == DayForm.partida ? "P" : "C",
        restPact: _restPact,
        restMinutes: int.tryParse(restMinutesCtr.text) ?? 0,
        hoursWeek: int.tryParse(hoursWeekCtr.text) ?? 0,
        hoursYear: int.tryParse(hoursYearCtr.text) ?? 0,
      );

      final response = await _settingsService.updateGroup(
          group, _selectedGroup!.groupPhoneId!);
      _showSnackBar(response.status == "success"
          ? 'Grupo actualizado'
          : 'Error al actualizar el grupo');

      setState(() => _isLoadingGroups = false);
      if (response.status == "success") _loadData();
    } else {
      _showSnackBar('Grupo no válido');
    }
  }
}

class StaticInfoWidget extends StatelessWidget {
  final PhoneModel? user;

  const StaticInfoWidget({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Información de la Aplicación",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("- Versión: 1.0.0"),
          const Text("- Desarrollador: SignClock"),
          const Text("- Última actualización: Enero 2025"),
          const Text("- Contacto: soporte@signclock.com"),
          const SizedBox(height: 8.0),
          if (user != null) ...[
            Text("- Nombre: ${user?.userName ?? 'N/A'}"),
            Text("- Teléfono: ${user?.phoneNumber ?? 'N/A'}"),
            Text("- Último registro: ${user?.lastSign ?? 'N/A'}"),
            Text("- Grupo: ${user?.groupId ?? 'N/A'}"),
          ] else
            const Text("- Usuario no disponible"),
          const SizedBox(height: 20.0),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                LogoutService.showLogoutConfirmationDialog(context);
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
