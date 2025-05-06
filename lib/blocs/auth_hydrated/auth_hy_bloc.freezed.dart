// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_hy_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthHyEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            PhoneModel? user, String? token, bool isAuthenticated)
        authenticate,
    required TResult Function(
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
            String? token)
        updateUser,
    required TResult Function() unauthenticate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult? Function(
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
            String? token)?
        updateUser,
    TResult? Function()? unauthenticate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult Function(
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
            String? token)?
        updateUser,
    TResult Function()? unauthenticate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticate,
    required TResult Function(UserUpdated value) updateUser,
    required TResult Function(Unauthenticated value) unauthenticate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticate,
    TResult? Function(UserUpdated value)? updateUser,
    TResult? Function(Unauthenticated value)? unauthenticate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticate,
    TResult Function(UserUpdated value)? updateUser,
    TResult Function(Unauthenticated value)? unauthenticate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthHyEventCopyWith<$Res> {
  factory $AuthHyEventCopyWith(
          AuthHyEvent value, $Res Function(AuthHyEvent) then) =
      _$AuthHyEventCopyWithImpl<$Res, AuthHyEvent>;
}

/// @nodoc
class _$AuthHyEventCopyWithImpl<$Res, $Val extends AuthHyEvent>
    implements $AuthHyEventCopyWith<$Res> {
  _$AuthHyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PhoneModel? user, String? token, bool isAuthenticated});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthHyEventCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? token = freezed,
    Object? isAuthenticated = null,
  }) {
    return _then(_$AuthenticatedImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PhoneModel?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthenticatedImpl
    with DiagnosticableTreeMixin
    implements Authenticated {
  const _$AuthenticatedImpl(
      {this.user, this.token, required this.isAuthenticated});

  @override
  final PhoneModel? user;
  @override
  final String? token;
  @override
  final bool isAuthenticated;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthHyEvent.authenticate(user: $user, token: $token, isAuthenticated: $isAuthenticated)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthHyEvent.authenticate'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('isAuthenticated', isAuthenticated));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, token, isAuthenticated);

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            PhoneModel? user, String? token, bool isAuthenticated)
        authenticate,
    required TResult Function(
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
            String? token)
        updateUser,
    required TResult Function() unauthenticate,
  }) {
    return authenticate(user, token, isAuthenticated);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult? Function(
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
            String? token)?
        updateUser,
    TResult? Function()? unauthenticate,
  }) {
    return authenticate?.call(user, token, isAuthenticated);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult Function(
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
            String? token)?
        updateUser,
    TResult Function()? unauthenticate,
    required TResult orElse(),
  }) {
    if (authenticate != null) {
      return authenticate(user, token, isAuthenticated);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticate,
    required TResult Function(UserUpdated value) updateUser,
    required TResult Function(Unauthenticated value) unauthenticate,
  }) {
    return authenticate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticate,
    TResult? Function(UserUpdated value)? updateUser,
    TResult? Function(Unauthenticated value)? unauthenticate,
  }) {
    return authenticate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticate,
    TResult Function(UserUpdated value)? updateUser,
    TResult Function(Unauthenticated value)? unauthenticate,
    required TResult orElse(),
  }) {
    if (authenticate != null) {
      return authenticate(this);
    }
    return orElse();
  }
}

abstract class Authenticated implements AuthHyEvent {
  const factory Authenticated(
      {final PhoneModel? user,
      final String? token,
      required final bool isAuthenticated}) = _$AuthenticatedImpl;

  PhoneModel? get user;
  String? get token;
  bool get isAuthenticated;

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserUpdatedImplCopyWith<$Res> {
  factory _$$UserUpdatedImplCopyWith(
          _$UserUpdatedImpl value, $Res Function(_$UserUpdatedImpl) then) =
      __$$UserUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int? adminPhoneId,
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
      String? token});
}

