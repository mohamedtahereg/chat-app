abstract class CubitStates {}

class InitState extends CubitStates {}

class RegisterState extends CubitStates {}

class LoginState extends CubitStates {}

class SuccessState extends CubitStates {}

class ErrorState extends CubitStates {
  ErrorState(String string);
}
