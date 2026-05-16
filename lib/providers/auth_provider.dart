import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient? _supabase = Supabase.instance.client;

  User? get currentUser => _supabase?.auth.currentUser;
  bool get isAuthenticated => currentUser != null;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _supabase?.auth.onAuthStateChange.listen((data) {
      notifyListeners();
    });
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    if (_supabase == null) {
      _setError('Supabase is not initialized');
      return false;
    }

    try {
      _setLoading(true);
      _setError(null);
      await _supabase.auth.signInWithPassword(email: email, password: password);
      return true;
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred.');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signUp(String email, String password) async {
    if (_supabase == null) {
      _setError('Supabase is not initialized');
      return false;
    }

    try {
      _setLoading(true);
      _setError(null);
      await _supabase.auth.signUp(email: email, password: password);
      return true;
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred.');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _supabase?.auth.signOut();
  }
}
