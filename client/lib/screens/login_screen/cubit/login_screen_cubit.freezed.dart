// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginScreenState {
  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get invalidUsername => throw _privateConstructorUsedError;
  String? get invalidPassword => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  ScreenStatus get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? username,
            String? password,
            String? invalidUsername,
            String? invalidPassword,
            String? errorMessage,
            ScreenStatus status)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? username,
            String? password,
            String? invalidUsername,
            String? invalidPassword,
            String? errorMessage,
            ScreenStatus status)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? username,
            String? password,
            String? invalidUsername,
            String? invalidPassword,
            String? errorMessage,
            ScreenStatus status)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginScreenStateCopyWith<LoginScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginScreenStateCopyWith<$Res> {
  factory $LoginScreenStateCopyWith(
          LoginScreenState value, $Res Function(LoginScreenState) then) =
      _$LoginScreenStateCopyWithImpl<$Res, LoginScreenState>;
  @useResult
  $Res call(
      {String? username,
      String? password,
      String? invalidUsername,
      String? invalidPassword,
      String? errorMessage,
      ScreenStatus status});
}

/// @nodoc
class _$LoginScreenStateCopyWithImpl<$Res, $Val extends LoginScreenState>
    implements $LoginScreenStateCopyWith<$Res> {
  _$LoginScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
    Object? invalidUsername = freezed,
    Object? invalidPassword = freezed,
    Object? errorMessage = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      invalidUsername: freezed == invalidUsername
          ? _value.invalidUsername
          : invalidUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      invalidPassword: freezed == invalidPassword
          ? _value.invalidPassword
          : invalidPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScreenStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $LoginScreenStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? username,
      String? password,
      String? invalidUsername,
      String? invalidPassword,
      String? errorMessage,
      ScreenStatus status});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$LoginScreenStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
    Object? invalidUsername = freezed,
    Object? invalidPassword = freezed,
    Object? errorMessage = freezed,
    Object? status = null,
  }) {
    return _then(_$_Initial(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      invalidUsername: freezed == invalidUsername
          ? _value.invalidUsername
          : invalidUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      invalidPassword: freezed == invalidPassword
          ? _value.invalidPassword
          : invalidPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScreenStatus,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.username,
      this.password,
      this.invalidUsername,
      this.invalidPassword,
      this.errorMessage,
      this.status = ScreenStatus.init});

  @override
  final String? username;
  @override
  final String? password;
  @override
  final String? invalidUsername;
  @override
  final String? invalidPassword;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final ScreenStatus status;

  @override
  String toString() {
    return 'LoginScreenState.initial(username: $username, password: $password, invalidUsername: $invalidUsername, invalidPassword: $invalidPassword, errorMessage: $errorMessage, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.invalidUsername, invalidUsername) ||
                other.invalidUsername == invalidUsername) &&
            (identical(other.invalidPassword, invalidPassword) ||
                other.invalidPassword == invalidPassword) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password,
      invalidUsername, invalidPassword, errorMessage, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? username,
            String? password,
            String? invalidUsername,
            String? invalidPassword,
            String? errorMessage,
            ScreenStatus status)
        initial,
  }) {
    return initial(username, password, invalidUsername, invalidPassword,
        errorMessage, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? username,
            String? password,
            String? invalidUsername,
            String? invalidPassword,
            String? errorMessage,
            ScreenStatus status)?
        initial,
  }) {
    return initial?.call(username, password, invalidUsername, invalidPassword,
        errorMessage, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? username,
            String? password,
            String? invalidUsername,
            String? invalidPassword,
            String? errorMessage,
            ScreenStatus status)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(username, password, invalidUsername, invalidPassword,
          errorMessage, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LoginScreenState {
  const factory _Initial(
      {final String? username,
      final String? password,
      final String? invalidUsername,
      final String? invalidPassword,
      final String? errorMessage,
      final ScreenStatus status}) = _$_Initial;

  @override
  String? get username;
  @override
  String? get password;
  @override
  String? get invalidUsername;
  @override
  String? get invalidPassword;
  @override
  String? get errorMessage;
  @override
  ScreenStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
