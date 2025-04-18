import 'package:betasys_task/common/api_urls.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options
      // ..baseUrl = Constants.baseurl
      ..connectTimeout = const Duration(seconds: 100)
      ..receiveTimeout = const Duration(seconds: 150);
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

  Future<Response<dynamic>> postApi(String endpoint, request) async {
    try {
      print('endpoint: $endpoint');
      print('Request: $request');

      final response = await _dio.post(endpoint, data: request);
      print('response: $response');

      return response;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      if (e.response != null) {
        if (e.response?.statusCode == 400) {
          throw Exception('Bad Request: ${e.response?.data}');
        } else if (e.response?.statusCode == 500) {
          throw Exception('Internal Server Error: ${e.response?.data}');
        }
      } else {
        print('DioException: ${e.message}');
      }
      rethrow;
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }
}
