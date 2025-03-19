import 'package:flutter/material.dart';
import 'package:transport_system/screen/driver/Bus_sudule.dart';
import 'package:transport_system/screen/driver/DrMapPage2.dart';
import 'package:transport_system/screen/driver/map.dart';

void main() {
  runApp(const DApp());
}

class DApp extends StatefulWidget {
  const DApp({super.key});

  @override
  State<DApp> createState() => _DAppState();
}

class _DAppState extends State<DApp> {
  int _selectedIndex = 0; // Track the selected tab

  // List of widget screens for each tab
  final List<Widget> _widgetOptions = <Widget>[
    const DrMapPage(),
    const DriTransportScreen(),
    const DrMapPage2(),
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
        appBar: AppBar(
          title: Text("Flutter UI"),
          leading: IconButton(
            icon: Icon(Icons.more_vert), // 3-dot icon
            onPressed: () {
              // Handle the menu button click
              _showPopupMenu(context);
            },
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

  // Function to show a popup menu
  void _showPopupMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = Offset(0, kToolbarHeight); // Position for the menu

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & Size(40, 40), // Adjust the size of the menu
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'Option1',
          child: Text('Option 1'),
        ),
        PopupMenuItem<String>(
          value: 'Option2',
          child: Text('Option 2'),
        ),
      ],
      elevation: 8.0,
    );
  }
}
