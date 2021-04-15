import 'package:app_task4/Pages/screenSelector.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Walletful(),
    );
  }
}

class Walletful extends StatefulWidget {
  @override
  _WalletfulState createState() => _WalletfulState();
}

class _WalletfulState extends State<Walletful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Screenless()))),
          title: Text("Wallet Transactions"),
          backgroundColor: Color(0xff480f18),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeightBox(MediaQuery.of(context).size.height * 0.02),
            ListTile(
              leading: Image.asset("resources/wallet.jpeg"),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Door',
                          style: TextStyle(color: Colors.orange,fontSize: 34),
                          children: <TextSpan>[
                        TextSpan(
                            text: 'Bell',
                            style: TextStyle(color: Colors.white, fontSize: 34))
                      ])),
                  HeightBox(MediaQuery.of(context).size.height * 0.02)
                ],
              ),
              subtitle: "₹ 0".text.size(28).white.make(),
              onTap: () {},
            ),
            HeightBox(MediaQuery.of(context).size.height * 0.02),
            Divider(
                thickness: 1,
                color: Colors.black
            )
          ],
        ));
  }
}
