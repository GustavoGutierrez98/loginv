import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginv3/main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }): super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) =>SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: Column(mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const SizedBox(height: 40),
    TextField(
      controller: emailController,
      cursorColor: Colors.orange,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(labelText: 'Correo Electronico'),
    ),
    const SizedBox(height: 4,),
    TextField(
      controller: passwordController,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(labelText: 'Contraseña'),
      obscureText: true,
    ),
    const SizedBox(height: 20),
    ElevatedButton.icon(style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)
    ),
    icon: Icon(Icons.lock_open,size: 32),
    label: Text('Iniciar',style: TextStyle(fontSize: 24),
    ),
    onPressed: signIn,
    ),
    SizedBox(height: 24),
    RichText(text: TextSpan(
      style: TextStyle(color: Colors.white, fontSize:20),
      text: 'No tienes cuenta?',
      children: [
        TextSpan(
          recognizer: TapGestureRecognizer()
          ..onTap = widget.onClickedSignUp,
          text: 'Crear cuenta',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.secondary)
          )
      ]
    )
    )
  ],
  ),
  );

  Future signIn() async {
    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context)=>Center(child: CircularProgressIndicator())
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim()
      );
    }
    on FirebaseAuthException catch (e){
      print(e);
    }
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}