import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'secrets.dart';

class SupabaseService {
  static const String supabaseUrl = Secrets.supabaseUrl;
  static const String supabaseAnonKey = Secrets.supabaseAnonKey;

  static Future<void> initialize() async {
    try {
      if (supabaseUrl.isNotEmpty && !supabaseUrl.contains('YOUR_SUPABASE')) {
        await Supabase.initialize(
          url: supabaseUrl,
          anonKey: supabaseAnonKey,
        );
      } else {
        debugPrint('Supabase credentials not set. Running in offline/mock mode.');
      }
    } catch (e) {
      debugPrint('Supabase initialization error: $e');
    }
  }

  static SupabaseClient? get client {
    if (supabaseUrl.isNotEmpty && !supabaseUrl.contains('YOUR_SUPABASE')) {
      return Supabase.instance.client;
    }
    return null;
  }
}
