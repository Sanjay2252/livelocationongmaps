import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'constant.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
        ),
      );
    });
  }
  void _showUserPanel(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: Form(
          child: Column(


            children: <Widget>[

              Text(
                'Enter Maximum distance',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),


              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter in KM'),



              ),
              SizedBox(height: 20.0),

              RaisedButton(
                //width: double.infinity,
                color: Colors.red,
                child: Text(
                  'Request',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),

                // padding: EdgeInsets.all(16),
                onPressed: (){},


              )

            ],
          ),
        ),

      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('find Donor',
          style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 20.0),
        ),
        elevation: 0.0,
        actions:<Widget> [

          FlatButton.icon(

            icon: Icon(Icons.person),
            label: Text('Request'),
            onPressed: () => _showUserPanel(),

          ),
        ],


      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
          ],
        ),
      ),
    );
  }


}

