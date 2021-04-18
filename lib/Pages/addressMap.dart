// THIS PAGE IS THE WIDGET THAT OPENS GOOGLE MAPS ONCE PRESSED ON '+ ADD NEW ADDRESS button in the Addresses.dart'

import 'package:app_task4/Services/locationstoring.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressMap extends StatefulWidget {
  @override
  _AddressMapState createState() => _AddressMapState();
}
class _AddressMapState extends State<AddressMap> {
  String address = '';
  GoogleMapController mapController;
  final locationchange = new LocationChange();

  addressFromCoordinates() async{
    final userCoordinates =  Coordinates(locationchange.currentLocation.latitude, locationchange.currentLocation.longitude);
    var userAddress = await Geocoder.local.findAddressesFromCoordinates(userCoordinates);
    address = userAddress.first.addressLine;
  }


  @override
  Widget build(BuildContext context) {
    final locationChange = Provider.of<LocationChange>(context);
    return Scaffold(
        body:(locationChange.currentLocation == null) ? Center(child: CircularProgressIndicator()) :
        Column(
          children: [
            HeightBox(MediaQuery.of(context).size.height *0.03),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.black26,
              child: 'Deliver to $address'.text.make(),
            ),
            HeightBox(MediaQuery.of(context).size.height *0.03),
            SearchMapPlaceWidget(
              hasClearButton: true,
            placeType: PlaceType.address,
            placeholder: 'Enter Location',
            apiKey:'AIzaSyCsn04If8EbRrj_NyHks8dv3YvznNf60T8',
            onSelected: (Place place) async {
              Geolocation geolocation = await place.geolocation;
              mapController.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
              mapController.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
            }),
            HeightBox(MediaQuery.of(context).size.height *0.02),
            Flexible(
              child: GoogleMap(
                onMapCreated: (GoogleMapController googleMapController){
                  setState(() {
                    mapController = googleMapController;
                  });
                },
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(target: LatLng(locationChange.currentLocation.latitude,locationChange.currentLocation.longitude),
                zoom: 14)
              ),
            ),
          ],
        )
    );
  }
}
