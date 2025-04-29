import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:signclock/model/phone_model.dart';

part 'auth_hy_event.dart';
part 'auth_hy_state.dart';
part 'auth_hy_bloc.freezed.dart';

class AuthHyBloc extends HydratedBloc<AuthHyEvent, AuthHyState> {
  AuthHyBloc() : super(AuthHyState.initial()) {
    on<Authenticated>(_onAuthenticated);
    on<UserUpdated>(_onUserUpdated);
    on<Unauthenticated>(_onUnauthenticated);
  }

  void _onUnauthenticated(Unauthenticated event, Emitter<AuthHyState> emit) {
    emit(state.copyWith(
      isAuthenticated: false,
      user: null,
      token: null,
    ));
  }

  void _onAuthenticated(Authenticated event, Emitter<AuthHyState> emit) {
    emit(state.copyWith(
      isAuthenticated: event.isAuthenticated,
      user: event.user,
      token: event.token,
    ));
  }

  void _onUserUpdated(UserUpdated event, Emitter<AuthHyState> emit) {
    emit(state.copyWith(
      user: state.user?.copyWith(
        groupPhoneId: event.groupId,
        groupId: event.groupId,
        groupName: event.groupName,
        groupCheck: event.groupCheck,
        groupLat: event.groupLat,
        groupLon: event.groupLon,
        adminPhoneId: event.adminPhoneId,
        type: event.type,
        customCheck: event.customCheck,
        customCheckForm: event.customCheckForm,
        dayType: event.dayType,
        dayForm: event.dayForm,
        restPact: event.restPact,
        restMinutes: event.restMinutes,
        flex: event.flex,
        hoursWeek: event.hoursWeek,
        hoursYear: event.hoursYear,
        lastSign: event.lastSign,
      ),
      token: event.token ?? state.token,
    ));
  }

  @override
  AuthHyState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthHyState(
        isAuthenticated: json['isAuthenticated'] as bool,
        user: json['user'] != null
            ? PhoneModel.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        token: json['token'] as String?,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthHyState state) {
    return {
      'isAuthenticated': state.isAuthenticated,
      'user': state.user?.toJson(),
      'token': state.token,
    };
  }
}
