import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:velocity_x/velocity_x.dart';


class AddressMap extends StatefulWidget {
  AddressMap({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddressMapState createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {

  Location _locationTracker = Location();
  Marker marker;
  String _address;
  GoogleMapController _controller;
  Uint8List customIcon;
  LatLng pinCoordinates;
  List<Address> add;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
    await DefaultAssetBundle.of(context).load('resources/pin.png');
    customIcon = byteData.buffer.asUint8List();
    return customIcon;
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          draggable: false,
          icon: BitmapDescriptor.fromBytes(imageData));
    });
  }

  void getCurrentLocation() async {
    Uint8List imageData = await getMarker();
    LocationData location = await _locationTracker.getLocation();

    updateMarkerAndCircle(location, imageData);
    if (_controller != null) {
      _controller.animateCamera(
          CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 0,
              target: LatLng(
                  location.latitude, location.longitude),
              tilt: 85,
              zoom: 24.00)));
    }
    setState(() {
      _getAddress(location.latitude, location.longitude)
          .then((value) {
        setState(() {
          _address = "${value.first.addressLine}";
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Manage Addresses"),
      ),
      body: Column(
        children: [
          Flexible(
            child: GoogleMap(
                mapType: MapType.normal,
                zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: initialLocation,
                markers: Set.of((marker != null) ? [marker] : []),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  getCurrentLocation();
                },
                onTap: _setMarker),
          ),
          Card(
            elevation: 40,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Set delivery location',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                HeightBox(10),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 8,
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text('$_address',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis),
                                Divider(
                                    endIndent: 0,
                                    thickness: 1,
                                    color: Colors.black),
                              ],
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "EDIT",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    add = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }

  _setMarker(LatLng tappedLoc) {
    setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: tappedLoc,
          draggable: false,
          icon: BitmapDescriptor.fromBytes(customIcon));
    });
    pinCoordinates = tappedLoc;
    setState(() {
      _getAddress(pinCoordinates.latitude, pinCoordinates.longitude)
          .then((value) {
        setState(() {
          _address = "${value.first.addressLine}";
        });
      });
    });
  }
}
