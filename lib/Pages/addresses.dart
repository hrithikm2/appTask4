import 'package:app_task4/Files/addressList.dart';
import 'package:app_task4/Pages/screenSelector.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Addressful(),
    );
  }
}

class Addressful extends StatefulWidget {
  @override
  _AddressfulState createState() => _AddressfulState();
}

class _AddressfulState extends State<Addressful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Screenless()))),
          title: Text("Manage Addresses"),
          backgroundColor: Color(0xff480f18),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemCount: Addresses.addressType.length,
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
                      Icon(Icons.location_on_outlined, color: Colors.blue, size: 34),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeightBox(MediaQuery.of(context).size.height * 0.02),
                          Addresses.addressType[index].text.make(),
                        ],
                      ),
                      subtitle:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeightBox(MediaQuery.of(context).size.height * 0.02),
                          Addresses.address[index].text.make(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FlatButton(onPressed: (){}, child: "EDIT".text.orange400.make()),
                              FlatButton(onPressed: (){}, child: "DELETE".text.orange400.make()),
                            ],
                          )
                        ],
                      ),
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
