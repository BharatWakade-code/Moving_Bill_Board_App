import 'package:betasys_task/common/api_urls.dart';
import 'package:betasys_task/models/get_all_model.dart';
import 'package:betasys_task/network_services/network.dart';
import 'package:either_dart/either.dart';

class LoginRepo {
  Future<Either<Exception, dynamic>> login(request) async {
    try {
      final response = await ApiClient()
          .postApi("http://10.0.2.2:3000/login", request);
      final responseData = GetAllPostResponseModel.fromJson(response.data);

      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

   Future<Either<Exception, dynamic>> signup(request) async {
    try {
      final response = await ApiClient()
          .postApi("http://10.0.2.2:3000/signup", request);
      final responseData = GetAllPostResponseModel.fromJson(response.data);

      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
