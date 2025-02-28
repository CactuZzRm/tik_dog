import 'package:json_annotation/json_annotation.dart';

part 'group_user_model.g.dart';

@JsonSerializable()
class GroupUserBody {
  @JsonKey(name: 'user_id')
  final String userId;

  GroupUserBody({required this.userId});

  factory GroupUserBody.fromJson(Map<String, dynamic> json) => _$GroupUserBodyFromJson(json);
  Map<String, dynamic> toJson() => _$GroupUserBodyToJson(this);
}
