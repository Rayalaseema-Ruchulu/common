import 'package:json_annotation/json_annotation.dart';

part 'item_details.g.dart';

@JsonSerializable()
class ItemDetails {
  List<int> categories;
  List<int> ingredients;

  ItemDetails({required this.categories, required this.ingredients});

  factory ItemDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);
}
