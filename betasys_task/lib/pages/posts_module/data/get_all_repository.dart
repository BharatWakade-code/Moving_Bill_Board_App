import 'package:betasys_task/common/api_urls.dart';
import 'package:betasys_task/models/delete_response_model.dart';
import 'package:betasys_task/models/get_all_model.dart';
import 'package:betasys_task/network_services/network.dart';
import 'package:either_dart/either.dart';

class GetAllRepository {
  Future<Either<Exception, GetAllPostResponseModel>> getAllPostData() async {
    try {
      final response = await ApiClient()
          .getRequest(Constants.baseurl + Constants.getAllPost);
      final responseData = GetAllPostResponseModel.fromJson(response.data);

      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, DeleteResponseModel>> getDeletePostData(
      int postId) async {
    try {
      final response = await ApiClient()
          .getRequest('${Constants.baseurl}${Constants.getAllPost}/$postId');
      final responseData = DeleteResponseModel.fromJson(response.data);

      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }


 Future<Either<Exception, DeleteResponseModel>> addPostData(
      int postId, request) async {
    try {
      final response = await ApiClient()
          .getRequest('${Constants.baseurl}${Constants.getAllPost}/$postId' , queryParameters: request);
      final responseData = DeleteResponseModel.fromJson(response.data);

      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

}