/// @nodoc
class __$$UserUpdatedImplCopyWithImpl<$Res>
    extends _$AuthHyEventCopyWithImpl<$Res, _$UserUpdatedImpl>
    implements _$$UserUpdatedImplCopyWith<$Res> {
  __$$UserUpdatedImplCopyWithImpl(
      _$UserUpdatedImpl _value, $Res Function(_$UserUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adminPhoneId = freezed,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? groupCheck = freezed,
    Object? groupLat = freezed,
    Object? groupLon = freezed,
    Object? type = freezed,
    Object? customCheck = freezed,
    Object? customCheckForm = freezed,
    Object? dayType = freezed,
    Object? dayForm = freezed,
    Object? restPact = freezed,
    Object? restMinutes = freezed,
    Object? flex = freezed,
    Object? hoursWeek = freezed,
    Object? hoursYear = freezed,
    Object? lastSign = freezed,
    Object? token = freezed,
  }) {
    return _then(_$UserUpdatedImpl(
      adminPhoneId: freezed == adminPhoneId
          ? _value.adminPhoneId
          : adminPhoneId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      groupCheck: freezed == groupCheck
          ? _value.groupCheck
          : groupCheck // ignore: cast_nullable_to_non_nullable
              as String?,
      groupLat: freezed == groupLat
          ? _value.groupLat
          : groupLat // ignore: cast_nullable_to_non_nullable
              as double?,
      groupLon: freezed == groupLon
          ? _value.groupLon
          : groupLon // ignore: cast_nullable_to_non_nullable
              as double?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      customCheck: freezed == customCheck
          ? _value.customCheck
          : customCheck // ignore: cast_nullable_to_non_nullable
              as bool?,
      customCheckForm: freezed == customCheckForm
          ? _value.customCheckForm
          : customCheckForm // ignore: cast_nullable_to_non_nullable
              as String?,
      dayType: freezed == dayType
          ? _value.dayType
          : dayType // ignore: cast_nullable_to_non_nullable
              as String?,
      dayForm: freezed == dayForm
          ? _value.dayForm
          : dayForm // ignore: cast_nullable_to_non_nullable
              as String?,
      restPact: freezed == restPact
          ? _value.restPact
          : restPact // ignore: cast_nullable_to_non_nullable
              as bool?,
      restMinutes: freezed == restMinutes
          ? _value.restMinutes
          : restMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      flex: freezed == flex
          ? _value.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as bool?,
      hoursWeek: freezed == hoursWeek
          ? _value.hoursWeek
          : hoursWeek // ignore: cast_nullable_to_non_nullable
              as double?,
      hoursYear: freezed == hoursYear
          ? _value.hoursYear
          : hoursYear // ignore: cast_nullable_to_non_nullable
              as double?,
      lastSign: freezed == lastSign
          ? _value.lastSign
          : lastSign // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UserUpdatedImpl with DiagnosticableTreeMixin implements UserUpdated {
  const _$UserUpdatedImpl(
      {this.adminPhoneId,
      this.groupId,
      this.groupName,
      this.groupCheck,
      this.groupLat,
      this.groupLon,
      this.type,
      this.customCheck,
      this.customCheckForm,
      this.dayType,
      this.dayForm,
      this.restPact,
      this.restMinutes,
      this.flex,
      this.hoursWeek,
      this.hoursYear,
      this.lastSign,
      this.token});

  @override
  final int? adminPhoneId;
  @override
  final int? groupId;
  @override
  final String? groupName;
  @override
  final String? groupCheck;
  @override
  final double? groupLat;
  @override
  final double? groupLon;
  @override
  final String? type;
  @override
  final bool? customCheck;
  @override
  final String? customCheckForm;
  @override
  final String? dayType;
  @override
  final String? dayForm;
  @override
  final bool? restPact;
  @override
  final int? restMinutes;
  @override
  final bool? flex;
  @override
  final double? hoursWeek;
  @override
  final double? hoursYear;
  @override
  final String? lastSign;
  @override
  final String? token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthHyEvent.updateUser(adminPhoneId: $adminPhoneId, groupId: $groupId, groupName: $groupName, groupCheck: $groupCheck, groupLat: $groupLat, groupLon: $groupLon, type: $type, customCheck: $customCheck, customCheckForm: $customCheckForm, dayType: $dayType, dayForm: $dayForm, restPact: $restPact, restMinutes: $restMinutes, flex: $flex, hoursWeek: $hoursWeek, hoursYear: $hoursYear, lastSign: $lastSign, token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthHyEvent.updateUser'))
      ..add(DiagnosticsProperty('adminPhoneId', adminPhoneId))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('groupName', groupName))
      ..add(DiagnosticsProperty('groupCheck', groupCheck))
      ..add(DiagnosticsProperty('groupLat', groupLat))
      ..add(DiagnosticsProperty('groupLon', groupLon))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('customCheck', customCheck))
      ..add(DiagnosticsProperty('customCheckForm', customCheckForm))
      ..add(DiagnosticsProperty('dayType', dayType))
      ..add(DiagnosticsProperty('dayForm', dayForm))
      ..add(DiagnosticsProperty('restPact', restPact))
      ..add(DiagnosticsProperty('restMinutes', restMinutes))
      ..add(DiagnosticsProperty('flex', flex))
      ..add(DiagnosticsProperty('hoursWeek', hoursWeek))
      ..add(DiagnosticsProperty('hoursYear', hoursYear))
      ..add(DiagnosticsProperty('lastSign', lastSign))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserUpdatedImpl &&
            (identical(other.adminPhoneId, adminPhoneId) ||
                other.adminPhoneId == adminPhoneId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.groupCheck, groupCheck) ||
                other.groupCheck == groupCheck) &&
            (identical(other.groupLat, groupLat) ||
                other.groupLat == groupLat) &&
            (identical(other.groupLon, groupLon) ||
                other.groupLon == groupLon) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.customCheck, customCheck) ||
                other.customCheck == customCheck) &&
            (identical(other.customCheckForm, customCheckForm) ||
                other.customCheckForm == customCheckForm) &&
            (identical(other.dayType, dayType) || other.dayType == dayType) &&
            (identical(other.dayForm, dayForm) || other.dayForm == dayForm) &&
            (identical(other.restPact, restPact) ||
                other.restPact == restPact) &&
            (identical(other.restMinutes, restMinutes) ||
                other.restMinutes == restMinutes) &&
            (identical(other.flex, flex) || other.flex == flex) &&
            (identical(other.hoursWeek, hoursWeek) ||
                other.hoursWeek == hoursWeek) &&
            (identical(other.hoursYear, hoursYear) ||
                other.hoursYear == hoursYear) &&
            (identical(other.lastSign, lastSign) ||
                other.lastSign == lastSign) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      adminPhoneId,
      groupId,
      groupName,
      groupCheck,
      groupLat,
      groupLon,
      type,
      customCheck,
      customCheckForm,
      dayType,
      dayForm,
      restPact,
      restMinutes,
      flex,
      hoursWeek,
      hoursYear,
      lastSign,
      token);

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserUpdatedImplCopyWith<_$UserUpdatedImpl> get copyWith =>
      __$$UserUpdatedImplCopyWithImpl<_$UserUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            PhoneModel? user, String? token, bool isAuthenticated)
        authenticate,
    required TResult Function(
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
            String? token)
        updateUser,
    required TResult Function() unauthenticate,
  }) {
    return updateUser(
        adminPhoneId,
        groupId,
        groupName,
        groupCheck,
        groupLat,
        groupLon,
        type,
        customCheck,
        customCheckForm,
        dayType,
        dayForm,
        restPact,
        restMinutes,
        flex,
        hoursWeek,
        hoursYear,
        lastSign,
        token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult? Function(
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
            String? token)?
        updateUser,
    TResult? Function()? unauthenticate,
  }) {
    return updateUser?.call(
        adminPhoneId,
        groupId,
        groupName,
        groupCheck,
        groupLat,
        groupLon,
        type,
        customCheck,
        customCheckForm,
        dayType,
        dayForm,
        restPact,
        restMinutes,
        flex,
        hoursWeek,
        hoursYear,
        lastSign,
        token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult Function(
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
            String? token)?
        updateUser,
    TResult Function()? unauthenticate,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(
          adminPhoneId,
          groupId,
          groupName,
          groupCheck,
          groupLat,
          groupLon,
          type,
          customCheck,
          customCheckForm,
          dayType,
          dayForm,
          restPact,
          restMinutes,
          flex,
          hoursWeek,
          hoursYear,
          lastSign,
          token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticate,
    required TResult Function(UserUpdated value) updateUser,
    required TResult Function(Unauthenticated value) unauthenticate,
  }) {
    return updateUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticate,
    TResult? Function(UserUpdated value)? updateUser,
    TResult? Function(Unauthenticated value)? unauthenticate,
  }) {
    return updateUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticate,
    TResult Function(UserUpdated value)? updateUser,
    TResult Function(Unauthenticated value)? unauthenticate,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(this);
    }
    return orElse();
  }
}

