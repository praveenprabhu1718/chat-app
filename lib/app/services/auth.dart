import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class EndUser {
  EndUser({@required this.uid,@required this.email});

  final String uid;
  final String email;
}

abstract class AuthBase {
  Stream<EndUser> get onStateChanged;
  Future<EndUser> getCurrentUser();
  Future<void> signOut();
  Future<EndUser> signInWithFacebook();
  Future<EndUser> signInWithEmailAndPassword(String email, String password);
  Future<EndUser> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  EndUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return EndUser(uid: user.uid, email: user.email);
  }

  @override
  Stream<EndUser> get onStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<EndUser> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<EndUser> signInWithFacebook() async{
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(
        ['email']
    );
    if(result.accessToken != null){
      final authResult = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(result.accessToken.token)
      );
      return _userFromFirebase(authResult.user);
    } else{
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<EndUser> signInWithEmailAndPassword(String email, String password) async{
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<EndUser> createUserWithEmailAndPassword(String email, String password) async{
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
