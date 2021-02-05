import 'package:chat_app/app/services/auth.dart';
import 'package:flutter/foundation.dart';

class LoginManager {
  LoginManager({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;


  Future<EndUser> signIn(Future<EndUser> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<EndUser> signInWithFacebook() async => await signIn(auth.signInWithFacebook);
}
