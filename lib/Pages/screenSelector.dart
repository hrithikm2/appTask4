import 'package:app_task4/Pages/addressMap.dart';
import 'package:app_task4/Pages/addresses.dart';
import 'package:app_task4/Pages/contactUs.dart';
import 'package:app_task4/Pages/wallet.dart';
import 'package:app_task4/Services/locationstoring.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Screenless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocationChange(),
    child: MaterialApp(
      debugShowCheckedModeBanner : false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: ScreenSelector()));
  }
}

class ScreenSelector extends StatefulWidget {
  @override
  _ScreenSelectorState createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Task 4"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text("Contact us"),
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUs()));
                },
              ),
              FlatButton(
                child: Text("Wallet Transactions"),
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Wallet()));
                },
              ),
              FlatButton(
                child: Text("Manage Address"),
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Address()));
                },
              ),
            ],
          ),
        ));
  }
}
