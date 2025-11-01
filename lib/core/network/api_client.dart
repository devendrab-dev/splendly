import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:money_tracker/core/network/app_failure.dart';

class ApiClient {
  final Dio dio;
  ApiClient({required this.dio});

  Future<Either<Response, ResFailure>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      Response response = await dio.post(path, data: body);
      return left(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return right(ResFailure(message: e.response?.data["message"]));
      }
      return right(
        ResFailure(message: "An unexpected error occured"),
      );
    } catch (e) {
      return right(ResFailure());
    }
  }
}
