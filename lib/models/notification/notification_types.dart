enum NotificationType {
  USER_FOLLOW,
  USER_UNFOLLOW,
  USER_REGISTER,
  USER_UPDATED,
  ORDER_CREATED
}

class NotificationTypes {
  static NotificationType getNotificationType(String type) {
    NotificationType t = NotificationType.USER_UPDATED;
    switch (type) {
      case 'USER_FOLLOW':
        t = NotificationType.USER_FOLLOW;
        break;
      case 'USER_UNFOLLOW':
        t = NotificationType.USER_UNFOLLOW;
        break;
      case 'USER_REGISTER':
        t = NotificationType.USER_REGISTER;
        break;
      case 'USER_UPDATED':
        t = NotificationType.USER_UPDATED;
        break;
      case 'ORDER_CREATED':
        t = NotificationType.ORDER_CREATED;
        break;
      default:
        break;
    }
    return t;
  }
}
