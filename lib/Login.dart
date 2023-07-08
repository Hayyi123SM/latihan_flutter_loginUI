import 'package:flutter/material.dart';
import 'package:login_ui/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginDemo extends StatefulWidget {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

  class _LoginDemoState extends State<LoginDemo> {

  @override
  Widget build(BuildContext context){
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      // Membuat backround dari scaffold menjadi abu-abu dengan kadar 100
      backgroundColor: Colors.grey[100],
      // Membuat agar content bisa di scroll
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Logo Login
            Padding(
            // Memberi jarak berupa padding untuk bagian atas
              padding: const EdgeInsets.only(top: 60.0),
              // Mengatur container di tengah
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  // Menampilkan gambar dan membuatnya menjadi bundar dengan radius
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.asset('assets/logo_login.png'),
                  ),
                ),
              ),
            ),
            // Box kosong untuk mengatur jarak antara widget
            SizedBox(height: 20),
            // TextField dari Email
            Padding(
              // Mengatur padding secara horizontal
              // padding: const EdgeInsets.only(left:15.0,right:15.0,top:0,bottom:0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              // Membuat inputan text Email
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
              ),
            ),
            // Box kosong untuk mengatur jarak antara widget
            SizedBox(height: 13),
            // TextField dari Password
            Padding(
              // Mengatur padding secara horizontal
              padding: EdgeInsets.symmetric(horizontal: 20),
              // Membuat inputan password
              child: TextField(
                controller: passwordController,
                // Membuat agar karakter dari inputan password di hide
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter scure password'
                ),
              ),
            ),
            // Box kosong untuk mengatur jarak antara widget
            SizedBox(height: 13),
            Padding(
              // Mengatur padding secara horizontal
              padding: EdgeInsets.symmetric(horizontal: 15),
              // Membuat sebuah text untuk user lupa password
              child: TextButton(
                onPressed: (){
                  //  TODO FORGOT PASSWORD
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
            // Box kosong untuk mengatur jarak antara widget
            SizedBox(height: 10,),
            Padding(
              // Mengatur padding secara horizontal
              padding: EdgeInsets.symmetric(horizontal: 20),
              // Membuat tombol Login yang panjang nya mengikuti ukuran layar
              child: SizedBox(
                height: 50,
                width: double.infinity,
                // Memuat tombol submit
                child: ElevatedButton(
                  onPressed: () async{
                    //Melakukan cek apakah data / cookie user masih ada
                    if(FirebaseAuth.instance.currentUser == null){
                      // Melakukan try untuk login dengan user & password
                      try{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        );
                        // Mengambil exception ketika terjadi error saat proses login
                      }on FirebaseAuthException catch(e){
                        showNotivication(context, e.message.toString());
                      }
                    }
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
            ),
            // Box kosong untuk mengatur jarak antara widget
            SizedBox(
              height: 10,
            ),
            Padding(
              // Mengatur padding secara horizontal
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                // membuat tombol submit
                child: ElevatedButton(
                      onPressed: () async {
                        // Melakukan try untuk login dengan user & password
                        if(FirebaseAuth.instance.currentUser == null){
                          try{
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            // Mengambil exception ketika terjadi error saat proses login
                          } on FirebaseAuthException catch(e){
                            showNotivication(context, e.message.toString());
                          }
                        }
                      },
                      child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 20),)
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Membuat fungsi notivikasi untuk error proses login & sign up
  void showNotivication(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.yellowAccent.shade700,
      content: Text(message.toString()),));
  }
}