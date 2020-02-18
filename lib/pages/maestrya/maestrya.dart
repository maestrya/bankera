import 'package:flutter/material.dart';
import 'dart:async';
import 'package:maestrya/maestrya.dart';
import 'package:bankera/shared/services/maestrya.dart';

class MaestryaPage extends StatefulWidget {
  @override
  _MaestryaPageState createState() => new _MaestryaPageState();
}

class _MaestryaPageState extends State<MaestryaPage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var list;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return createListView();
  }

  Future<Null> _getData() async {
    final items = await MaestryaService().getPage('page_test');

    setState(() {
      list = items;
    });

    return null;
  }

  Widget createListView() {
    List<Widget> childrenWidgets = [];
    String titleScaffold = "";

    if (list != null) {
      childrenWidgets = Maestrya().render(list['data']['body']['render']);
      titleScaffold = list['data']['header']['title']['text'];
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(titleScaffold),
        ),
        body: new RefreshIndicator(
            key: refreshKey,
            onRefresh: _getData,
            child: new ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return new Column(
                  children: childrenWidgets,
                );
              },
            )));
  }
}
