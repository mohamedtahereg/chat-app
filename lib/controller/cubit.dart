import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:to_do/view/chat_page.dart';
import 'package:to_do/view/sign_in.dart';

import 'cubit_states.dart';

class AppCubit extends Cubit<CubitStates> {
  AppCubit() : super(InitState());
  static AppCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    print("1");
    emit(LoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      Get.off(HomePage(), arguments: email);
    }).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  void userRegister({
    required String email,
    required String password,
  }) {
    print("1");
    emit(RegisterState());
    {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value.user!.email);
        print(value.user!.uid);

        emit(SuccessState());

        Get.off(SignIn());
      }).catchError((error) {
        emit(ErrorState(error.toString()));
      });
    }
  }
}
