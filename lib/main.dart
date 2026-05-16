import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'core/supabase_service.dart';
import 'core/stripe_service.dart';
import 'core/notification_service.dart';
import 'providers/cart_provider.dart';
import 'providers/shop_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/notification_provider.dart';
import 'screens/main_screen.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await SupabaseService.initialize();
  // Always start fresh — clear any persisted session
  SupabaseService.client?.auth.signOut();
  await StripeService.initialize();
  runApp(const GearGridApp());
}

class GearGridApp extends StatelessWidget {
  const GearGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShopProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'GearGrid',
        debugShowCheckedModeBanner: false,
        theme: NeoTheme.darkTheme,
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            if (auth.isAuthenticated) {
              Provider.of<NotificationProvider>(context, listen: false).fetchNotifications();
              return const MainScreen();
            }
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
