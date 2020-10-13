import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtimeapp/CustomWidgets/AppBar.dart';
import 'package:realtimeapp/CustomWidgets/CounterGrid.dart';
import 'package:web_socket_channel/io.dart';

import 'CustomWidgets/CounterBox.dart';
import 'CustomWidgets/MyBottomBar.dart';
import 'Model/Count.dart';
void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealTime App',
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 80
          )
        ),
        primarySwatch: Colors.blue,
       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final channel = IOWebSocketChannel.connect('ws://10.0.2.2:3000');
  AnimationController _animationControllerCountOne;
  AnimationController _animationControllerCountTwo;
  AnimationController _animationControllerCountThree;
  AnimationController _animationControllerCountFour;



  @override
  void initState(){
    channel.sink.add("init");
    super.initState();
    _animationControllerCountOne=new AnimationController(
      //value: 100,
      lowerBound: 0,
      upperBound: 6,
      vsync: this,
      duration: Duration(seconds: 2)
    );
    _animationControllerCountTwo=new AnimationController(
      //value: 100,
        lowerBound: 0,
        upperBound: 6,
        vsync: this,
        duration: Duration(seconds: 2)
    );
    _animationControllerCountThree=new AnimationController(
      //value: 100,
        lowerBound: 0,
        upperBound: 6,
        vsync: this,
        duration: Duration(seconds: 2)
    );
    _animationControllerCountFour=new AnimationController(
      //value: 100,
        lowerBound: 0,
        upperBound: 6,
        vsync: this,
        duration: Duration(seconds: 2)
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       mainAxisSize: MainAxisSize.max,
       children: [
         MyAppBar(
             Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             SizedBox(height:20),
             Text("RealTime App",
             style: TextStyle(
               fontSize: 35,
               fontStyle: FontStyle.normal
             ),),
             Text("Live Updates",
             style: TextStyle(
               fontSize: 20,
               fontStyle: FontStyle.normal
             ),),
             SizedBox(height:15),
             Text("Flutter    NodeJs    MySQL",
               style: TextStyle(
                   fontSize: 18,
                   fontStyle: FontStyle.normal,
                   fontWeight: FontWeight.normal,
                   color: Colors.cyanAccent
               ),),
           ],
         )),
         SizedBox(height: MediaQuery.of(context).size.height*0.1,),
         StreamBuilder(
           initialData: "null",
           stream: channel.stream,
           builder: (context, snapshot) {
             if(snapshot.data=="null") return Center(child: CupertinoActivityIndicator(radius: 50,),);
             else {

               List<Count> countList = (json.decode(snapshot.data) as List)
                   .map((i) =>
                   Count.fromJson(i)).toList();
               if(countList[4].count==1)
               _animationControllerCountOne
                   .forward()
                   .then((value) => _animationControllerCountOne.reset());
               else if(countList[4].count==2)
                 _animationControllerCountTwo
                     .forward()
                     .then((value) => _animationControllerCountTwo.reset());
               else if(countList[4].count==3)
                 _animationControllerCountThree
                     .forward()
                     .then((value) => _animationControllerCountThree.reset());
               else if(countList[4].count==4)
                 _animationControllerCountFour
                     .forward()
                     .then((value) => _animationControllerCountFour.reset());
               //return Text(countList[0].count.toString());
               return CounterGrid([
                 CounterBox(
                     GestureDetector(
                       onTap: () {
                         channel.sink.add("1");
                       },
                       child: AnimatedBuilder(
                         child: Text(countList[0].count.toString()),
                         animation: _animationControllerCountOne,
                         builder: (context, child) {
                           return Transform.rotate(
                             child: child,
                             angle: _animationControllerCountOne.value,
                           );
                         },
                       ),
                     )),
                 CounterBox(
                     GestureDetector(
                       onTap: () {
                         channel.sink.add("2");
                       },
                       child: AnimatedBuilder(
                         child: Text(countList[1].count.toString()),
                         animation: _animationControllerCountTwo,
                         builder: (context, child) {
                           return Transform.rotate(
                             child: child,
                             angle: _animationControllerCountTwo.value,
                           );
                         },
                       ),
                     )),
                 CounterBox(
                     GestureDetector(
                       onTap: () {
                         channel.sink.add("3");
                       },
                       child: AnimatedBuilder(
                         child: Text(countList[2].count.toString()),
                         animation: _animationControllerCountThree,
                         builder: (context, child) {
                           return Transform.rotate(
                             child: child,
                             angle: _animationControllerCountThree.value,
                           );
                         },
                       ),
                     )),
                 CounterBox(
                     GestureDetector(
                       onTap: () {
                         channel.sink.add("4");
                       },
                       child: AnimatedBuilder(
                         child: Text(countList[3].count.toString()),
                         animation: _animationControllerCountFour,
                         builder: (context, child) {
                           return Transform.rotate(
                             child: child,
                             angle: _animationControllerCountFour.value,
                           );
                         },
                       ),
                     )),
               ]);
             }
           }
         )
       ],
     ),
     bottomNavigationBar: MyBottomBar(
       GestureDetector(
         child: RaisedButton.icon(
           color: Colors.white,
             onPressed: (){
                channel.sink.add("clear");
             },
             label: Icon(Icons.delete,size: 40,),
             icon: Text("")),
       )
     ),
    );
  }
}
