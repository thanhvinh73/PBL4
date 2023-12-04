// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'label_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LabelOrder _$LabelOrderFromJson(Map<String, dynamic> json) {
  return _LabelOrder.fromJson(json);
}

/// @nodoc
mixin _$LabelOrder {
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "label_order")
  int? get labelOrder => throw _privateConstructorUsedError;
  LabelOrderEnum? get label => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LabelOrderCopyWith<LabelOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelOrderCopyWith<$Res> {
  factory $LabelOrderCopyWith(
          LabelOrder value, $Res Function(LabelOrder) then) =
      _$LabelOrderCopyWithImpl<$Res, LabelOrder>;
  @useResult
  $Res call(
      {String? userId,
      @JsonKey(name: "label_order") int? labelOrder,
      LabelOrderEnum? label});
}

/// @nodoc
class _$LabelOrderCopyWithImpl<$Res, $Val extends LabelOrder>
    implements $LabelOrderCopyWith<$Res> {
  _$LabelOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? labelOrder = freezed,
    Object? label = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      labelOrder: freezed == labelOrder
          ? _value.labelOrder
          : labelOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as LabelOrderEnum?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LabelOrderCopyWith<$Res>
    implements $LabelOrderCopyWith<$Res> {
  factory _$$_LabelOrderCopyWith(
          _$_LabelOrder value, $Res Function(_$_LabelOrder) then) =
      __$$_LabelOrderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      @JsonKey(name: "label_order") int? labelOrder,
      LabelOrderEnum? label});
}

/// @nodoc
class __$$_LabelOrderCopyWithImpl<$Res>
    extends _$LabelOrderCopyWithImpl<$Res, _$_LabelOrder>
    implements _$$_LabelOrderCopyWith<$Res> {
  __$$_LabelOrderCopyWithImpl(
      _$_LabelOrder _value, $Res Function(_$_LabelOrder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? labelOrder = freezed,
    Object? label = freezed,
  }) {
    return _then(_$_LabelOrder(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      labelOrder: freezed == labelOrder
          ? _value.labelOrder
          : labelOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as LabelOrderEnum?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LabelOrder implements _LabelOrder {
  const _$_LabelOrder(
      {this.userId, @JsonKey(name: "label_order") this.labelOrder, this.label});

  factory _$_LabelOrder.fromJson(Map<String, dynamic> json) =>
      _$$_LabelOrderFromJson(json);

  @override
  final String? userId;
  @override
  @JsonKey(name: "label_order")
  final int? labelOrder;
  @override
  final LabelOrderEnum? label;

  @override
  String toString() {
    return 'LabelOrder(userId: $userId, labelOrder: $labelOrder, label: $label)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LabelOrder &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.labelOrder, labelOrder) ||
                other.labelOrder == labelOrder) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, labelOrder, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LabelOrderCopyWith<_$_LabelOrder> get copyWith =>
      __$$_LabelOrderCopyWithImpl<_$_LabelOrder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LabelOrderToJson(
      this,
    );
  }
}

abstract class _LabelOrder implements LabelOrder {
  const factory _LabelOrder(
      {final String? userId,
      @JsonKey(name: "label_order") final int? labelOrder,
      final LabelOrderEnum? label}) = _$_LabelOrder;

  factory _LabelOrder.fromJson(Map<String, dynamic> json) =
      _$_LabelOrder.fromJson;

  @override
  String? get userId;
  @override
  @JsonKey(name: "label_order")
  int? get labelOrder;
  @override
  LabelOrderEnum? get label;
  @override
  @JsonKey(ignore: true)
  _$$_LabelOrderCopyWith<_$_LabelOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
