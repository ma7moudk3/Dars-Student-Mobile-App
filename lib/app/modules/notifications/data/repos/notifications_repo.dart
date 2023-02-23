import '../models/notification_data/item.dart';

abstract class NotificationsRepo {
  Future<List<Item>> getNotifications({
    required int perPage,
    required int page,
  });
  Future<int> getUnReadNotificationsCount();
  Future<int> setAllNotificationsAsRead();
  Future<int> deleteNotification({required String notificationId});
}
