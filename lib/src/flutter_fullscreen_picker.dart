part of flutterfullscreenpicker;

class FullScreenPicker extends StatefulWidget {
  /// Page title
  final String pageTitle;

  /// List of Select Options
  final List<SelectOption> selectOptions;

  /// Selected Option Display
  final SelectOption? selectedOption;

  /// Page background Color, defaults to Colors.White
  final Color? pageBackgroundColor;

  /// Appbar title Color, defaults to Colors.black
  final Color? appBarTitleColor;

  /// Appbar Icons Color, defaults to Colors.black
  final Color? appBarIconsColor;

  /// Select option text Color, defaults to Colors.black
  final Color? optionTextColor;

  /// Select option text style, can be null
  final TextStyle? optionTextStyle;

  /// Do you have an 'Other' Option, defaults to false
  final bool? hasOtherOption;

  /// The text to show in place of "Other"
  final String otherOptionText;

  FullScreenPicker({
    required this.pageTitle,
    required this.selectOptions,
    this.selectedOption,
    this.optionTextStyle,
    this.pageBackgroundColor = Colors.white,
    this.appBarTitleColor = Colors.black,
    this.appBarIconsColor = Colors.black,
    this.optionTextColor = Colors.black,
    this.hasOtherOption = false,
    this.otherOptionText = "Other",
  });

  @override
  _FullScreenPickerState createState() => _FullScreenPickerState();
}

class _FullScreenPickerState extends State<FullScreenPicker> {
  List<SelectOption> selectList = [];
  TextEditingController otherOptionController = TextEditingController();

  @override
  void initState() {
    selectList = widget.selectOptions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.pageBackgroundColor,
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: widget.appBarIconsColor),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: FullScreenPickerSearch(
                    selectOptions: selectList,
                  ),
                ).then((value) => processSelection(value));
              },
              child: Icon(
                Icons.search,
                color: widget.appBarIconsColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: widget.pageBackgroundColor,
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20) +
              EdgeInsets.only(
                bottom: !widget.hasOtherOption!
                    ? 5
                    : MediaQuery.of(context).padding.bottom,
              ),
          child: buildOptions(),
        ),
      ),
    );
  }

  Widget buildOptions() {
    if (selectList.length == 0) {
      return Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.pageTitle,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: widget.appBarTitleColor,
          ),
        ),
        SizedBox(height: 10),
        ListView.builder(
          padding: EdgeInsets.only(
            bottom: widget.hasOtherOption!
                ? 5
                : 16 + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: selectList.length,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                onSelect(selectList[index]);
              },
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  selectList[index].display!,
                                  style: widget.optionTextStyle ??
                                      TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: widget.optionTextColor,
                                      ),
                                ),
                              ),
                              Icon(
                                widget.selectedOption?.display ==
                                        selectList[index].display
                                    ? Icons.check
                                    : null,
                                color: widget.appBarIconsColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        if (widget.hasOtherOption!) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              PickerInput(
                hintText: widget.otherOptionText,
                label: "Hello",
                validator: (val) {
                  return null;
                },
                enabled: true,
                textController: otherOptionController,
                showLabel: false,
                readOnly: false,
                suffixIcon: Container(
                  margin: EdgeInsets.all(3) + EdgeInsets.only(right: 2),
                  child: ElevatedButton(
                    child: Text("Okay"),
                    onPressed: () => _otherOptionOkay(),
                    style: TextButton.styleFrom(
                      primary: widget.optionTextStyle?.color ??
                          widget.optionTextColor,
                    ),
                  ),
                ),
                borderColor: Colors.black54,
                fillColor: Color(0xFFEBF1FF),
                enabledBorderColor: Colors.grey,
                borderRadius: 6,
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ],
    );
  }

  void onSelect(SelectOption option) {
    Navigator.pop(context, option);
  }

  _otherOptionOkay() {
    String val = otherOptionController.text;
    if (val.trim() == "" || val.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Other option cannot be empty"),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      SelectOption opt = SelectOption(
        display: val.trim(),
        value: val.trim(),
        isOtherOption: true,
      );

      onSelect(opt);
    }
  }

  processSelection(String? value) {
    if (value != null && value != "") {
      SelectOption? opt = selectList.firstWhereOrNull(
        (item) => item.display!.toLowerCase() == value.toLowerCase(),
      );

      if (opt != null) {
        onSelect(opt);
      }
    }
  }
}
