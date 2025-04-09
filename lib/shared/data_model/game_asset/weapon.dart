import 'package:freezed_annotation/freezed_annotation.dart';

part 'weapon.freezed.dart';
part 'weapon.g.dart';

@freezed
class Weapon with _$Weapon {
  const factory Weapon(
      {String? name,
      @JsonKey(name: 'weapon_type') required String weaponType,
      required int rarity,
      required String icon}) = _Weapon;

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);
}
