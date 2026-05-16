# 🎮 GearGrid

A cyberpunk-themed gaming peripheral ecommerce application built with **Flutter**, powered by **Supabase** and **Stripe**.

![Flutter](https://img.shields.io/badge/Flutter-3.22+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?logo=supabase&logoColor=white)
![Stripe](https://img.shields.io/badge/Stripe-Payments-635BFF?logo=stripe&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## ✨ Features

- **Neo UI Theme** — Glassmorphism cards, gradient backgrounds, and smooth animations for a premium cyberpunk aesthetic
- **Product Catalog** — 12 gaming peripherals (mice, keyboards, chairs, headsets, monitors, controllers, mics, accessories)
- **Search & Filter** — Real-time search bar with category chip filters
- **Revolving Carousel** — Auto-scrolling banner showcasing combo deals and hot items
- **Combo Deals** — Bundled product discounts (15–25% off) with one-tap add-to-cart
- **Shopping Cart** — Full cart management with quantity controls and item removal
- **Wishlist / Favorites** — Heart icon on every product to save favorites
- **Stripe Checkout** — Integrated payment flow using Stripe test mode
- **Push Notifications** — Local device notifications on successful purchases
- **In-App Notification Center** — Per-user notifications stored in Supabase with unread badge
- **User Authentication** — Email/password login and registration via Supabase Auth
- **User Profiles** — Editable username, account stats, and order history
- **Order History** — All purchases persisted to Supabase with timestamps
- **Cloud Database** — Products and user data served from Supabase PostgreSQL

---

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/89733927-35ab-44ad-9157-c1f70a801f91" width="230" />
  <img src="https://github.com/user-attachments/assets/a5ef5e01-c1e1-4466-b1fd-b6f49d3c1f29" width="230" />
  <img src="https://github.com/user-attachments/assets/ef906143-cdd3-4d2f-a7dc-f3d8435f6204" width="230" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/7f7b6cb3-edd0-4f52-91f8-5066b0dfcb91" width="230" />
  <img src="https://github.com/user-attachments/assets/d7c99aca-8134-41cc-8280-9e60b2b0c309" width="230" />
  <img src="https://github.com/user-attachments/assets/1ffd578f-9300-4532-acec-3b2394ca177b" width="230" />
</p>

---

## 🏗️ Architecture

```
lib/
├── core/                   # Services & theme
│   ├── theme.dart              # Neo dark theme configuration
│   ├── supabase_service.dart   # Supabase initialization
│   ├── stripe_service.dart     # Stripe payment processing
│   └── notification_service.dart  # Local push notifications
├── data/
│   └── mock_data.dart          # Fallback product data
├── models/
│   └── product.dart            # Product data model
├── providers/              # State management (Provider)
│   ├── auth_provider.dart      # Authentication state
│   ├── cart_provider.dart      # Shopping cart state
│   ├── shop_provider.dart      # Product catalog state
│   ├── wishlist_provider.dart  # Favorites state
│   └── notification_provider.dart  # In-app notification state
├── screens/                # UI screens
│   ├── auth_screen.dart        # Login / Register
│   ├── main_screen.dart        # Bottom navigation shell
│   ├── home_screen.dart        # Product grid + carousel
│   ├── product_details_screen.dart  # Item detail view
│   ├── combo_deals_screen.dart # Bundle deals
│   ├── cart_screen.dart        # Cart + Stripe checkout
│   ├── wishlist_screen.dart    # Saved favorites
│   └── profile_screen.dart    # User profile + order history
├── widgets/                # Reusable components
│   └── product_card.dart
└── main.dart               # Entry point
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.22+)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- A [Supabase](https://supabase.com/) account (free tier)
- A [Stripe](https://stripe.com/) account (test mode)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Muhammad-Bilal-03/gear_grid.git
   cd gear_grid
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**
   - Create a new project at [supabase.com](https://supabase.com/)
   - Run the SQL scripts in order via the **SQL Editor**:
     1. `supabase_setup.sql` — Creates the `products` table
     2. `supabase_notifications.sql` — Creates the `notifications` table
     3. `supabase_profiles.sql` — Creates `profiles` and `orders` tables
   - Go to **Authentication > Providers > Email** and disable "Confirm email" for testing
   - Copy your **Project URL** and **Anon Key** from **Settings > API**

4. **Set up Stripe**
   - Get your **Test Publishable Key** and **Test Secret Key** from the [Stripe Dashboard](https://dashboard.stripe.com/test/apikeys)

5. **Configure credentials**
   - Copy the template file:
     ```bash
     cp lib/core/secrets.example.dart lib/core/secrets.dart
     ```
   - Open `lib/core/secrets.dart` and fill in your real keys:
     ```dart
     static const String supabaseUrl = 'https://your-project.supabase.co';
     static const String supabaseAnonKey = 'your-anon-key';
     static const String stripePublishableKey = 'pk_test_...';
     static const String stripeSecretKey = 'sk_test_...';
     ```
   - This file is gitignored and will never be pushed to GitHub.

6. **Run the app**
   ```bash
   flutter run
   ```

---

## 🧪 Testing Payments

Use Stripe's test card to simulate payments:

| Field | Value |
|---|---|
| Card Number | `4242 4242 4242 4242` |
| Expiry | Any future date |
| CVC | Any 3 digits |
| ZIP | Any 5 digits |

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `provider` | State management |
| `supabase_flutter` | Backend, auth, database |
| `flutter_stripe` | Payment processing |
| `http` | API requests |
| `font_awesome_flutter` | Icon library |
| `carousel_slider` | Revolving banners |
| `flutter_local_notifications` | Push notifications |
| `flutter_launcher_icons` | Custom app icon |

---

## 🛡️ Security Note

> **⚠️ Important:** This is a prototype/testing application. API keys are stored as constants for simplicity. In a production app, secrets should be managed via environment variables or a secure backend.

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Muhammad Bilal**
- GitHub: [@Muhammad-Bilal-03](https://github.com/Muhammad-Bilal-03)
- LinkedIn: [Muhammad Bilal](https://www.linkedin.com/in/muhammad-bilal-bsse)

---

## 🙏 Acknowledgements

- [Flutter](https://flutter.dev/) — UI framework
- [Supabase](https://supabase.com/) — Open source backend
- [Stripe](https://stripe.com/) — Payment processing
