import 'package:flutter/material.dart';

class formVerifikasiBg extends StatelessWidget {
  const formVerifikasiBg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/formverifikasi.png"), fit: BoxFit.cover)),
    );
  }
}
