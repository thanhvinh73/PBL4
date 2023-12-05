// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppUserState {
  User? get user => throw _privateConstructorUsedError;
  bool? get checkInternet => throw _privateConstructorUsedError;
  CameraUrl? get currentCameraUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            User? user, bool? checkInternet, CameraUrl? currentCameraUrl)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            User? user, bool? checkInternet, CameraUrl? currentCameraUrl)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            User? user, bool? checkInternet, CameraUrl? currentCameraUrl)?
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
  $AppUserStateCopyWith<AppUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserStateCopyWith<$Res> {
  factory $AppUserStateCopyWith(
          AppUserState value, $Res Function(AppUserState) then) =
      _$AppUserStateCopyWithImpl<$Res, AppUserState>;
  @useResult
  $Res call({User? user, bool? checkInternet, CameraUrl? currentCameraUrl});

  $UserCopyWith<$Res>? get user;
  $CameraUrlCopyWith<$Res>? get currentCameraUrl;
}

/// @nodoc
class _$AppUserStateCopyWithImpl<$Res, $Val extends AppUserState>
    implements $AppUserStateCopyWith<$Res> {
  _$AppUserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? checkInternet = freezed,
    Object? currentCameraUrl = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      checkInternet: freezed == checkInternet
          ? _value.checkInternet
          : checkInternet // ignore: cast_nullable_to_non_nullable
              as bool?,
      currentCameraUrl: freezed == currentCameraUrl
          ? _value.currentCameraUrl
          : currentCameraUrl // ignore: cast_nullable_to_non_nullable
              as CameraUrl?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CameraUrlCopyWith<$Res>? get currentCameraUrl {
    if (_value.currentCameraUrl == null) {
      return null;
    }

    return $CameraUrlCopyWith<$Res>(_value.currentCameraUrl!, (value) {
      return _then(_value.copyWith(currentCameraUrl: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $AppUserStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User? user, bool? checkInternet, CameraUrl? currentCameraUrl});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $CameraUrlCopyWith<$Res>? get currentCameraUrl;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$AppUserStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? checkInternet = freezed,
    Object? currentCameraUrl = freezed,
  }) {
    return _then(_$_Initial(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      checkInternet: freezed == checkInternet
          ? _value.checkInternet
          : checkInternet // ignore: cast_nullable_to_non_nullable
              as bool?,
      currentCameraUrl: freezed == currentCameraUrl
          ? _value.currentCameraUrl
          : currentCameraUrl // ignore: cast_nullable_to_non_nullable
              as CameraUrl?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.user, this.checkInternet, this.currentCameraUrl});

  @override
  final User? user;
  @override
  final bool? checkInternet;
  @override
  final CameraUrl? currentCameraUrl;

  @override
  String toString() {
    return 'AppUserState.initial(user: $user, checkInternet: $checkInternet, currentCameraUrl: $currentCameraUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.checkInternet, checkInternet) ||
                other.checkInternet == checkInternet) &&
            (identical(other.currentCameraUrl, currentCameraUrl) ||
                other.currentCameraUrl == currentCameraUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, user, checkInternet, currentCameraUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            User? user, bool? checkInternet, CameraUrl? currentCameraUrl)
        initial,
  }) {
    return initial(user, checkInternet, currentCameraUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            User? user, bool? checkInternet, CameraUrl? currentCameraUrl)?
        initial,
  }) {
    return initial?.call(user, checkInternet, currentCameraUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            User? user, bool? checkInternet, CameraUrl? currentCameraUrl)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(user, checkInternet, currentCameraUrl);
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

abstract class _Initial implements AppUserState {
  const factory _Initial(
      {final User? user,
      final bool? checkInternet,
      final CameraUrl? currentCameraUrl}) = _$_Initial;

  @override
  User? get user;
  @override
  bool? get checkInternet;
  @override
  CameraUrl? get currentCameraUrl;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
