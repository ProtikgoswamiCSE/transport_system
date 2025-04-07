import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_system/login/log.dart';
import 'package:transport_system/screen/driver/Bus_sudule.dart';
import 'package:transport_system/screen/driver/DrMapPage2.dart';
import 'package:transport_system/screen/driver/map.dart';
import 'package:transport_system/screen/driver/profile_screen.dart';
import 'package:transport_system/screen/driver/setting_screen.dart';

class DApp extends StatefulWidget {
  const DApp({super.key});

  @override
  State<DApp> createState() => _DAppState();
}

class _DAppState extends State<DApp> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _driverName = '';
  String _driverPhone = '';
  String _driverBloodGroup = '';
  String _driverTransportId = '';
  String _driverBusNo = '';

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
      _driverBloodGroup = prefs.getString('driver_blood_group') ?? 'No blood group';
      _driverTransportId = prefs.getString('driver_transport_id') ?? 'No transport ID';
      _driverBusNo = prefs.getString('driver_bus_no') ?? 'No bus number';
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("D Transport system"),
          backgroundColor: Colors.green,
          foregroundColor: const Color.fromARGB(255, 255, 251, 251),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
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
                      child: Icon(Icons.person, size: 40, color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    Text(_driverName,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 22)),
                    Text(_driverPhone,
                        style: TextStyle(
                            color: const Color.fromARGB(179, 2, 1, 1),
                            fontSize: 14)),
                    SizedBox(height: 5),
                    Text('Blood Group: $_driverBloodGroup',
                        style: TextStyle(
                            color: const Color.fromARGB(179, 2, 1, 1),
                            fontSize: 12)),
                    Text('Transport ID: $_driverTransportId',
                        style: TextStyle(
                            color: const Color.fromARGB(179, 2, 1, 1),
                            fontSize: 12)),
                    Text('Bus No: $_driverBusNo',
                        style: TextStyle(
                            color: const Color.fromARGB(179, 2, 1, 1),
                            fontSize: 12)),
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
                  ).then((_) => _loadDriverData()); // Reload data when returning from profile
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
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
