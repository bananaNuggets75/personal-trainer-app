import 'package:flutter/material.dart';


class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Memberships'),
    leading: Builder(
    builder: (context) {
    return IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {
    Scaffold.of(context).openDrawer();
    },
    );
    },
    ),
    ));
  }
}