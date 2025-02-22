import 'package:flutter/material.dart';

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
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // Function to show Snackbar
  MySnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 10,
        title: const Text("Protik"),
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
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.amber,
        onPressed: () {
          MySnackbar("i am flotting action batton", context);
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
