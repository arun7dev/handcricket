import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:handcricket/2ndinnings.dart';

import 'package:delayed_display/delayed_display.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var player1ScoreToBeat=0;
  var player1CurrentScoreString = "";
  var player2CurrentScoreString = "";
  var player1CurrentScoreInt = 0;
  var player2CurrentScoreInt = -1;
  var totalPlayer1String="";
  var totalPlayer2String="";
  var totalPlayer1Int=0;
  var totalPlayer2Int=0;

  var bat=false;
  var player1or2=1;

  @override
  Widget build(BuildContext context) {
DelayedWidget(){
  return Stack(
    children: [
       Scaffold(
        backgroundColor: Colors.blue,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              RotatedBox(quarterTurns:2,child: Center(child: Text("OUT!",textScaleFactor: 10  ,style: TextStyle(fontStyle: FontStyle.italic,color: Colors.yellow,fontWeight: FontWeight.bold),))),
              Divider(
                thickness: 2,
                color: Colors.white,
              ),
              Center(child: Text("OUT!",textScaleFactor: 10  ,style: TextStyle(fontStyle: FontStyle.italic,color: Colors.red,fontWeight: FontWeight.bold),)),

            ],
          )),
      DelayedDisplay(
        delay: const Duration(milliseconds: 500),
        child:ScoreCardAfterFirstInnings(totalPlayer1Int: totalPlayer1Int, player1CurrentScoreInt: player1CurrentScoreInt)
      ),
    ],
  );
}

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.black,

      body: (player1CurrentScoreInt==player2CurrentScoreInt && bat==false)?DelayedWidget():Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(

            flex:1,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5);
                    } else if (states.contains(MaterialState.disabled)) {
                      return Colors.blue.shade200;
                    }
                    return Colors.blue; // Use the component's default.
                  },
                ),
              ),
              child:bat? const RotatedBox(
                  quarterTurns:2,child: Text("Awaiting bowler")):const RotatedBox(quarterTurns:2,child: Text("BAT")
              ),
              onPressed:!bat?(){
                setState(() {
                  player1CurrentScoreInt=Random().nextInt(7);
                  player1CurrentScoreString = player1CurrentScoreInt.toString();
                  totalPlayer1Int +=player1CurrentScoreInt;
                  totalPlayer1String =totalPlayer1Int.toString();
                  bat?bat=false:bat=true;


                });
              } :null,
            ),),
          Expanded(

            flex:4,
            child: Container(
             color: Colors.yellow,
             child: FittedBox(child: RotatedBox(
                 quarterTurns: 2,
                 child: Text(player1CurrentScoreString,style: TextStyle(color: Colors.yellow.shade900),))),
            ),
          ),

          Expanded(

            flex:1,
            child: ElevatedButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RotatedBox(quarterTurns: 2,
                        child: Text("Player 1 score :$totalPlayer1String",style: const TextStyle(fontWeight: FontWeight.bold ),),),
                    ],
                  ),
                  const Divider(
                    color: Colors.yellow,
                    thickness: 3,


                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Player 1 score :$totalPlayer1String",style: const TextStyle(fontWeight: FontWeight.bold ),),
                    ],
                  ),


                ],
              ),
              onPressed: (){},

            ),),

          Expanded(

            flex:4,
            child: Container(
             color: Colors.yellow,
              child: FittedBox(child: !bat?Text(player2CurrentScoreString,style: TextStyle(color: Colors.yellow.shade900),):Text("")),
            ),
          ),
          Expanded(

            flex:1,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5);
                    } else if (states.contains(MaterialState.disabled)) {
                      return Colors.blue.shade200;
                    }
                    return Colors.blue; // Use the component's default.
                  },
                ),
              ),
              child: bat? const Text("BOWL"):const Text("Awaiting Batter"),
              onPressed:bat?(){
                setState(() {
                  player2CurrentScoreInt=Random().nextInt(7);
                  player2CurrentScoreString = player2CurrentScoreInt.toString();
                  totalPlayer2Int +=player2CurrentScoreInt;
                  totalPlayer2String =totalPlayer2Int.toString();
                  bat?bat=false:bat=true;

                });

              } :null,
            ),),
        ],
      ),
    );
  }
}

class ScoreCardAfterFirstInnings extends StatelessWidget {
  const ScoreCardAfterFirstInnings({
    Key? key,
    required this.totalPlayer1Int,
    required this.player1CurrentScoreInt,
  }) : super(key: key);

  final int totalPlayer1Int;
  final int player1CurrentScoreInt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: RotatedBox(
              quarterTurns: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blue, Colors.purple],
                        //
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Player 1 score",textScaleFactor: 3,style: TextStyle(color: Colors.white),),
                      Center(child: Text((totalPlayer1Int-player1CurrentScoreInt).toString(),textScaleFactor: 10,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                      ElevatedButton(onPressed: (){

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>secondInnings(totalPlayer1Int-player1CurrentScoreInt)));

                      }, child: const Text("Start 2nd Innings")),
                    //  const Text("Rotate phone 180°",style: TextStyle(color: Colors.white70),textScaleFactor: 1,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.purple],
                      //
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Player 1 score",textScaleFactor: 3,style: TextStyle(color: Colors.white),),
                    Center(child: Text((totalPlayer1Int-player1CurrentScoreInt).toString(),textScaleFactor: 10,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                    ElevatedButton(onPressed: (){

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>secondInnings(totalPlayer1Int-player1CurrentScoreInt)));

                    }, child: const Text("Start 2nd Innings")),
                  //  const Text("Rotate phone 180°",style: TextStyle(color: Colors.white70),textScaleFactor: 1,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

