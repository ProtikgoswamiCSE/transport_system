import 'package:flutter/material.dart';
import 'package:transport_system/Bus_sudule.dart';
import 'package:transport_system/addroute.dart';
import 'package:transport_system/login.dart';

void main() {
  runApp(const MyApp());
}

// Wrap the app with MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Basic UI in Flutter",
      home: LoginScreen(), // Set LoginScreen as the initial screen
    );
  }
}

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  // Global key for Scaffold to control the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Function to show Snackbar
  void MySnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 10,
        backgroundColor: const Color.fromARGB(255, 33, 169, 85),
        actions: [
          IconButton(
            onPressed: () {
              MySnackbar("Comment", context);
            },
            icon: const Icon(Icons.comment),
          ),
          IconButton(
            onPressed: () {
              MySnackbar("Search", context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              MySnackbar("Settings", context);
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              MySnackbar("Email", context);
            },
            icon: const Icon(Icons.email),
          ),
          IconButton(
            onPressed: () {
              MySnackbar("ABC", context);
            },
            icon: const Icon(Icons.abc),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrangeAccent),
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
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text("goswami15-5841@diu.edu.bd",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
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
              leading: Icon(Icons.train),
              title: Text("Bus Schdule"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransportScreen(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text("Logout")),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.amber,
        onPressed: () {
          MySnackbar("I am floating action button", context);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: const Color.fromARGB(255, 81, 13, 229),
          ),
          image: const DecorationImage(
            image: AssetImage('assets/images/oo2.png'),
            fit: BoxFit.contain,
            opacity: 0.8,
          ),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(255, 131, 201, 90))
          ],
        ),
        alignment: Alignment.topCenter,
        child: const Text("Basic APP"),
      ),
    );
  }
}
