import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_system/login/log.dart';
import 'package:transport_system/screen/driver/Bus_sudule.dart';
import 'package:transport_system/screen/driver/DrMapPage2.dart';
import 'package:transport_system/screen/driver/map.dart';
import 'package:transport_system/screen/driver/profile_screen.dart';
import 'package:transport_system/screen/driver/wized/setting_screen.dart';
import 'dart:io';

class DApp extends StatefulWidget {
  const DApp({super.key});

  @override
  State<DApp> createState() => _DAppState();
}

class _DAppState extends State<DApp> {
  int _selectedIndex = 0; // Track the selected tab
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Key to control the Scaffold
  String _driverName = '';
  String _driverPhone = '';
  String? _profileImagePath;

  // List of widget screens for each tab
  final List<Widget> _widgetOptions = <Widget>[
    const DrMapPage(),
    const DriTransportScreen(),
    const DrMapPage2(),
  ];

  @override
  void initState() {
    super.initState();
    _loadDriverData();
  }

  Future<void> _loadDriverData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _driverName = prefs.getString('driver_name') ?? 'Driver';
      _driverPhone = prefs.getString('driver_phone') ?? 'No phone number';
      _profileImagePath = prefs.getString('driver_profile_image');
    });
  }

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
          title: Text("Driver TS"),
          backgroundColor: Colors.green,
          foregroundColor: const Color.fromARGB(255, 255, 251, 251),
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
              Container(
                height: 250,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 32, 197, 32),
                      Color.fromARGB(255, 23, 204, 47),
                      Color.fromARGB(255, 8, 90, 12),
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 35), // Add space from top
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: _profileImagePath != null
                          ? FileImage(File(_profileImagePath!)) as ImageProvider
                          : null,
                      child: _profileImagePath == null
                          ? Icon(Icons.person, size: 45, color: Colors.blue)
                          : null,
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Text(_driverName,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(_driverPhone,
                          style: TextStyle(
                              color: const Color.fromARGB(179, 2, 1, 1),
                              fontSize: 14),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DProfileScreen(),
                    ),
                  ).then((_) =>
                      _loadDriverData()); // Reload data when returning from profile
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DSettingsScreen(),
                    ),
                  );
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
