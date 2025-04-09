import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_system/login/log.dart';
import 'package:transport_system/screen/user/wized/Bus_sudule.dart';
import 'package:transport_system/screen/user/wized/MAP1.dart';
import 'package:transport_system/screen/user/wized/route.dart';
import 'package:transport_system/screen/user/profile_screen.dart';
import 'package:transport_system/screen/user/setting_screen.dart';
import 'dart:io';

void main() {
  runApp(const UApp());
}

class UApp extends StatefulWidget {
  const UApp({super.key});

  @override
  State<UApp> createState() => _UAppState();
}

class _UAppState extends State<UApp> {
  int _selectedIndex = 0; // Track the selected tab
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Key to control the Scaffold
  String _userName = '';
  String _userPhone = '';
  String? _profileImagePath;
  // List of widget screens for each tab
  final List<Widget> _widgetOptions = <Widget>[
    const UrMapPage(),
    const UrTransportScreen(),
    const UrMapPage2(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'User';
      _userPhone = prefs.getString('user_phone') ?? 'No phone number';
      _profileImagePath = prefs.getString('user_profile_image');
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
          title: Text("Transport system"),
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
              DrawerHeader(
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
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: _profileImagePath != null
                          ? FileImage(File(_profileImagePath!)) as ImageProvider
                          : null,
                      child: _profileImagePath == null
                          ? Icon(Icons.person, size: 45, color: Colors.green)
                          : null,
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Text(_userName,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(_userPhone,
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
                  Navigator.pop(context); // Close the drawer
                  // Navigate to Home if needed
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
                      builder: (context) => const ProfileScreen(),
                    ),
                  ).then((_) =>
                      _loadUserData()); // Reload data when returning from profile
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
                      builder: (context) => const SettingsScreen(),
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
