import 'package:animation2/screen2.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: Text(name,style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                  //  fontFamily: 'Pacifico-Regular'
                                  ),
                                  ),
            backgroundColor: Colors.black,
            leading: Hero(
                  tag: 'Profile-Picture',
                          child: CircleAvatar(
                backgroundImage: NetworkImage(url),
              ),
            ) 
                       
          ),
          body: Container(
                height: devicedata.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://r1.ilikewallpaper.net/iphone-wallpapers/download/10323/Scripture-iphone-wallpaper-ilikewallpaper_com_200.jpg"),
                        fit: BoxFit.fill),
                    color: Colors.black,
                    // border: Border.all(color: Colors.white, width: 15)
                    ),
        )
        )
      
    );
  }
}