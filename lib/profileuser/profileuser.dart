import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

final phone = "90441539202";
final user = "Wahyu";
final alamat = "Purwokerto";
final email = "Wahyu@gmail.com";
final nama = "Dwi Wahyu Nugroho";

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(152, 64, 99, 1),
        body: SafeArea(
            minimum: const EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/profilimage.jpg")),
                Text(
                  nama,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                profileinfo(text: user, icon: Icons.person, onPressed: () {}),
                profileinfo(text: phone, icon: Icons.phone, onPressed: () {}),
                profileinfo(
                    text: alamat, icon: Icons.pin_drop, onPressed: () {}),
                profileinfo(text: email, icon: Icons.email, onPressed: () {}),
              ],
            )));
  }
}

class profileinfo extends StatelessWidget {
  final String text;
  final IconData icon;
  Function onPressed;
  profileinfo(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Color.fromRGBO(65, 67, 106, 1),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Color.fromRGBO(65, 67, 106, 1),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
