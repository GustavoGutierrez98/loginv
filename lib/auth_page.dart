import 'package:flutter/material.dart';
import 'package:loginv3/login_widget.dart';
import 'package:loginv3/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin 
  ? LoginWidget(onClickedSignUp: toggle) 
  : SignUpWidget(onClickedSignIn: toggle);

  void toggle()=>setState(() => isLogin = !isLogin);
}