# Mukku Maligai Kadai - Flutter Application

A comprehensive Flutter application for managing a grocery store (Mukku Maligai Kadai) with features for customers, shopkeepers, and managers.

## Project Structure

```
lib/
├── main.dart                    # Application entry point
├── screens/                     # All UI screens organized by role
│   ├── auth/                   # Authentication screens
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   └── forgot_password_page.dart
│   ├── customer/               # Customer-specific screens
│   │   ├── home_page.dart
│   │   ├── customer_products_page.dart
│   │   ├── customer_cart_page.dart
│   │   ├── customer_orders_page.dart
│   │   ├── customer_order_details_page.dart
│   │   ├── checkout_pickup_page.dart
│   │   └── product_details_page.dart
│   ├── shopkeeper/             # Shopkeeper-specific screens
│   │   ├── shopkeeper_dashboard.dart
│   │   ├── products_page.dart
│   │   ├── add_product_page.dart
│   │   ├── manage_stocks_page.dart
│   │   ├── orders_page.dart
│   │   ├── new_orders_page.dart
│   │   ├── processing_orders_page.dart
│   │   ├── orders_list_page.dart
│   │   └── order_details_page.dart
│   └── shared/                 # Shared screens across roles
│       ├── main_navigation.dart
│       ├── account_page.dart
│       └── logout_page.dart
├── manager/                     # Manager-specific screens
│   ├── manager_dashboard.dart
│   ├── manager_orders_page.dart
│   ├── manager_revenue_page.dart
│   ├── manager_shops_page.dart
│   ├── manager_users_page.dart
│   └── manager_user_details_page.dart
├── models/                      # Data models
│   ├── product.dart
│   └── order_model.dart
├── services/                    # Business logic and services
│   ├── product_service.dart
│   ├── cart_service.dart
│   ├── order_service.dart
│   ├── wishlist_service.dart
│   └── notification_service.dart
└── widgets/                     # Reusable widgets
    └── custom_bottom_nav.dart
```

## Features

### Customer Features
- Browse products by category
- View product details
- Add items to cart
- Place orders with pickup time selection
- View order history and status
- Manage wishlist
- Account management with profile picture upload

### Shopkeeper Features
- Dashboard with sales overview
- Product management (add, edit, delete, hide)
- Stock management with restock notifications
- Order management (new, processing, completed, cancelled)
- Select and restore deleted products
- Account and settings management

### Manager Features
- Overview dashboard
- Manage multiple shops
- View all orders across shops
- Revenue tracking and analytics
- User management

## Technologies Used
- **Framework**: Flutter
- **Language**: Dart
- **State Management**: setState (StatefulWidget)
- **UI Components**: Material Design 3
- **Fonts**: Google Fonts (Cinzel, Outfit)

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or physical device

### Installation

1. Clone the repository:
```bash
git clone https://github.com/biruntha-tech/mukkuMaligaiKadai.git
cd mukkuMaligaiKadai
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Design Highlights

- **Consistent Color Scheme**: 
  - Brand Color: #00FF80 (Green)
  - Background Color: #E0FFF0 (Light Green)
  - Customer Theme: #CDB7A6 (Beige)

- **Typography**: 
  - Headings: Cinzel font family
  - Body: Outfit font family

- **Navigation**: Custom bottom navigation bar with role-based screen access

## Recent Updates

- Restructured project folders for better organization
- Added select and restore functionality for deleted products
- Implemented back buttons across all pages
- Enhanced order management with status tracking
- Added settings menu in account page
- Improved UI consistency across all screens

## Contributing

This is a private project for Mukku Maligai Kadai. For any questions or suggestions, please contact the development team.

## License

Proprietary - All rights reserved

---

**Last Updated**: January 2026
