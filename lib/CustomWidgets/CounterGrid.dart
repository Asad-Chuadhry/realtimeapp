

import 'package:flutter/material.dart';

class CounterGrid extends StatelessWidget {
  final List<Widget> children;
  CounterGrid(this.children);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            children[0],
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
            children[1],
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            children[2],
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
            children[3],
          ],
        )
      ],
    );
  }
}
