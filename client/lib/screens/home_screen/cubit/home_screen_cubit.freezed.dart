// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeScreenState {
  String? get errorMessage => throw _privateConstructorUsedError;
  ScreenStatus get status => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<CameraUrl> get cameraUrls => throw _privateConstructorUsedError;
  CameraUrl? get currentUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage, ScreenStatus status,
            String text, List<CameraUrl> cameraUrls, CameraUrl? currentUrl)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage, ScreenStatus status, String text,
            List<CameraUrl> cameraUrls, CameraUrl? currentUrl)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage, ScreenStatus status, String text,
            List<CameraUrl> cameraUrls, CameraUrl? currentUrl)?
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
  $HomeScreenStateCopyWith<HomeScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenStateCopyWith<$Res> {
  factory $HomeScreenStateCopyWith(
          HomeScreenState value, $Res Function(HomeScreenState) then) =
      _$HomeScreenStateCopyWithImpl<$Res, HomeScreenState>;
  @useResult
  $Res call(
      {String? errorMessage,
      ScreenStatus status,
      String text,
      List<CameraUrl> cameraUrls,
      CameraUrl? currentUrl});

  $CameraUrlCopyWith<$Res>? get currentUrl;
}

/// @nodoc
class _$HomeScreenStateCopyWithImpl<$Res, $Val extends HomeScreenState>
    implements $HomeScreenStateCopyWith<$Res> {
  _$HomeScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? status = null,
    Object? text = null,
    Object? cameraUrls = null,
    Object? currentUrl = freezed,
  }) {
    return _then(_value.copyWith(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScreenStatus,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      cameraUrls: null == cameraUrls
          ? _value.cameraUrls
          : cameraUrls // ignore: cast_nullable_to_non_nullable
              as List<CameraUrl>,
      currentUrl: freezed == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as CameraUrl?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CameraUrlCopyWith<$Res>? get currentUrl {
    if (_value.currentUrl == null) {
      return null;
    }

    return $CameraUrlCopyWith<$Res>(_value.currentUrl!, (value) {
      return _then(_value.copyWith(currentUrl: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $HomeScreenStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? errorMessage,
      ScreenStatus status,
      String text,
      List<CameraUrl> cameraUrls,
      CameraUrl? currentUrl});

  @override
  $CameraUrlCopyWith<$Res>? get currentUrl;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$HomeScreenStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? status = null,
    Object? text = null,
    Object? cameraUrls = null,
    Object? currentUrl = freezed,
  }) {
    return _then(_$_Initial(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScreenStatus,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      cameraUrls: null == cameraUrls
          ? _value._cameraUrls
          : cameraUrls // ignore: cast_nullable_to_non_nullable
              as List<CameraUrl>,
      currentUrl: freezed == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as CameraUrl?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.errorMessage,
      this.status = ScreenStatus.init,
      this.text = "",
      final List<CameraUrl> cameraUrls = const [],
      this.currentUrl})
      : _cameraUrls = cameraUrls;

  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final ScreenStatus status;
  @override
  @JsonKey()
  final String text;
  final List<CameraUrl> _cameraUrls;
  @override
  @JsonKey()
  List<CameraUrl> get cameraUrls {
    if (_cameraUrls is EqualUnmodifiableListView) return _cameraUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cameraUrls);
  }

  @override
  final CameraUrl? currentUrl;

  @override
  String toString() {
    return 'HomeScreenState.initial(errorMessage: $errorMessage, status: $status, text: $text, cameraUrls: $cameraUrls, currentUrl: $currentUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality()
                .equals(other._cameraUrls, _cameraUrls) &&
            (identical(other.currentUrl, currentUrl) ||
                other.currentUrl == currentUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage, status, text,
      const DeepCollectionEquality().hash(_cameraUrls), currentUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage, ScreenStatus status,
            String text, List<CameraUrl> cameraUrls, CameraUrl? currentUrl)
        initial,
  }) {
    return initial(errorMessage, status, text, cameraUrls, currentUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage, ScreenStatus status, String text,
            List<CameraUrl> cameraUrls, CameraUrl? currentUrl)?
        initial,
  }) {
    return initial?.call(errorMessage, status, text, cameraUrls, currentUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage, ScreenStatus status, String text,
            List<CameraUrl> cameraUrls, CameraUrl? currentUrl)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(errorMessage, status, text, cameraUrls, currentUrl);
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

abstract class _Initial implements HomeScreenState {
  const factory _Initial(
      {final String? errorMessage,
      final ScreenStatus status,
      final String text,
      final List<CameraUrl> cameraUrls,
      final CameraUrl? currentUrl}) = _$_Initial;

  @override
  String? get errorMessage;
  @override
  ScreenStatus get status;
  @override
  String get text;
  @override
  List<CameraUrl> get cameraUrls;
  @override
  CameraUrl? get currentUrl;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