abstract class UserUpdated implements AuthHyEvent {
  const factory UserUpdated(
      {final int? adminPhoneId,
      final int? groupId,
      final String? groupName,
      final String? groupCheck,
      final double? groupLat,
      final double? groupLon,
      final String? type,
      final bool? customCheck,
      final String? customCheckForm,
      final String? dayType,
      final String? dayForm,
      final bool? restPact,
      final int? restMinutes,
      final bool? flex,
      final double? hoursWeek,
      final double? hoursYear,
      final String? lastSign,
      final String? token}) = _$UserUpdatedImpl;

  int? get adminPhoneId;
  int? get groupId;
  String? get groupName;
  String? get groupCheck;
  double? get groupLat;
  double? get groupLon;
  String? get type;
  bool? get customCheck;
  String? get customCheckForm;
  String? get dayType;
  String? get dayForm;
  bool? get restPact;
  int? get restMinutes;
  bool? get flex;
  double? get hoursWeek;
  double? get hoursYear;
  String? get lastSign;
  String? get token;

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserUpdatedImplCopyWith<_$UserUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthHyEventCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthHyEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedImpl
    with DiagnosticableTreeMixin
    implements Unauthenticated {
  const _$UnauthenticatedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthHyEvent.unauthenticate()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthHyEvent.unauthenticate'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            PhoneModel? user, String? token, bool isAuthenticated)
        authenticate,
    required TResult Function(
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
            String? token)
        updateUser,
    required TResult Function() unauthenticate,
  }) {
    return unauthenticate();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult? Function(
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
            String? token)?
        updateUser,
    TResult? Function()? unauthenticate,
  }) {
    return unauthenticate?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneModel? user, String? token, bool isAuthenticated)?
        authenticate,
    TResult Function(
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
            String? token)?
        updateUser,
    TResult Function()? unauthenticate,
    required TResult orElse(),
  }) {
    if (unauthenticate != null) {
      return unauthenticate();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticate,
    required TResult Function(UserUpdated value) updateUser,
    required TResult Function(Unauthenticated value) unauthenticate,
  }) {
    return unauthenticate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticate,
    TResult? Function(UserUpdated value)? updateUser,
    TResult? Function(Unauthenticated value)? unauthenticate,
  }) {
    return unauthenticate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticate,
    TResult Function(UserUpdated value)? updateUser,
    TResult Function(Unauthenticated value)? unauthenticate,
    required TResult orElse(),
  }) {
    if (unauthenticate != null) {
      return unauthenticate(this);
    }
    return orElse();
  }
}

