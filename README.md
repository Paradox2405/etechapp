# E-Tech Store

A Flutter shopping app for a computer hardware store. It sells graphics cards from Nvidia and AMD and boards from ASUS and Gigabyte, with PayPal checkout and a store locator.

## Features

- Product catalogue by brand (Nvidia GPUs, AMD Ryzen and GPUs, ASUS, Gigabyte) with prices in LKR
- Order now, PayPal payment (in a web view) and order confirmation
- **My Orders**: order list, order details and order deletion
- Account page with a profile photo upload (Firebase Storage)
- **Locate Us**: store location on Google Maps
- Our Services, Contact Us (with the `contactus` package) and a service rating
- Email/password login and registration

## Tech stack

- **Flutter** (Dart)
- **Firebase** Authentication, Cloud Firestore and Storage
- **PayPal** REST checkout through `webview_flutter` and `http_auth`
- `google_maps_flutter`, `flutter_rating_bar`, `image_picker`, `social_share`

## Project structure

```
lib/
  UI/          screens: login, register, home, item cards, checkout, PayPal,
               orders, account, map, services, contact
  Gpus/        Nvidia and AMD product pages
  model/       auth and database helpers
```

## Getting started

1. Add your Firebase config files.
2. Add a Google Maps API key and your PayPal sandbox client ID and secret (`lib/UI/PaypalServices.dart`).
3. Run:
   ```bash
   flutter pub get
   flutter run
   ```

> Built in 2020 on an early Flutter version. Expect plugin upgrades before it builds today.
