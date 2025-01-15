import 'package:tosjoin/service/enum.dart';

extension StringToUserRole on String {
  UserRole? toUserRole() {
    try {
      return UserRole.values.firstWhere((role) => role.displayName == this);
    } catch (e) {
      return null;
    }
  }

  Status? toStatus() {
    try {
      return Status.values.firstWhere((status) => status.displayName == this);
    } catch (e) {
      return null;
    }
  }
}
