part of flutterfullscreenpicker;

class FullScreenPicker extends StatefulWidget {
  final String pageTitle;
  final List<SelectOption> selectOptions;
  final Color pageBackgroundColor, appBarTitleColor, appBarIconsColor, optionTextColor;

  FullScreenPicker({
    @required this.pageTitle,
    @required this.selectOptions,
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
      appBar: appBar(),
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
                          child: Text(
                            selectList[index].display,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: widget.optionTextColor,
                            ),
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
    return AppBar(
      backgroundColor: widget.pageBackgroundColor,
      leading: IconButton(
        icon: Icon(
          Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
          color: widget.appBarIconsColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: widget.appBarIconsColor,
            ),
            onPressed: () => showSearch(
              context: context,
              delegate: FullScreenPickerSearch(
                selectOptions: selectList,
              ),
            ).then((value) => processSelection(value)),
          ),
        ),
      ],
    );
  }

  void onSelect(SelectOption option) {
    Navigator.pop(context, option.value);
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
