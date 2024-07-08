import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pet_style/core/services/storage_services.dart';
import 'package:pet_style/core/values/constants.dart';
import 'package:pet_style/data/model/auth_response/auth_response.dart';
import 'package:pet_style/domain/repository/auth_repository.dart';

class AuthInterceptor implements InterceptorsWrapper {
  final Dio dio;
  final AuthRepository authRepository = GetIt.I<AuthRepository>();
  final InternetConnection connectionChecker = GetIt.I<InternetConnection>();

  AuthInterceptor({required this.dio});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken =
        StorageServices.getString(AppConstants.STORAGE_ACCESS_TOKEN);
    if (accessToken != null) {
      options.headers['Authorization'] = accessToken;
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken =
          StorageServices.getString(AppConstants.STORAGE_REFRESH_TOKEN);
      if (refreshToken != null) {
        try {
          final AuthResponse? newTokens =
              await authRepository.refreshToken(refreshToken);
          if (newTokens != null) {
            await StorageServices.setString(
                AppConstants.STORAGE_ACCESS_TOKEN, newTokens.accessToken!);
            await StorageServices.setString(
                AppConstants.STORAGE_REFRESH_TOKEN, newTokens.refreshToken!);

            final newOptions = Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': '${newTokens.accessToken}',
              },
            );

            final cloneReq = await dio.request(
              err.requestOptions.path,
              options: newOptions,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            return handler.resolve(cloneReq);
          }
        } catch (e) {
          await authRepository.logOut();
        }
      }
    }
    return handler.next(err);
  }
}
