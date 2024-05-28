import 'package:flutter/material.dart';

class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  String selectedMembership = 'Membership level';

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
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Field:'),
              DropdownButton<String>(
                value: selectedMembership,
                items: <String>['Premium', 'Gold', 'Regular']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedMembership = newValue;
                    });
                  }
                },
              ),
            ],
          ),
        ));
  }
}
