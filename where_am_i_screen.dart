import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class WhereAmIScreen extends StatefulWidget {
  static const String id = 'where_am_i_screen';
  @override
  _WhereAmIScreenState createState() => _WhereAmIScreenState();
}

class _WhereAmIScreenState extends State<WhereAmIScreen> {
  List<Marker> allMarkers = [];
  GoogleMapController _controller;
  LocationData locationData;
  double lat, lon;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = true;
    _getCurrentLocation();
//    allMarkers.add(
//      Marker(
//          markerId: MarkerId('myMarker'),
//          position: LatLng(40.7128, -74.0060),
//          onTap: () {
//            print('Marker Tapped');
//          }),
//    );
  }

  MapType _defaultMapType = MapType.normal;

  void _changeMapType() {
    setState(() {
      _defaultMapType =
          _defaultMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where Am I?'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          lat == null || lon == null
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/logo.png'),
                          height: 150.0,
                          width: 150.0,
                        ),
                        Text(
                          'Map Loading...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24.0),
                        ),
                      ],
                    ),
                  ),
                )
              : GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, lon),
                    zoom: 18.0,
                    tilt: 45.0,
                  ),
                  //markers: Set.from(allMarkers),
                  onMapCreated: mapCreated,
                  mapType: _defaultMapType,
                ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                      child: Icon(FontAwesomeIcons.layerGroup),
                      elevation: 5,
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        _changeMapType();
                        print('Changing the Map Type');
                      }),
                ]),
          ),
         Align(
           alignment: Alignment.bottomRight,
           child: InkWell(
             child: Container(
               height: 40.0,
               width: 40.0,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20.0),
                 color: Colors.green,
               ),
               child: Icon(
                 FontAwesomeIcons.forward,
                 color: Colors.white,
               ),
             ),
             onTap: () {
               print('Map Button Tapped');
             },
           ),
         ),
        ],
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  void moveToBoston() {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lon), zoom: 12.0),
      ),
    );
  }

  Future _getCurrentLocation() async {
    final location = Location();
    var currentLocation = await location.getLocation();

    setState(() {
      lat = currentLocation.latitude;
      lon = currentLocation.longitude;
      loading = false;
    });
  }
}
