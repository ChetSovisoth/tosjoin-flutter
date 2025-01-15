enum Status {
  pending('Pending'),
  approved('Approved'),
  reject('Rejected'),
  cancelled('Cancelled');
  final String displayName;
  const Status(this.displayName);
}

enum UserRole {
  user('User'),
  admin('Admin'),
  owner('Owner');
  final String displayName;
  const UserRole(this.displayName);
}

enum HolidayType {
  notional('Notional'),
  regional('Regional'),
  public('Public'),
  local('Local');


  final String displayName;
  const HolidayType(this.displayName);

  HolidayType fromString(int value) {
    switch (value) {
      case 1:
        return HolidayType.notional;
      case 2:
        return HolidayType.regional;
      case 3:
        return HolidayType.local;
      case 4:
        return HolidayType.public;
      default:
        return HolidayType.notional;
    }
  }
}