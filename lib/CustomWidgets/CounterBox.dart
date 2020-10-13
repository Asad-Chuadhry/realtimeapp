

import 'package:flutter/material.dart';

class CounterBox extends StatelessWidget {
  final Widget child;
  CounterBox(this.child);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: child,
      width: MediaQuery.of(context).size.width*0.4,
      height: MediaQuery.of(context).size.height*0.2,
      decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
      color: Colors.purple,
      spreadRadius: 4,
      ),
      ],
      color: Colors.deepPurple[900],
      borderRadius: BorderRadius.all(
        Radius.elliptical(50, 200),
      ),
      )
    );
  }
}
