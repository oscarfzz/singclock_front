part of 'auth_hy_bloc.dart';

@freezed
class AuthHyEvent with _$AuthHyEvent {
  const factory AuthHyEvent.authenticate({
    PhoneModel? user,
    String? token,
    required bool isAuthenticated,
  }) = Authenticated;

  const factory AuthHyEvent.appStateChanged(AppState newState) =
      _AppStateChanged;

  const factory AuthHyEvent.updateUser({
    int? adminPhoneId,
    int? groupId,
    String? groupName,
    String? groupCheck,
    double? groupLat,
    double? groupLon,
    String? type,
    bool? customCheck,
    String? customCheckForm,
    String? dayType,
    String? dayForm,
    bool? restPact,
    int? restMinutes,
    bool? flex,
    double? hoursWeek,
    double? hoursYear,
    String? lastSign,
    String? token,
  }) = UserUpdated;

  const factory AuthHyEvent.unauthenticate() = Unauthenticated;
}
