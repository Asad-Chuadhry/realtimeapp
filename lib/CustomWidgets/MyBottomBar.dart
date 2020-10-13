

import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  final Widget child;
  MyBottomBar(this.child);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: child,
      height: MediaQuery.of(context).size.height*0.08,
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
            topLeft: Radius.elliptical(40, 100),
            topRight: Radius.elliptical(40, 100),
          )
      ),
    );
  }
}
