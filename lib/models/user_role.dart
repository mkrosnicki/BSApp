enum UserRole {
  ROLE_USER,
  ROLE_MODERATOR,
  ROLE_ADMIN
}

class UserRoleHelper {

  static UserRole fromString(String userRoleString) {
    for (var userRole in UserRole.values) {
      if (asString(userRole) == userRoleString) {
        return userRole;
      }
    }
    return null;
  }

  static String asString(UserRole activityType) {
    return activityType.toString().replaceFirst('UserRole.', '');
  }

}
