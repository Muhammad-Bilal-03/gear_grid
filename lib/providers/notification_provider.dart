import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_service.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String icon;
  final bool isRead;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.icon,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      id: map['id'].toString(),
      title: map['title'].toString(),
      body: map['body'].toString(),
      icon: map['icon']?.toString() ?? 'shopping_bag',
      isRead: map['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(map['created_at'].toString()),
    );
  }
}

class NotificationProvider extends ChangeNotifier {
  List<NotificationItem> _notifications = [];
  bool _isLoading = false;

  List<NotificationItem> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> fetchNotifications() async {
    final client = SupabaseService.client;
    if (client == null || client.auth.currentUser == null) {
      _notifications = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final data = await client
          .from('notifications')
          .select()
          .eq('user_id', client.auth.currentUser!.id)
          .order('created_at', ascending: false);

      _notifications = (data as List<dynamic>)
          .map((item) => NotificationItem.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Failed to fetch notifications: $e');
      _notifications = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNotification(String title, String body, {String icon = 'shopping_bag'}) async {
    final client = SupabaseService.client;
    if (client == null || client.auth.currentUser == null) return;

    try {
      await client.from('notifications').insert({
        'user_id': client.auth.currentUser!.id,
        'title': title,
        'body': body,
        'icon': icon,
      });
      await fetchNotifications();
    } catch (e) {
      debugPrint('Failed to add notification: $e');
    }
  }

  Future<void> markAllRead() async {
    final client = SupabaseService.client;
    if (client == null || client.auth.currentUser == null) return;

    try {
      await client
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', client.auth.currentUser!.id);
      await fetchNotifications();
    } catch (e) {
      debugPrint('Failed to mark notifications as read: $e');
    }
  }

  void clear() {
    _notifications = [];
    notifyListeners();
  }
}
