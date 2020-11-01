import 'package:flutter/material.dart';

class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
//     return new ListView.builder
// (
//   itemCount: litems.length,
//   itemBuilder: (BuildContext ctxt, int index) => buildBody(ctxt, index)
// );
  }
}
