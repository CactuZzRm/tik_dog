import 'package:json_annotation/json_annotation.dart';

part 'user_rating_model.g.dart';

@JsonSerializable()
class UserRatingModel {
  final String id;
  final String name;
  final String? avatar;
  final int rank;
  final int top;
  final String provider;

  UserRatingModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.rank,
    required this.top,
    required this.provider,
  });

  factory UserRatingModel.fromJson(Map<String, dynamic> json) => _$UserRatingModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingModelToJson(this);
}