abstract class Unauthenticated implements AuthHyEvent {
  const factory Unauthenticated() = _$UnauthenticatedImpl;
}

/// @nodoc
mixin _$AuthHyState {
  bool get isAuthenticated => throw _privateConstructorUsedError;
  PhoneModel? get user => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

  /// Create a copy of AuthHyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthHyStateCopyWith<AuthHyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthHyStateCopyWith<$Res> {
  factory $AuthHyStateCopyWith(
          AuthHyState value, $Res Function(AuthHyState) then) =
      _$AuthHyStateCopyWithImpl<$Res, AuthHyState>;
  @useResult
  $Res call({bool isAuthenticated, PhoneModel? user, String? token});
}

/// @nodoc
class _$AuthHyStateCopyWithImpl<$Res, $Val extends AuthHyState>
    implements $AuthHyStateCopyWith<$Res> {
  _$AuthHyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthHyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuthenticated = null,
    Object? user = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PhoneModel?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthHyStateImplCopyWith<$Res>
    implements $AuthHyStateCopyWith<$Res> {
  factory _$$AuthHyStateImplCopyWith(
          _$AuthHyStateImpl value, $Res Function(_$AuthHyStateImpl) then) =
      __$$AuthHyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isAuthenticated, PhoneModel? user, String? token});
}

/// @nodoc
class __$$AuthHyStateImplCopyWithImpl<$Res>
    extends _$AuthHyStateCopyWithImpl<$Res, _$AuthHyStateImpl>
    implements _$$AuthHyStateImplCopyWith<$Res> {
  __$$AuthHyStateImplCopyWithImpl(
      _$AuthHyStateImpl _value, $Res Function(_$AuthHyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthHyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuthenticated = null,
    Object? user = freezed,
    Object? token = freezed,
  }) {
    return _then(_$AuthHyStateImpl(
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PhoneModel?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthHyStateImpl with DiagnosticableTreeMixin implements _AuthHyState {
  const _$AuthHyStateImpl(
      {required this.isAuthenticated, this.user, this.token});

  @override
  final bool isAuthenticated;
  @override
  final PhoneModel? user;
  @override
  final String? token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthHyState(isAuthenticated: $isAuthenticated, user: $user, token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthHyState'))
      ..add(DiagnosticsProperty('isAuthenticated', isAuthenticated))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthHyStateImpl &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAuthenticated, user, token);

  /// Create a copy of AuthHyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthHyStateImplCopyWith<_$AuthHyStateImpl> get copyWith =>
      __$$AuthHyStateImplCopyWithImpl<_$AuthHyStateImpl>(this, _$identity);
}

abstract class _AuthHyState implements AuthHyState {
  const factory _AuthHyState(
      {required final bool isAuthenticated,
      final PhoneModel? user,
      final String? token}) = _$AuthHyStateImpl;

  @override
  bool get isAuthenticated;
  @override
  PhoneModel? get user;
  @override
  String? get token;

  /// Create a copy of AuthHyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthHyStateImplCopyWith<_$AuthHyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
