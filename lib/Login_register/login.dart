import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      // Proses Login
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // periksa email apakah ada di document id dari collection admins
      QuerySnapshot adminsSnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .where(FieldPath.documentId, isEqualTo: email)
          .get();

      // menentukan admin atau bukan
      if (adminsSnapshot.docs.isNotEmpty) {
        Navigator.pushNamed(context, '/adminHome');
      } else {
        Navigator.pushNamed(context, '/userHome');
      }
    } catch (e) {
      // Tangani kesalahan saat login
      print('Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text("Daftar disini"))
          ],
        ),
      ),
    );
  }
}
