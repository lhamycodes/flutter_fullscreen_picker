import 'package:flutter/material.dart';
import 'package:flutterfullscreenpicker/flutterfullscreenpicker.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SelectOption selectedOption;
  FlutterFullScreenPicker picker = FlutterFullScreenPicker();

  List<SelectOption> _countryList = [
    SelectOption(display: "Nigeria", value: "NG"),
    SelectOption(display: "South Africa", value: "SA"),
    SelectOption(display: "Rwanda", value: "RW"),
    SelectOption(display: "United States of America", value: "US"),
    SelectOption(display: "Russia", value: "RU"),
    SelectOption(display: "China", value: "CN"),
    SelectOption(display: "France", value: "FR"),
    SelectOption(display: "India", value: "IN"),
    SelectOption(display: "Mexico", value: "ME"),
    SelectOption(display: "Spain", value: "SP"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selected Country : ${selectedOption?.display}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Selected Country Code : ${selectedOption?.value.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text(
                "Choose Country",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                var res = await picker.openPicker(
                  appBarTitle: "Select Country",
                  context: context,
                  options: _countryList,
                  pageBackgroundColor: Colors.blue,
                  selectedOption: selectedOption,
                  // optionTextColor: Colors.grey[300],
                  appBarIconsColor: Colors.white,
                  appBarTitleColor: Colors.white,
                  optionTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[50],
                  ),
                  hasOtherOption: true,
                );

                setState(() {
                  selectedOption = res;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
