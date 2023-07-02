import 'package:flutter/material.dart';

class homebackground extends StatelessWidget {
  const homebackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/Home.png"), fit: BoxFit.cover)),
    );
  }
}
