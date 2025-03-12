part of 'get_all_post_cubit.dart';

@immutable
sealed class GetAllPostState {}

final class GetAllPostInitial extends GetAllPostState {}

final class GetAllPostLoading extends GetAllPostState {}

final class GetAllPostSuccess extends GetAllPostState {}

final class GetAllPostError extends GetAllPostState {}

final class GetDeleteSuccess extends GetAllPostState {
  final String msg;
  GetDeleteSuccess({required this.msg});
}

final class GetDeleteError extends GetAllPostState {
  final String msg;
  GetDeleteError({required this.msg});
}
