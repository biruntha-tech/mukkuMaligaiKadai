
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final List<String> _notifications = [];

  List<String> get notifications => _notifications;

  int get notificationCount => _notifications.length;

  void addNotification(String message) {
    _notifications.add(message);
    print("Notification to app manager: $message");
  }

  void clearNotifications() {
    _notifications.clear();
  }
}
