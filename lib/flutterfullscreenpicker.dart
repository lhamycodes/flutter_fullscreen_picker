library flutterfullscreenpicker;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'models/select_option.dart';
part 'src/flutter_fullscreen_picker.dart';
part 'src/flutter_fullscreen_picker_search.dart';

class FlutterFullScreenPicker {
  Future openPicker({
    /// BuildContext context
    @required BuildContext context,

    /// List of Select Options
    @required List<SelectOption> options,

    /// Page title
    @required String appBarTitle,

    /// Selected Option
    SelectOption selectedOption,

    /// Page background Color, defaults to Colors.White
    Color pageBackgroundColor,

    /// Appbar title Color, defaults to Colors.black
    Color appBarTitleColor,

    /// Appbar Icons Color, defaults to Colors.black
    Color appBarIconsColor,

    /// Select option text Color, defaults to Colors.black
    Color optionTextColor,
  }) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPicker(
          pageTitle: appBarTitle,
          selectOptions: options,
          selectedOption: selectedOption,
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
      } else {
        return null;
      }
    });
  }
}
