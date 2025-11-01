import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/core/network/api_client.dart';
import 'package:money_tracker/core/network/dio_config.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(dio: ref.read(dioProvider));
});

final isLoginProvider = StateProvider<bool>((ref) {
  return false;
});
