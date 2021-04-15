import 'dart:io';

import 'package:app_task4/Pages/screenSelector.dart';
import 'package:flutter/material.dart';
import 'package:app_task4/Files/contactnumbers.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Contactful(),
    );
  }
}

class Contactful extends StatefulWidget {
  @override
  _ContactfulState createState() => _ContactfulState();
}

class _ContactfulState extends State<Contactful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Screenless()))),
          title: Text("Contact Us"),
          backgroundColor: Color(0xff480f18),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemCount: ContactNumbers.phoneNumber.length,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                      color: Colors.black
                      ),
                  shrinkWrap: true,
                  //itemExtent: MediaQuery.of(context).size.height * 0.1,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading:
                          Icon(Icons.phone_in_talk, color: Colors.blue, size: 34),
                      title: ContactNumbers.phoneNumber[index].text.make(),
                      subtitle:
                          ContactNumbers.operatorNumber[index].text.make(),
                      onTap: () {},
                    );
                  }),
            ),
            Divider(
              thickness: 1,
              color: Colors.black
            )
          ],
        ));
  }
}
