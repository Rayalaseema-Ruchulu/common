import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryOrIngredient {
  int id;
  String name;

  CategoryOrIngredient(this.id, this.name);

  factory CategoryOrIngredient.fromJson(Map<String, dynamic> json) =>
      _$CategoryOrIngredientFromJson(json);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    return other is CategoryOrIngredient && id == other.id;
  }

  @override
  String toString() => name;
}
