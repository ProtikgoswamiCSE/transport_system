import 'package:flutter/material.dart';

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

  // List of widgets to display for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Screen', style: TextStyle(fontSize: 24)),
    Text('Search Screen', style: TextStyle(fontSize: 24)),
    Text('Settings Screen', style: TextStyle(fontSize: 24)),
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
      title: "Basic UI in Flutter",
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter UI")),
        body: Center(
            child: _widgetOptions
                .elementAt(_selectedIndex)), // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, // Set the current index
          onTap: _onItemTapped, // Handle item taps
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
