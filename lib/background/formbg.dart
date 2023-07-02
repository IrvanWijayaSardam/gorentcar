import 'package:flutter/material.dart';

class formbackground extends StatelessWidget {
  const formbackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/formbg.png"), fit: BoxFit.cover)),
    );
  }
}
