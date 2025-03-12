import 'package:betasys_task/common/api_urls.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options
      ..baseUrl = Constants.baseurl
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 15);
  }

  Future<Response<dynamic>> getRequest(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      print('response ${response}');

      print('url  ${response.realUri}');
      return response;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      rethrow;
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteRequest(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      rethrow;
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }
}
