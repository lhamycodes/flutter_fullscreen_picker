# flutterfullscreenpicker

A Flutter package that provides a full screen select-like widget, it also provides search functionality 

## Installation

How to install it? [Follow Instructions](
https://pub.dev/packages/flutterfullscreenpicker#-installing-tab-)

## Usage
```dart
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
            RaisedButton(
              child: Text("Choose Country"),
              onPressed: () async {
                var res = await picker.openPicker(
                  appBarTitle: "Select Country",
                  context: context,
                  options: _countryList,
                  pageBackgroundColor: Colors.blue,
                  selectedOption: selectedOption,
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
```

## Screenshots
<p>
    <img src="https://raw.githubusercontent.com/lhamycodes/flutter_fullscreen_picker/master/screenshots/1.png" width="200px" height="auto" hspace="20"/>
    <img src="https://raw.githubusercontent.com/lhamycodes/flutter_fullscreen_picker/master/screenshots/2.png" width="200px" height="auto" hspace="20"/>
    <img src="https://raw.githubusercontent.com/lhamycodes/flutter_fullscreen_picker/master/screenshots/3.png" width="200px" height="auto" hspace="20"/>
</p>

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)