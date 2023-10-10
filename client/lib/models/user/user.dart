import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? id,
    String? email,
    String? username,
    @JsonKey(includeFromJson: false, includeToJson: false) String? password,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? confirmPassword,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
