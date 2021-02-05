import 'package:chat_app/app/custom_widgets/firebase_auth_exception_alert_dialog.dart';
import 'package:chat_app/app/pages/login/email_sign_in_button.dart';
import 'package:chat_app/app/pages/login/email_sign_in_page.dart';
import 'package:chat_app/app/pages/login/facebook_sign_in_button.dart';
import 'package:chat_app/app/pages/login/login_manager.dart';
import 'package:chat_app/app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);

  final LoginManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<LoginManager>(
          create: (_) => LoginManager(auth: auth, isLoading: isLoading),
          child: Consumer<LoginManager>(
            builder: (context, manager, _) => LoginPage(
              isLoading: isLoading.value,
              manager: manager,
            ),
          ),
        ),
      ),
    );
  }

  _showSignInError(BuildContext context, FirebaseAuthException exception) {
    FirebaseAuthExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on FirebaseAuthException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }


  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FacebookSignInButton(
            assetPath: 'images/facebook-logo.png',
            title: 'Sign in with Facebook',
            titleColor: Colors.white,
            color: Color(0xff334d92),
            onPressed: () => _signInWithFacebook(context),
            radius: 8.0,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'or',
            style: TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          EmailSignInButton(
            title: 'Sign in with Email',
            titleColor: Colors.white,
            color: Colors.green,
            onPressed: () => _signInWithEmail(context),
            radius: 8.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }

}
