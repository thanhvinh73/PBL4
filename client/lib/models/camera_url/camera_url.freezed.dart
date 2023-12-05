// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CameraUrl _$CameraUrlFromJson(Map<String, dynamic> json) {
  return _CameraUrl.fromJson(json);
}

/// @nodoc
mixin _$CameraUrl {
  String? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: "create_at")
  int? get createAt => throw _privateConstructorUsedError;
  CameraUrlStatus? get status => throw _privateConstructorUsedError;
  String? get ssid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CameraUrlCopyWith<CameraUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraUrlCopyWith<$Res> {
  factory $CameraUrlCopyWith(CameraUrl value, $Res Function(CameraUrl) then) =
      _$CameraUrlCopyWithImpl<$Res, CameraUrl>;
  @useResult
  $Res call(
      {String? id,
      String? url,
      @JsonKey(name: "create_at") int? createAt,
      CameraUrlStatus? status,
      String? ssid});
}

/// @nodoc
class _$CameraUrlCopyWithImpl<$Res, $Val extends CameraUrl>
    implements $CameraUrlCopyWith<$Res> {
  _$CameraUrlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? createAt = freezed,
    Object? status = freezed,
    Object? ssid = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CameraUrlStatus?,
      ssid: freezed == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CameraUrlCopyWith<$Res> implements $CameraUrlCopyWith<$Res> {
  factory _$$_CameraUrlCopyWith(
          _$_CameraUrl value, $Res Function(_$_CameraUrl) then) =
      __$$_CameraUrlCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? url,
      @JsonKey(name: "create_at") int? createAt,
      CameraUrlStatus? status,
      String? ssid});
}

/// @nodoc
class __$$_CameraUrlCopyWithImpl<$Res>
    extends _$CameraUrlCopyWithImpl<$Res, _$_CameraUrl>
    implements _$$_CameraUrlCopyWith<$Res> {
  __$$_CameraUrlCopyWithImpl(
      _$_CameraUrl _value, $Res Function(_$_CameraUrl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? createAt = freezed,
    Object? status = freezed,
    Object? ssid = freezed,
  }) {
    return _then(_$_CameraUrl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CameraUrlStatus?,
      ssid: freezed == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CameraUrl implements _CameraUrl {
  const _$_CameraUrl(
      {this.id,
      this.url,
      @JsonKey(name: "create_at") this.createAt,
      this.status,
      this.ssid});

  factory _$_CameraUrl.fromJson(Map<String, dynamic> json) =>
      _$$_CameraUrlFromJson(json);

  @override
  final String? id;
  @override
  final String? url;
  @override
  @JsonKey(name: "create_at")
  final int? createAt;
  @override
  final CameraUrlStatus? status;
  @override
  final String? ssid;

  @override
  String toString() {
    return 'CameraUrl(id: $id, url: $url, createAt: $createAt, status: $status, ssid: $ssid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CameraUrl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.ssid, ssid) || other.ssid == ssid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, createAt, status, ssid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CameraUrlCopyWith<_$_CameraUrl> get copyWith =>
      __$$_CameraUrlCopyWithImpl<_$_CameraUrl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CameraUrlToJson(
      this,
    );
  }
}

abstract class _CameraUrl implements CameraUrl {
  const factory _CameraUrl(
      {final String? id,
      final String? url,
      @JsonKey(name: "create_at") final int? createAt,
      final CameraUrlStatus? status,
      final String? ssid}) = _$_CameraUrl;

  factory _CameraUrl.fromJson(Map<String, dynamic> json) =
      _$_CameraUrl.fromJson;

  @override
  String? get id;
  @override
  String? get url;
  @override
  @JsonKey(name: "create_at")
  int? get createAt;
  @override
  CameraUrlStatus? get status;
  @override
  String? get ssid;
  @override
  @JsonKey(ignore: true)
  _$$_CameraUrlCopyWith<_$_CameraUrl> get copyWith =>
      throw _privateConstructorUsedError;
}
