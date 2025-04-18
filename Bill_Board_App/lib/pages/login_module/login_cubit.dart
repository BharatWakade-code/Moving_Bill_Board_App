import 'dart:convert';

import 'package:betasys_task/pages/login_module/data/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginRepo repository = LoginRepo();

  Future<void> getLogin(String mobile, String pass) async {
    emit(LoginLoading());

    final jsonBody = jsonEncode({"mobile": mobile, "password": pass});

    Either<Exception, dynamic> either = await repository.login(jsonBody);

    either.fold(
        (error) => emit(LoginError()), (response) => emit(LoginSuccess()));
  }

  Future<void> signup(String name, String mobile, String pass) async {
    emit(LoginLoading());

    final jsonBody =
        jsonEncode({"name": name, "mobile": mobile, "password": pass});

    Either<Exception, dynamic> either = await repository.signup(jsonBody);

    either.fold(
        (error) => emit(LoginError()), (response) => emit(LoginSuccess()));
  }
}
