part of flutterfullscreenpicker;

class FullScreenPicker extends StatefulWidget {
  /// Page title
  final String pageTitle;

  /// List of Select Options
  final List<SelectOption> selectOptions;

  /// Selected Option Display
  final SelectOption selectedOption;

  /// Page background Color, defaults to Colors.White
  final Color pageBackgroundColor;

  /// Appbar title Color, defaults to Colors.black
  final Color appBarTitleColor;

  /// Appbar Icons Color, defaults to Colors.black
  final Color appBarIconsColor;

  /// Select option text Color, defaults to Colors.black
  final Color optionTextColor;

  /// Select option text style, can be null
  final TextStyle optionTextStyle;

  FullScreenPicker({
    @required this.pageTitle,
    @required this.selectOptions,
    this.selectedOption,
    this.optionTextStyle,
    this.pageBackgroundColor = Colors.white,
    this.appBarTitleColor = Colors.black,
    this.appBarIconsColor = Colors.black,
    this.optionTextColor = Colors.black,
  });

  @override
  _FullScreenPickerState createState() => _FullScreenPickerState();
}

class _FullScreenPickerState extends State<FullScreenPicker> {
  List<SelectOption> selectList = List();

  @override
  void initState() {
    selectList = widget.selectOptions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.pageBackgroundColor,
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: 10,
              ),
              child: appBar(),
            ),
            Expanded(
              child: buildOptions(),
            ),
          ],
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

    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.only(
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        itemCount: selectList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onSelect(selectList[index]);
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 16,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  selectList[index].display,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Container(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            width: double.infinity,
            height: AppBar().preferredSize.height - 8,
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
                        color: widget.appBarIconsColor,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: FullScreenPickerSearch(
                          selectOptions: selectList,
                        ),
                      ).then((value) => processSelection(value));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.search,
                        color: widget.appBarIconsColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 24),
          child: Text(
            widget.pageTitle,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: widget.appBarTitleColor,
            ),
          ),
        ),
      ],
    );
  }

  void onSelect(SelectOption option) {
    Navigator.pop(context, option);
  }

  processSelection(String value) {
    if (value != null && value != "") {
      SelectOption opt = selectList.firstWhere(
        (item) => item.display.toLowerCase() == value.toLowerCase(),
        orElse: () => null,
      );

      if (opt != null) {
        onSelect(opt);
      }
    }
  }
}
