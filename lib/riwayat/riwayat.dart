import 'package:flutter/material.dart';

class riwayat extends StatefulWidget {
  const riwayat({super.key});

  @override
  State<riwayat> createState() => _riwayatState();
}

class _riwayatState extends State<riwayat> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Riwayat",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
