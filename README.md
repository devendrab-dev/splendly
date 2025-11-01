lib/
 ├─ main.dart
 ├─ app.dart                      # App entry point / routes
 ├─ core/                         # Shared logic across features
 │   ├─ constants/
 │   │   ├─ app_colors.dart
 │   │   ├─ app_texts.dart
 │   │   └─ app_sizes.dart
 │   ├─ exceptions/
 │   │   └─ failure.dart
 │   ├─ network/
 │   │   ├─ api_client.dart
 │   │   └─ dio_config.dart
 │   ├─ services/
 │   │   └─ local_storage.dart
 │   └─ utils/
 │       └─ logger.dart
 ├─ features/
 │   ├─ auth/
 │   │   ├─ data/
 │   │   │   ├─ auth_repository.dart
 │   │   │   └─ auth_api.dart
 │   │   ├─ domain/
 │   │   │   ├─ models/
 │   │   │   │   └─ user_model.dart
 │   │   │   └─ entities/
 │   │   ├─ presentation/
 │   │   │   ├─ providers/
 │   │   │   │   ├─ auth_provider.dart
 │   │   │   │   └─ auth_provider.g.dart
 │   │   │   ├─ screens/
 │   │   │   │   └─ login_screen.dart
 │   │   │   └─ widgets/
 │   │   │       └─ login_form.dart
 │   ├─ expenses/
 │   │   ├─ data/
 │   │   │   ├─ expense_repository.dart
 │   │   │   └─ expense_api.dart
 │   │   ├─ domain/
 │   │   │   └─ models/expense_model.dart
 │   │   ├─ presentation/
 │   │   │   ├─ providers/
 │   │   │   │   ├─ expense_provider.dart
 │   │   │   │   └─ expense_provider.g.dart
 │   │   │   ├─ screens/
 │   │   │   │   ├─ expense_list_screen.dart
 │   │   │   │   └─ expense_add_screen.dart
 │   │   │   └─ widgets/
 │   │   │       └─ expense_tile.dart
 ├─ router/
 │   └─ app_router.dart
 └─ theme/
     ├─ app_theme.dart
     └─ text_styles.dart
