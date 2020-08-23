import 'package:flutter/material.dart';

class ImageToFullScreen extends StatelessWidget {
  static const routeName = '/imagetofullscreen';
  @override
  Widget build(BuildContext context) {
    final List args = ModalRoute.of(context).settings.arguments;
    final String name = args[0];
    final String imageUrl = args[1];
    AppBar appBar = AppBar(
      title: Text(name),
      backgroundColor: Colors.black,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  )),
              SizedBox(
                height: appBar.preferredSize.height,
              )
            ],
          ),
        ),
      ),
    );
  }
}