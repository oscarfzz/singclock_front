part of 'auth_hy_bloc.dart';

@freezed
class AuthHyState with _$AuthHyState {
  const factory AuthHyState({
    required bool isAuthenticated,
    PhoneModel? user,
    String? token,
  }) = _AuthHyState;

  factory AuthHyState.initial() {
    return const AuthHyState(
      isAuthenticated: false,
      user: PhoneModel.empty,
      token: null,
    );
  }
}
