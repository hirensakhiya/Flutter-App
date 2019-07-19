import 'package:flutter/material.dart';

class detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(95, 141, 255, 1.0),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        elevation: 0.0,      
      ),
      backgroundColor: Colors.white,
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: new Container(
        padding: const EdgeInsets.all(30.0),
        color: Colors.white,
        child: new Container(
          child: new Center(
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/profile_pic_150.png',
                  alignment: Alignment.topCenter,
                ),
                new Padding(padding: EdgeInsets.all(12.0)),
                new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  new Text("John Trainer ",
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ]),
                new Padding(padding: EdgeInsets.all(5.0)),
                new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  new Text("Goodlife Burnside ",
                      style: TextStyle( fontFamily: 'Helvetica',fontSize: 14.0, color: Colors.black)),
                ]),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  new Text("Available: ",
                  
                      style: TextStyle(
                         fontFamily: 'Helvetica',
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  new Text("09:00 A.M. to 06:00 P.M.",
                      style: TextStyle(fontSize: 14.0, color: Colors.black)),
                  Icon(
                    Icons.chat,
                    color: Color.fromRGBO(95, 141, 255, 1.0),
                    size: 30.0,
                  )
                ]),
                 new Padding(padding: EdgeInsets.all(5.0)),
                new Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  new Text("About: ",
                      style: TextStyle(
                         fontFamily: 'Helvetica',
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ]),
                 new Padding(padding: EdgeInsets.all(5.0)),
                new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              new Flexible(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                        "         He is a freelancer personal trainer having collaboration with the gym . He is a professional gym trainer with expertise. For any kind of fitness training like Muscle building, Weight gaining, Weight losing, Diet planning with the proper training.",
                   style: TextStyle(
                      fontFamily: 'Helvetica',
                          fontSize: 14.0,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}