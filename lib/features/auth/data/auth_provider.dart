import 'package:money_tracker/core/network/end_point.dart';
import 'package:money_tracker/core/providers/global_providers.dart';
import 'package:money_tracker/features/auth/data/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    state = AsyncValue.loading();
    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.post(EndPoint.login, {
      'email': email,
      'password': password,
    });
    response.match(
      (data) {
        final user = UserModel.fromJson(data.data);
        state = AsyncData(user);
      },
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }
}
