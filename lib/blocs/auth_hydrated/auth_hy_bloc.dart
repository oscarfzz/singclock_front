import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:signclock/models/phone_model.dart';

part 'auth_hy_event.dart';
part 'auth_hy_state.dart';
part 'auth_hy_bloc.freezed.dart';

class AuthHyBloc extends HydratedBloc<AuthHyEvent, AuthHyState> {
  AuthHyBloc() : super(AuthHyState.initial()) {
    on<Authenticated>(_onAuthenticated);
    on<UserUpdated>(_onUserUpdated);
    on<Unauthenticated>(_onUnauthenticated);

    if (_isStateInconsistent(state)) {
      add(const Unauthenticated());
    }
  }

  bool _isStateInconsistent(AuthHyState state) {
    return (state.isAuthenticated &&
            (state.user == null || state.token == null)) ||
        (!state.isAuthenticated && (state.user != null || state.token != null));
  }

  void _onUnauthenticated(Unauthenticated event, Emitter<AuthHyState> emit) {
    emit(AuthHyState.initial());
  }

  void _onAuthenticated(Authenticated event, Emitter<AuthHyState> emit) {
    if (event.user == null || event.token == null || event.token!.isEmpty) {
      return;
    }

    final newState = AuthHyState(
      isAuthenticated: true,
      user: event.user,
      token: event.token,
    );
    emit(newState);
  }

  void _onUserUpdated(UserUpdated event, Emitter<AuthHyState> emit) {
    if (state.user == null) return;

    final newState = state.copyWith(
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
    );

    emit(newState);
  }

  @override
  AuthHyState? fromJson(Map<String, dynamic> json) {
    try {
      final user = json['user'] != null
          ? PhoneModel.fromJson(json['user'] as Map<String, dynamic>)
          : null;
      final token = json['token'] as String?;
      final isAuthenticated = json['isAuthenticated'] as bool? ?? false;

      if ((isAuthenticated && (user == null || token == null)) ||
          (!isAuthenticated && (user != null || token != null))) {
        return AuthHyState.initial();
      }

      return AuthHyState(
        isAuthenticated: isAuthenticated,
        user: user,
        token: token,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error al deserializar estado: $e');
      }
      return AuthHyState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthHyState state) {
    if (_isStateInconsistent(state)) {
      return {'isAuthenticated': false, 'user': null, 'token': null};
    }

    return {
      'isAuthenticated': state.isAuthenticated,
      'user': state.user?.toJson(),
      'token': state.token,
    };
  }
}
