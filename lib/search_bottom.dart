import 'package:flutter/material.dart';

class SearchBottom extends StatefulWidget {
  final Function(String val) onSubmitted;
  const SearchBottom({super.key, required this.onSubmitted});

  @override
  State<SearchBottom> createState() => _SearchBottomState();
}

class _SearchBottomState extends State<SearchBottom> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchEmpty = true;
  FocusNode searchFocusNode = FocusNode();

  void updateClearButtonVisibility() {
    setState(() {
      isSearchEmpty = searchController.text.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(updateClearButtonVisibility);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: TextField(
        controller: searchController,
        focusNode: searchFocusNode,
        onSubmitted: widget.onSubmitted,
        style: Theme.of(context).textTheme.titleLarge,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          prefixIcon: Icon(Icons.search),
          suffixIcon: searchController.text != ""
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    searchFocusNode.requestFocus();
                  },
                  icon: Icon(Icons.cancel))
              : SizedBox.shrink(),
          filled: true,
        ),
      ),
    );
  }
}
