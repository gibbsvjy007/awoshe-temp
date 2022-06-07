import 'package:Awoshe/logic/stores/search/search_store.dart';
import 'package:Awoshe/widgets/search/search_form.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({
    Key key,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchStore searchStore = SearchStore();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
//    searchStore?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SearchForm(searchStore: searchStore),
        ),
      );
  }
}
