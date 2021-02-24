import 'dart:io';
import 'package:animation2/screen3.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

var name,url;

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin {
  double _visible = 0;
  File _image;

  void open_camera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void open_gallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context).size;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          floatingActionButton: Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(bottom: 20, left: 40),
            child: FloatingActionButton(
              child: Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: DefaultTextStyle(
            style: TextStyle(
              inherit: true,
              fontSize: 20.0,
            ),
            child: SingleChildScrollView(
              child: Container(
                height: devicedata.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://r1.ilikewallpaper.net/iphone-wallpapers/download/10323/Scripture-iphone-wallpaper-ilikewallpaper_com_200.jpg"),
                        fit: BoxFit.fill),
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 20)),
                child: Container(
                    padding: EdgeInsets.only(top: 200),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Enter your name",
                                prefixIcon: Icon(Icons.account_circle),
                              ),
                              onChanged: (value) {
                                name = value;
                              },
                            ),
                          ),
                          Hero(
                                 tag: 'Profile-Picture',
                                                      child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      // _visible =! _visible;
                                      _visible = 1;
                                    });
                                  },
                                  child: _image == null
                                      ? Text(
                                          "📷",
                                          style: TextStyle(
                                            fontSize: 50,
                                          ),
                                        )
                                      : Image.file(
                                          _image,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: <Widget>[
                              AnimatedOpacity(
                                opacity: _visible,
                                duration: Duration(seconds: 1),
                                child: Row(children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    color: Colors.blueGrey.shade600,
                                    onPressed: () {
                                      open_camera();
                                    },
                                    child: Text(
                                      "Open camera",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Pacifico-Regular'),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    color: Colors.blueGrey.shade600,
                                    onPressed: () {
                                      open_gallery();
                                    },
                                    child: Text(
                                      "Open gallery",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Pacifico-Regular'),
                                    ),
                                  ),
                                ]),
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.black),
                                ),
                                color: Colors.blueGrey.shade600,
                                onPressed: () async{
                                  var fbstorage = FirebaseStorage.instance
                                      .ref()
                                      .child("ProfilePicture/${name}.png");
                                  //  .child("khushi.jpg");
                                  fbstorage.putFile(_image);
                                  sleep(Duration(seconds: 5));
                                  url=await fbstorage.getDownloadURL();
                                  print(url);
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation, anotherAnimation) {
                                      return Screen3();
                                    },
                                    transitionDuration: Duration(milliseconds: 2000),
                    transitionsBuilder:
                        (context, animation, anotherAnimation, child) {
                      return FadeTransition(
                        opacity:animation,
                        child: child,
                      );
                    }));
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'Pacifico-Regular'),
                                ),
                              ),
                            ],
                          ),
                        ])),
              ),
            ),
          ),
        ));
  }
}
