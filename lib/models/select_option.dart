part of flutterfullscreenpicker;

class SelectOption {
  String display;
  dynamic value;
  bool isOtherOption;

  SelectOption({
    this.display,
    this.value,
    this.isOtherOption = false,
  });
}
