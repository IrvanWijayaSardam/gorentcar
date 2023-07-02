import 'package:flutter/material.dart';

class detailbackground extends StatelessWidget {
  const detailbackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/detailbg.png"), fit: BoxFit.cover)),
    );
  }
}
