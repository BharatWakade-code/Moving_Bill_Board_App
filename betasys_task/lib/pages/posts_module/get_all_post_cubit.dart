import 'package:betasys_task/models/delete_response_model.dart';
import 'package:betasys_task/models/get_all_model.dart';
import 'package:betasys_task/pages/posts_module/data/get_all_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

part 'get_all_post_state.dart';

class GetAllPostCubit extends Cubit<GetAllPostState> {
  GetAllPostCubit() : super(GetAllPostInitial());

  GetAllRepository repository = GetAllRepository();

  Future<void> getAllPost() async {
    emit(GetAllPostLoading());
    Either<Exception, GetAllPostResponseModel> either =
        await repository.getAllPostData();

    either.fold((error) => emit(GetAllPostError()),
        (response) => getAllPostResponse(response));
  }

  List<Posts> getAllPosts = [];

  void getAllPostResponse(GetAllPostResponseModel response) {
    if (response.total != 0) {
      getAllPosts = response.posts ?? [];
      emit(GetAllPostSuccess());
    } else {
      emit(GetAllPostError());
    }
  }

  Future<void> deletePost(int postId) async {
    emit(GetAllPostLoading());
    Either<Exception, DeleteResponseModel> either =
        await repository.getDeletePostData(postId);

    either.fold((error) => emit(GetDeleteError(msg: 'Post delete error')),
        (response) => getDeletePostResponse(response));
  }

  dynamic deletedPost = Posts();

  void getDeletePostResponse(DeleteResponseModel response) {
    if (response != null) {
      deletedPost = response;
      emit(GetDeleteSuccess(msg: 'Post delete succesfully'));
    } else {
      emit(GetDeleteError(msg: 'Post delete error'));
    }
  }
}
