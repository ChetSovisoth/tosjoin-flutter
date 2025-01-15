import 'package:tosjoin/service/enum.dart';
import 'package:tosjoin/service/string_extension.dart';

class ProfileModel {
  final UserRole role;
  final String username;
  final String? profile;
  final String? claims;
  final String? startDate;
  final String? endDate;
  final String? position;

  ProfileModel({
    required this.role,
    required this.username,
    required this.profile,
    this.claims,
    this.startDate,
    this.endDate,
    this.position,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      role: json['role'].toString().toUserRole() ?? UserRole.user,
      username: json['username'],
      profile: json['profile'],
      claims: json['claims'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role.displayName,
      'username': username,
      'profile': profile,
      'claims': claims,
      'startDate': startDate,
      'endDate': endDate,
      'position': position,
    };
  }
}
