import 'package:flutter/material.dart';
import 'package:transport_system/login/log.dart';
import 'package:transport_system/screen/user/Bus_sudule.dart';
import 'package:transport_system/screen/user/UrMapPage2.dart';

import 'package:transport_system/screen/user/map.dart';

void main() {
  runApp(const UApp());
}

class UApp extends StatefulWidget {
  const UApp({super.key});

  @override
  State<UApp> createState() => _DAppState();
}

class _DAppState extends State<UApp> {
  int _selectedIndex = 0; // Track the selected tab
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Key to control the Scaffold

  // List of widget screens for each tab
  final List<Widget> _widgetOptions = <Widget>[
    const UrMapPage(),
    const UrTransportScreen(),
    const UrMapPage2(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey, // Assign the scaffold key
        appBar: AppBar(
          title: Text("Transport system"),
          leading: IconButton(
            icon: Icon(Icons.menu), // Menu icon for opening the drawer
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(220, 32, 197, 32),
                      Color.fromARGB(220, 23, 204, 47),
                      Color.fromARGB(99, 8, 90, 12),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    Text("Protik",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 22)),
                    Text("goswami15-5841@diu.edu.bd",
                        style: TextStyle(
                            color: const Color.fromARGB(179, 2, 1, 1),
                            fontSize: 14)),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to Home if needed
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to Settings screen if needed
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: _widgetOptions
            .elementAt(_selectedIndex), // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, // Set the current index
          onTap: _onItemTapped, // Handle item taps
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(
                icon: Icon(Icons.train_outlined), label: "Bus_Schedule"),
            BottomNavigationBarItem(icon: Icon(Icons.route), label: "Route"),
          ],
        ),
      ),
    );
  }
}
