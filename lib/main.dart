import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginv3/utils.dart';
import 'auth_page.dart';
import 'home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget{
  static const String title = 'Setup Firebase';

@override
Widget build(BuildContext context) => MaterialApp(
  scaffoldMessengerKey: Utils.messengerKey,
  navigatorKey: navigatorKey,
  debugShowCheckedModeBanner: false,
  title: title,
  theme: ThemeData(primarySwatch: Colors.blue),
  home:MainPage(),
);
}

  
class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context)=>Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }
      else if(snapshot.hasError){
        return Center(child: Text('Algo salio mal!'));
      }
      else if(snapshot.hasData){
        return HomePage();
      }
      else{
        return AuthPage();
      }
    }
    )
  );
}

