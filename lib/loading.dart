import 'package:flutter/material.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}