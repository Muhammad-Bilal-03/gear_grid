import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart';

class StripeService {
  static const String publishableKey = Secrets.stripePublishableKey;
  static const String secretKey = Secrets.stripeSecretKey;

  static Future<void> initialize() async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }

  static Future<bool> makePayment(double amount) async {
    try {
      if (publishableKey.isEmpty || publishableKey.contains('YOUR_STRIPE')) {
        debugPrint('Stripe keys not set. Running simulated successful payment.');
        await Future.delayed(const Duration(seconds: 2));
        return true;
      }

      // Create payment intent
      final paymentIntent = await _createPaymentIntent(amount, 'USD');
      if (paymentIntent == null) return false;

      // Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'GearGrid',
          style: ThemeMode.dark,
        ),
      );

      // Present Payment Sheet
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      debugPrint('Error during Stripe payment: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> _createPaymentIntent(double amount, String currency) async {
    try {
      // Amount must be an integer in cents
      final int amountInCents = (amount * 100).toInt();

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': amountInCents.toString(),
          'currency': currency,
        },
      );

      return json.decode(response.body);
    } catch (e) {
      debugPrint('Failed to create payment intent: $e');
      return null;
    }
  }
}
