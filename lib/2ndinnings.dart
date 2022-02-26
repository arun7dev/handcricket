import 'dart:math';
import "dart:async";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handcricket/main.dart';

import 'package:delayed_display/delayed_display.dart';

class secondInnings extends StatefulWidget {

  final scoretobeat;
  secondInnings(@required this.scoretobeat);
  @override
  _secondInningsState createState() => _secondInningsState();
}

class _secondInningsState extends State<secondInnings> {

  var player1ScoreToBeat=0;
  var player1CurrentScoreString = "";
  var player2CurrentScoreString = "";
  var player1CurrentScoreInt = 0;
  var player2CurrentScoreInt = -1;
  var totalPlayer1String="";
  var totalPlayer2String="";
  var totalPlayer1Int=0;
  var totalPlayer2Int=0;
  var i=0;
  var bat=false;
  var player1or2=1;

  showWidget(){
    if(widget.scoretobeat == (totalPlayer1Int-player1CurrentScoreInt)){
      return const Text("Draw",textScaleFactor: 7,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),);
    }
    else if(widget.scoretobeat > (totalPlayer1Int)){
      return Column(
        children: const [
          Text("Player",textScaleFactor: 3,style: TextStyle(color: Colors.white),),
          Text("1",textScaleFactor: 10,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          Text("Wins",textScaleFactor: 3,style: TextStyle(color: Colors.white),)
        ],
      );
    }else if(widget.scoretobeat < (totalPlayer1Int)){
      return Column(
        children: const [
          Text("Player",textScaleFactor: 3,style: TextStyle(color: Colors.white),),
          Text("2",textScaleFactor: 10,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          Text("Wins",textScaleFactor: 3,style: TextStyle(color: Colors.white),)
        ],
      );
    }

  }



  playerScoreCard (){

      return DelayedDisplay(
        delay: const Duration(milliseconds: 500),
        child: Column(
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
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: showWidget()),

                        ElevatedButton(onPressed: (){
                          player1ScoreToBeat=totalPlayer1Int;
                          player1or2=2;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));

                        }, child: const Text("Play Again"))
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
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: showWidget()),

                      ElevatedButton(onPressed: (){
                        player1ScoreToBeat=totalPlayer1Int;
                        player1or2=2;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));

                      }, child: const Text("Play Again"))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ((player1CurrentScoreInt==player2CurrentScoreInt && bat==false)||(widget.scoretobeat<totalPlayer1Int && bat==false))? playerScoreCard():RotatedBox(
        quarterTurns: 2,
        child: Column(
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
                    quarterTurns:2,child: Text("Awaiting Bowler")):const RotatedBox(quarterTurns:2,child: Text("BAT")
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
                        RotatedBox(quarterTurns:2,child: Text("Score to beat : ${widget.scoretobeat}  Player 2 score : $totalPlayer1String",style: const TextStyle(fontWeight: FontWeight.bold ),)),
                      ],
                    ),
                    const Divider(
                      color: Colors.yellow,
                      thickness: 3,


                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Score to beat : ${widget.scoretobeat}  Player 2 score : $totalPlayer1String",style: const TextStyle(fontWeight: FontWeight.bold ),),
                      ],
                    )
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
      ),
    );
  }
}
