import 'package:freezed_annotation/freezed_annotation.dart';
import '../competitor/competitor.dart';

part 'user.freezed.dart';
part 'user.g.dart';

abstract class BaseUser {
  String get id;
  String get name;
  String? get email;
  String get role;
  bool? get private;
  Competitor? get competitor;
  String? get userVerification;
  DateTime? get createdAt;
  DateTime? get lastLogin;
  String? get lastModifiedBy;
}

@freezed
class User with _$User implements BaseUser {
  @JsonSerializable(explicitToJson: true)
  const factory User({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? email,
    String? password,
    required String role,
    bool? private,
    Competitor? competitor,
    @JsonKey(name: 'user_verification') String? userVerification,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_logged_in_at') DateTime? lastLogin,
    @JsonKey(name: 'last_modified_by') String? lastModifiedBy,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
