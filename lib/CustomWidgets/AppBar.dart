

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Widget child;
  MyAppBar(this.child);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: child,
      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.purple,
            spreadRadius: 4,
          ),
        ],
        color: Colors.deepPurple[900],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(50, 200),
            bottomRight: Radius.elliptical(50, 200),
        )
      ),
    );
  }
}
