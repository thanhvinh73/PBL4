// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_controller_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingControllerState {
  bool get onCamera => throw _privateConstructorUsedError;
  bool get isCameraInitialized => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool onCamera, bool isCameraInitialized) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool onCamera, bool isCameraInitialized)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool onCamera, bool isCameraInitialized)? initial,
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
  $SettingControllerStateCopyWith<SettingControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingControllerStateCopyWith<$Res> {
  factory $SettingControllerStateCopyWith(SettingControllerState value,
          $Res Function(SettingControllerState) then) =
      _$SettingControllerStateCopyWithImpl<$Res, SettingControllerState>;
  @useResult
  $Res call({bool onCamera, bool isCameraInitialized});
}

/// @nodoc
class _$SettingControllerStateCopyWithImpl<$Res,
        $Val extends SettingControllerState>
    implements $SettingControllerStateCopyWith<$Res> {
  _$SettingControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onCamera = null,
    Object? isCameraInitialized = null,
  }) {
    return _then(_value.copyWith(
      onCamera: null == onCamera
          ? _value.onCamera
          : onCamera // ignore: cast_nullable_to_non_nullable
              as bool,
      isCameraInitialized: null == isCameraInitialized
          ? _value.isCameraInitialized
          : isCameraInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $SettingControllerStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool onCamera, bool isCameraInitialized});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$SettingControllerStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onCamera = null,
    Object? isCameraInitialized = null,
  }) {
    return _then(_$_Initial(
      onCamera: null == onCamera
          ? _value.onCamera
          : onCamera // ignore: cast_nullable_to_non_nullable
              as bool,
      isCameraInitialized: null == isCameraInitialized
          ? _value.isCameraInitialized
          : isCameraInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.onCamera = false, this.isCameraInitialized = false});

  @override
  @JsonKey()
  final bool onCamera;
  @override
  @JsonKey()
  final bool isCameraInitialized;

  @override
  String toString() {
    return 'SettingControllerState.initial(onCamera: $onCamera, isCameraInitialized: $isCameraInitialized)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.onCamera, onCamera) ||
                other.onCamera == onCamera) &&
            (identical(other.isCameraInitialized, isCameraInitialized) ||
                other.isCameraInitialized == isCameraInitialized));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onCamera, isCameraInitialized);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool onCamera, bool isCameraInitialized) initial,
  }) {
    return initial(onCamera, isCameraInitialized);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool onCamera, bool isCameraInitialized)? initial,
  }) {
    return initial?.call(onCamera, isCameraInitialized);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool onCamera, bool isCameraInitialized)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(onCamera, isCameraInitialized);
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

abstract class _Initial implements SettingControllerState {
  const factory _Initial(
      {final bool onCamera, final bool isCameraInitialized}) = _$_Initial;

  @override
  bool get onCamera;
  @override
  bool get isCameraInitialized;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
