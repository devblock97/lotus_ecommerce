import 'package:ecommerce_app/features/notification/data/models/notification.dart';
import 'package:ecommerce_app/features/notification/domain/repositories/notify_repository.dart';
import 'package:flutter/material.dart';

class NotifyRepositoryImpl extends ChangeNotifier implements NotifyRepository {
  int _counter = 0;

  List<NotificationModel> _listNotify = [];

  @override
  void cartNotify() {
    _counter++;
    notifyListeners();
  }

  @override
  void checkoutNotify() {
    _counter++;
    notifyListeners();
  }

  @override
  void favoriteNotify() {
    _counter++;
    notifyListeners();
  }

  @override
  int notifyCounter() {
    return _counter;
  }

  @override
  void resetNotify() {
    _counter = 0;
    notifyListeners();
  }

  @override
  List<NotificationModel> notifyLists() => _listNotify;

  @override
  void addNotification(NotificationModel notify) {
    _listNotify.insert(0, notify);
    _counter++;
    notifyListeners();
  }

  @override
  void updateNotification({required int index}) {
    _listNotify[index].isReaded = true;
    notifyListeners();
  }
}
