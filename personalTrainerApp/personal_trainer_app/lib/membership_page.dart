import 'package:flutter/material.dart';

class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  String selectedMembership = 'Premium Membership';
  final Map<String, String> membershipDescriptions = {
    'Premium Membership': 'Enjoy premium features and priority support.',
    'Gold Membership': 'Get access to exclusive content and gold support.',
    'Regular Membership': 'Basic access with standard features.',
  };
  final Map<String, double> membershipPrices = {
    'Premium Membership': 29.99,
    'Gold Membership': 19.99,
    'Regular Membership': 9.99,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memberships'),
        backgroundColor: Colors.teal, // Change AppBar color
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Your Plan',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ...membershipDescriptions.keys.map((membership) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedMembership = membership;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: selectedMembership == membership
                            ? Colors.teal[100] // Color for selected card
                            : Colors.white, // Color for non-selected card
                        borderRadius: BorderRadius.circular(15.0),
                        border: selectedMembership == membership
                            ? Border.all(color: Colors.teal, width: 2)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                membership,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${membershipPrices[membership]}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal, // Color for membership price text
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            membershipDescriptions[membership]!,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the subscribe action
                  },
                  child: Text('Subscribe Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Button background color
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    textStyle: TextStyle(fontSize: 18.0, color: Colors.white), // Button text color
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Navigation Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Membership'),
            onTap: () {
              Navigator.pushNamed(context, '/membership');
            },
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Workout'),
            onTap: () {
              Navigator.pushNamed(context, '/workout');
            },
          ),
          ListTile(
            leading: Icon(Icons.monitor),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('Goal and Progress'),
            onTap: () {
              Navigator.pushNamed(context, '/goalProgress');
            },
          ),
        ],
      ),
    );
  }
}
