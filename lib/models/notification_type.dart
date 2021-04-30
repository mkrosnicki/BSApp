enum NotificationType {
  YOUR_DEAL_COMMENTED,
  YOUR_DEAL_RATED,
  YOUR_COMMENT_REPLIED,
  YOUR_COMMENT_RATED,
  YOUR_TOPIC_REPLIED,
  YOUR_POST_REPLIED,
}

class NotificationTypeHelper {

  static NotificationType fromString(String notificationTypeString) {
    for (var notificationType in NotificationType.values) {
      if (asString(notificationType) == notificationTypeString) {
        return notificationType;
      }
    }
    return null;
  }

  static String asString(NotificationType notificationType) {
    return notificationType.toString().replaceFirst('NotificationType.', '');
  }

}
