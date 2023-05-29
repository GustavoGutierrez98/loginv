import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginv3/main.dart';
import 'package:loginv3/utils.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
    }):super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child:Form(
      key: formKey,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        FlutterLogo(size: 120),
        SizedBox(height: 20),
        Text('Que tal, Bienvenido de vuelta',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32,fontWeight: FontWeight.normal)        
        ),
        SizedBox(height: 40),
        TextFormField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Email'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (email)=>
          email !=null && EmailValidator.validate(email)
          ? 'ingresa un correo electronico valido'
          : null,
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: passwordController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value)=>value !=null && value.length < 6
          ? 'Ingresa un minimo de 6 caracteres'
          : null,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(Icons.arrow_forward, size: 30),
        label: Text('Registrarse',
        style: TextStyle(fontSize: 24),
        ),
        onPressed: signUp,
        ),
        SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.white),
            text: 'Ya tienes una cuenta?',
            children: [
          TextSpan(recognizer: TapGestureRecognizer()
          ..onTap = widget.onClickedSignIn,
          text: 'Iniciar sesion',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.secondary)
          ),
            ]
            )
          )
      ],
      ),
    )
    
  );
  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context)=> Center(child: CircularProgressIndicator(),)
    );

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        );
    }
    on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}