import 'package:ecommerce_app/features/notification/data/repositories/notify_repository_impl.dart';
import 'package:ecommerce_app/widgets/my_notification_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var notify = context.watch<NotifyRepositoryImpl>();
    return Scaffold(
      body: ListView.builder(
          itemCount: notify.notifyLists().length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return NotificationItem(
                notification: notify.notifyLists()[index], index: index);
          }),
    );
  }
}
