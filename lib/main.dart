import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:gymfinder/quick_links_model.dart';
import 'package:gymfinder/upcoming_sessions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listItems = <QuickLinks>[];
  var listSessions = <UpcomingSessions>[];

  //Google Map declaration
  GoogleMapController mapController;
  final LatLng _center = const LatLng(21.2099, 72.8333);

  //Filter 
  bool _value1 = false;
  bool _value2 = true;
  bool _value3 = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  
  bool isFullScreen = false;

// Map Create
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId('Value'),
        position: LatLng(21.2099, 72.8333),
        infoWindow: InfoWindow(
          title: 'Value',
          snippet: 'Value',
        ),
      );
      _markers['Value'] = marker;
    });
  }

  void _changed(bool visibility) {
    setState(() {
      isFullScreen = visibility;
    });
  }

  //Intialization

  @override
  void initState() {
    super.initState();
    listItems.add(new QuickLinks('Your Last Trainer', 'Simon James', ''));
    listItems.add(new QuickLinks('Your Last Trainer', 'Simon James', ''));

    listSessions.add(new UpcomingSessions('Feb 12 -08:00 8:30',
        'Session with Simon James', 'GoodLife BurnSide', ''));
    listSessions.add(new UpcomingSessions('Feb 12 -08:00 8:30',
        'Session with Simon James', 'GoodLife BurnSide', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Image.asset('images/T_40.png',
              width: 30, height: 30, fit: BoxFit.cover),
          backgroundColor: Color.fromRGBO(95, 141, 255, 1.0),
          leading: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            GestureDetector(
                onTap: () => {
                  //Filter Pop Up dialog
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Form(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: CheckboxListTile(
                                        value: _value1,
                                        onChanged: _value1Changed,
                                        title: new Text('Trainer name'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: CheckboxListTile(
                                        value: _value2,
                                        onChanged: _value2Changed,
                                        title: new Text('Gym name'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: CheckboxListTile(
                                        value: _value3,
                                        onChanged: _value3Changed,
                                        title: new Text('Radious'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: RaisedButton(
                                        child: Text("OK",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1.0),
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.bold)),
                                        color:
                                            Color.fromRGBO(95, 141, 255, 1.0),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                    },
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(top: 20.0, right: 10.0),
                        child: new Image.asset('images/filter_40.png',
                            width: 20, height: 20)),
                  ],
                ))
          ],
        ),
        backgroundColor: const Color.fromRGBO(245, 246, 249, 1.0),
        body: new SingleChildScrollView(
          child: new Column(children: [
            new Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: Text('Good morning Joe User!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      fontSize: 16)),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('It\'s a great day to train today!',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(149, 149, 156, 1.0))),
            ),
            new Column(
              children: <Widget>[
                // Map
                Stack(children: [
                  isFullScreen
                      ? Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: MediaQuery.of(context).size.height - 280,
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 18.0,
                            ),
                            markers: _markers.values.toSet(),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 18.0,
                            ),
                            markers: _markers.values.toSet(),
                          ),
                        ),
                  Positioned(
                      top: 15,
                      left: 30,
                      right: 30,
                      child: Container(
                        width: 300,
                        height: 45,
                        margin: const EdgeInsets.only(top: 15.0),
                        decoration: new BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Color.fromRGBO(228, 230, 235, 1.0),
                              blurRadius: 25.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(15.0),
                              topRight: const Radius.circular(15.0),
                              bottomLeft: const Radius.circular(15.0),
                              bottomRight: const Radius.circular(15.0)),
                        ),
                        child: new Row(                          
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                labelText: 'Search...',                                
                              )),
                            ),                              
                          ],
                        ),
                      )),
                ]),
                //Button for do Full screen map
                new Container(
                  margin: const EdgeInsets.only(top: 0.0),
                  child: new Center(
                    child: new ButtonTheme(
                      minWidth: 20,
                      height: 28,
                      child: new RaisedButton(
                        onPressed: () {
                          isFullScreen ? _changed(false) : _changed(true);
                        },
                        color: Color.fromRGBO(95, 141, 255, 1.0),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              isFullScreen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Quick Links cards
            new Container(
              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 1.0),
              margin: EdgeInsets.only(top: 15.0, left: 50.0),
              alignment: Alignment.topLeft,
              child: Text('Quick Links',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      fontSize: 16)),
            ),
            Column(
                children: listItems
                    .map((element) => Container(
                          width: 320,
                          height: 80,
                          margin: const EdgeInsets.only(top: 15.0),
                          decoration: new BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                color: Color.fromRGBO(228, 230, 235, 1.0),
                                blurRadius: 10.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(15.0),
                                topRight: const Radius.circular(15.0),
                                bottomLeft: const Radius.circular(15.0),
                                bottomRight: const Radius.circular(15.0)),
                          ),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: new Container(
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1.0),
                                      shape: BoxShape.circle),
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: new Center(
                                    child: new Image.asset('images/profile.png',
                                        width: 50, height: 50),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 12.0, top: 20.0),
                                    child: Text(element.type,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Helvetica',
                                            color: Color.fromRGBO(
                                                131, 154, 175, 1.0))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(element.name,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          detail(),
                                    )),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 70.0, top: 18.0),
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: new BoxDecoration(
                                          boxShadow: [
                                            new BoxShadow(
                                              color: Color.fromRGBO(
                                                  228, 230, 235, 1.0),
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          color:
                                              Color.fromRGBO(95, 141, 255, 1.0),
                                          shape: BoxShape.circle,
                                        ),
                                        child: new Icon(
                                          Icons.navigate_next,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 1.0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList()),
            //Upcoming links cards
            new Container(
              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 1.0),
              margin: EdgeInsets.only(top: 18.0, left: 50.0),
              alignment: Alignment.topLeft,
              child: Text('Upcoming Sessions',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      fontSize: 16)),
            ),
            new SingleChildScrollView(
                padding: EdgeInsets.only(left: 22.0),
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: listSessions
                        .map(
                          (element) => Container(
                              width: 300,
                              height: 90,
                              margin:
                                  const EdgeInsets.only(top: 15.0, left: 8.0),
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                    color: Color.fromRGBO(228, 230, 235, 1.0),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(15.0),
                                    topRight: const Radius.circular(15.0),
                                    bottomLeft: const Radius.circular(15.0),
                                    bottomRight: const Radius.circular(15.0)),
                              ),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1.0),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(10.0),
                                      child: new Image.asset(
                                          'images/profile.png',
                                          width: 50,
                                          height: 50),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 15.0),
                                        child: Text(element.name,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text(element.type,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text(element.date,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Helvetica',
                                                color: Color.fromRGBO(
                                                    131, 154, 175, 1.0),
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              detail(),
                                        )),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, top: 18.0),
                                          child: Container(
                                            width: 45,
                                            height: 45,
                                            decoration: new BoxDecoration(
                                              boxShadow: [
                                                new BoxShadow(
                                                  color: Color.fromRGBO(
                                                      228, 230, 235, 1.0),
                                                  blurRadius: 5.0,
                                                ),
                                              ],
                                              color: Color.fromRGBO(
                                                  95, 141, 255, 1.0),
                                              shape: BoxShape.circle,
                                            ),
                                            child: new Icon(
                                              Icons.navigate_next,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1.0),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        )
                        .toList())),
          ]),
        ),
        //Bottom tab bar 
        bottomNavigationBar: bmnav.BottomNav(
          labelStyle: bmnav.LabelStyle(showOnSelect: true),
          items: [
            bmnav.BottomNavItem(Icons.perm_identity),
            bmnav.BottomNavItem(Icons.widgets),
            bmnav.BottomNavItem(Icons.favorite_border),
            bmnav.BottomNavItem(Icons.chat)
          ],
          iconStyle: bmnav.IconStyle(
              onSelectColor: Color.fromRGBO(95, 141, 255, 1.0),
              color: Color.fromRGBO(177, 178, 181, 1.0)),
        ));
  }
}
