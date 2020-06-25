library flutterfullscreenpicker;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'models/select_option.dart';
part 'src/flutter_fullscreen_picker.dart';
part 'src/flutter_fullscreen_picker_search.dart';

class FlutterFullScreenPicker {
  Future openPicker({
    BuildContext context,
    List<SelectOption> options,
    String appBarTitle,
    Color pageBackgroundColor,
    Color appBarTitleColor,
    Color appBarIconsColor,
    Color optionTextColor,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPicker(
          pageTitle: appBarTitle,
          selectOptions: options,
          pageBackgroundColor: pageBackgroundColor,
          appBarTitleColor: appBarTitleColor,
          appBarIconsColor: appBarIconsColor,
          optionTextColor: optionTextColor,
        ),
        fullscreenDialog: false,
      ),
    ).then((value) {
      if (value != null) {
        return value;
      }
      return null;
    });
  }
}
