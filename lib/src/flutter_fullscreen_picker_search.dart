part of flutterfullscreenpicker;

class FullScreenPickerSearch extends SearchDelegate<String> {
  final List<SelectOption> selectOptions;

  FullScreenPickerSearch({this.selectOptions});

  String selectedOption;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List suggestionList =
        selectOptions.where((sen) => sen.display == selectedOption).toList();

    if (suggestionList.isEmpty ||
        suggestionList == null ||
        suggestionList.length < 1)
      return Center(
        child: Text(
          "No Result found",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
      );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (ctx, i) => ListTile(
        onTap: () {
          close(context, suggestionList[i].display);
        },
        title: Text(suggestionList[i].display),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? selectOptions
        : selectOptions
            .where(
              (opt) => opt.display.toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (ctx, i) => ListTile(
        onTap: () {
          selectedOption = suggestionList[i].display;
          close(context, suggestionList[i].display);
        },
        title: Text(suggestionList[i].display),
      ),
    );
  }
}
