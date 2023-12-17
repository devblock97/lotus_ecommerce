import 'package:ecommerce_app/features/notification/data/models/notification.dart';

abstract class NotifyRepository {
  void addNotification(NotificationModel notify);

  void cartNotify();

  void favoriteNotify();

  void checkoutNotify();

  void resetNotify();

  int notifyCounter();

  void updateNotification({required int index});

  List<NotificationModel> notifyLists();
}
