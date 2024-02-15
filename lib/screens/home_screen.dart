import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int minute25 = 1500;
  int totalSeconds = minute25;
  bool isRunning = false;
  int totalPomodoros = 0;

  late Timer timer;

  void onTick(Timer timer){
    if(totalSeconds == 1){
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        totalSeconds = minute25;
      });
      timer.cancel();
    }
    else {
      setState(() {
        totalSeconds -= 1;
      });
    };
  }

  void onPausePressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStartButtonPressed(){
    timer = Timer.periodic(
        const Duration(seconds: 1),
        onTick
    );
    setState(() {
      isRunning = true;
    });
  }

  void onStopButtonPressed(){
    try{
      timer.cancel();
    }
    catch(e){
      timer = Timer.periodic(
          const Duration(seconds: 1),
          onTick
      );
      timer.cancel();
    }

    setState(() {
      totalSeconds = minute25;
      isRunning = false;
    });
  }

  void onResetButtonPressed(){
    try{
      timer.cancel();
    }
    catch(e){
      timer = Timer.periodic(
          const Duration(seconds: 1),
          onTick
      );
      timer.cancel();
    }

    setState(() {
      totalSeconds = minute25;
      isRunning = false;
      totalPomodoros = 0;
    });
  }
  
  String format(int seconds){
    Duration duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 86,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        icon: Icon(isRunning ? Icons.pause_circle_outline : Icons.play_circle_outline),
                        onPressed: isRunning ? onPausePressed : onStartButtonPressed,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: onResetButtonPressed,
                        icon: const Icon(Icons.restart_alt_rounded),
                        color: Theme.of(context).cardColor,
                        iconSize: 60,
                      ),
                      IconButton(
                        onPressed: onStopButtonPressed,
                        icon: const Icon(Icons.stop_circle_outlined),
                        color: Theme.of(context).cardColor,
                        iconSize: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "$totalPomodoros",
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
