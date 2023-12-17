import 'package:ecommerce_app/features/notification/data/models/notification.dart';
import 'package:ecommerce_app/features/notification/data/repositories/notify_repository_impl.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.index,
  });

  final NotificationModel notification;
  final int index;

  @override
  Widget build(BuildContext context) {
    var notif = context.read<NotifyRepositoryImpl>();
    return Container(
      decoration: BoxDecoration(
        color: notification.isReaded
            ? Colors.white
            : const Color.fromARGB(255, 144, 191, 212),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: () => notif.updateNotification(index: index),
          trailing: Icon(notification.isReaded
              ? Icons.mark_chat_read
              : Icons.mark_unread_chat_alt_rounded),
          title: Text(
            '${notification.title}',
            style: TextStyle(
                color: notification.isReaded ? primaryText : Colors.white),
          )),
    );
  }
}
