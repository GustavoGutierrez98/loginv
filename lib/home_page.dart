import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title:const Text('My App'),
        backgroundColor: Colors.deepOrange,
      ),
      body: 
      Padding(padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Ingresado como:',style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(user.email!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
    ),
    icon: const Icon(Icons.lock_open,size: 32),
    label: const Text('Salir',style: TextStyle(fontSize: 24),
    ),
    onPressed:()=>FirebaseAuth.instance.signOut(),
    ),
        ]
        ),
      ),
      
    );
  }
}