import 'package:animation2/screen2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'tween_sequence_box.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(bottom: 20, right: 10),
        child:
                  FloatingActionButton(
                    child: Icon(Icons.keyboard_arrow_right),
                    onPressed: () {Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, anotherAnimation) {
                      return Screen2();
                    },
                    transitionDuration: Duration(milliseconds: 2000),
                    transitionsBuilder:
                        (context, animation, anotherAnimation, child) {
                      return FadeTransition(
                        opacity:animation,
                        child: child,
                      );
                    }));
                    }
                    ),
        )
      ,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
        body: DefaultTextStyle(
    style: TextStyle(
      inherit: true,
      fontSize: 20.0,
    ),
    child: Container(
       decoration: BoxDecoration(
        image: DecorationImage(
    image: NetworkImage("https://r1.ilikewallpaper.net/iphone-wallpapers/download/10323/Scripture-iphone-wallpaper-ilikewallpaper_com_200.jpg"),
    fit: BoxFit.fill
        ),
        color: Colors.black,
        border: Border.all(
    color: Colors.white,
    width:20
        )
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 250),
          child: TweenSequenceBox()
        ),
      ),
    ),
        ),
      );
  }
}