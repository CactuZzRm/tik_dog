import 'package:json_annotation/json_annotation.dart';

import '../models/user_model.dart';

part 'change_social_network_response.g.dart';

@JsonSerializable()
class ChangeSocialNetworkResponse {
  final UserModel user;

  ChangeSocialNetworkResponse({required this.user});

  factory ChangeSocialNetworkResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeSocialNetworkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeSocialNetworkResponseToJson(this);
}
