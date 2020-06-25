import 'package:flutter/material.dart';
import 'package:flutterfullscreenpicker/flutterfullscreenpicker.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedOption;
  FlutterFullScreenPicker picker = FlutterFullScreenPicker();

  List<SelectOption> _countryList = [
    SelectOption(display: "Nigeria", value: "NG"),
    SelectOption(display: "South Africa", value: "SA"),
    SelectOption(display: "Rwanda", value: "RW"),
    SelectOption(display: "United States of America", value: "USA"),
    SelectOption(display: "Russia", value: "RU"),
    SelectOption(display: "China", value: "CN"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Selected Country Code : ${selectedOption.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text("Choose Country"),
              onPressed: () async {
                var res = await picker.openPicker(
                  appBarTitle: "Select Country",
                  context: context,
                  options: _countryList,
                  pageBackgroundColor: Colors.blue,
                );

                setState(() {
                  selectedOption = res;
                });
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
