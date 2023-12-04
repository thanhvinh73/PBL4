// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_actions_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ListActionsScreenState {
  String? get errorMessage => throw _privateConstructorUsedError;
  ScreenStatus get status => throw _privateConstructorUsedError;
  List<LabelOrder>? get labelOrders => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage, ScreenStatus status,
            List<LabelOrder>? labelOrders, String userId)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage, ScreenStatus status,
            List<LabelOrder>? labelOrders, String userId)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage, ScreenStatus status,
            List<LabelOrder>? labelOrders, String userId)?
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
  $ListActionsScreenStateCopyWith<ListActionsScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListActionsScreenStateCopyWith<$Res> {
  factory $ListActionsScreenStateCopyWith(ListActionsScreenState value,
          $Res Function(ListActionsScreenState) then) =
      _$ListActionsScreenStateCopyWithImpl<$Res, ListActionsScreenState>;
  @useResult
  $Res call(
      {String? errorMessage,
      ScreenStatus status,
      List<LabelOrder>? labelOrders,
      String userId});
}

/// @nodoc
class _$ListActionsScreenStateCopyWithImpl<$Res,
        $Val extends ListActionsScreenState>
    implements $ListActionsScreenStateCopyWith<$Res> {
  _$ListActionsScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? status = null,
    Object? labelOrders = freezed,
    Object? userId = null,
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
      labelOrders: freezed == labelOrders
          ? _value.labelOrders
          : labelOrders // ignore: cast_nullable_to_non_nullable
              as List<LabelOrder>?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $ListActionsScreenStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? errorMessage,
      ScreenStatus status,
      List<LabelOrder>? labelOrders,
      String userId});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$ListActionsScreenStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? status = null,
    Object? labelOrders = freezed,
    Object? userId = null,
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
      labelOrders: freezed == labelOrders
          ? _value._labelOrders
          : labelOrders // ignore: cast_nullable_to_non_nullable
              as List<LabelOrder>?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.errorMessage,
      this.status = ScreenStatus.init,
      final List<LabelOrder>? labelOrders,
      required this.userId})
      : _labelOrders = labelOrders;

  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final ScreenStatus status;
  final List<LabelOrder>? _labelOrders;
  @override
  List<LabelOrder>? get labelOrders {
    final value = _labelOrders;
    if (value == null) return null;
    if (_labelOrders is EqualUnmodifiableListView) return _labelOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String userId;

  @override
  String toString() {
    return 'ListActionsScreenState.initial(errorMessage: $errorMessage, status: $status, labelOrders: $labelOrders, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._labelOrders, _labelOrders) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage, status,
      const DeepCollectionEquality().hash(_labelOrders), userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage, ScreenStatus status,
            List<LabelOrder>? labelOrders, String userId)
        initial,
  }) {
    return initial(errorMessage, status, labelOrders, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage, ScreenStatus status,
            List<LabelOrder>? labelOrders, String userId)?
        initial,
  }) {
    return initial?.call(errorMessage, status, labelOrders, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage, ScreenStatus status,
            List<LabelOrder>? labelOrders, String userId)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(errorMessage, status, labelOrders, userId);
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

abstract class _Initial implements ListActionsScreenState {
  const factory _Initial(
      {final String? errorMessage,
      final ScreenStatus status,
      final List<LabelOrder>? labelOrders,
      required final String userId}) = _$_Initial;

  @override
  String? get errorMessage;
  @override
  ScreenStatus get status;
  @override
  List<LabelOrder>? get labelOrders;
  @override
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
