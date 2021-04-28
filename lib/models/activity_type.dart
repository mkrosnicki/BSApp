enum ActivityType {
  TOPIC_CREATED,
  DEAL_CREATED,
  COMMENT_ADDED,
  COMMENT_REPLIED,
  POST_ADDED
}

class ActivityTypeHelper {

  static ActivityType fromString(String activityTypeString) {
    for (var activityType in ActivityType.values) {
      if (asString(activityType) == activityTypeString) {
        return activityType;
      }
    }
    return null;
  }

  static String asString(ActivityType activityType) {
    return activityType.toString().replaceFirst('ActivityType.', '');
  }

}
