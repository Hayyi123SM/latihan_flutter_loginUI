import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/Login.dart';
import 'package:login_ui/dashboard.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Streambuilder digunakan untuk mengecek data sercara realtime pada firebase
    return StreamBuilder<User?>(
      // Melakukan instansiasi firebase
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        // Mengecek data snapshot
        if(snapshot.hasData){
          return Dashboard();
        }else{
          return LoginDemo();
        }
      }
    );
  }
}
