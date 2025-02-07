import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlutterLogo(size: 200),
          LinearProgressIndicator(),
          Text("Flutter"),
          TextButton(onPressed: () async{
            SharedPreferences pref= await SharedPreferences.getInstance();

            pref.setBool("isintroscreenvisited", true);

            Navigator.of(context).pushReplacementNamed("/");
          },
              child: Text("Start"))
        ],
      ),
    );
  }
}

