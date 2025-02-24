import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport Routes',
      home: const TransportScreen(),
    );
  }
}

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  _TransportScreenState createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  String? selectedStartPlace;
  String? selectedEndPlace;
  String? busNumber;
  String? time;

  final List<String> places = ["Dhanmondi", "Mirpur", "Uttara", "DSC"];
  final List<Map<String, String>> transportRoutes = [];

  final TextEditingController busNumberController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  void _addRoute() {
    if (selectedStartPlace != null &&
        selectedEndPlace != null &&
        busNumberController.text.isNotEmpty &&
        timeController.text.isNotEmpty) {
      setState(() {
        transportRoutes.add({
          "busNumber": busNumberController.text,
          "from": selectedStartPlace!,
          "to": selectedEndPlace!,
          "time": timeController.text,
        });
      });
      busNumberController.clear();
      timeController.clear();
    }
  }

  void _deleteRoute(int index) {
    setState(() {
      transportRoutes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Routes', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedStartPlace,
                    hint: const Text("Start Place"),
                    items: places.map((String place) {
                      return DropdownMenuItem<String>(
                        value: place,
                        child: Text(place),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStartPlace = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedEndPlace,
                    hint: const Text("End Place"),
                    items: places.map((String place) {
                      return DropdownMenuItem<String>(
                        value: place,
                        child: Text(place),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEndPlace = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: busNumberController,
                    decoration: InputDecoration(
                      hintText: "Bus Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      hintText: "Time",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addRoute,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text("Add New Route",
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: transportRoutes.length,
                itemBuilder: (context, index) {
                  final route = transportRoutes[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading:
                          const Icon(Icons.directions_bus, color: Colors.blue),
                      title: Text("Bus № ${route["busNumber"]}"),
                      subtitle: Text(
                          "From: ${route["from"]} → To: ${route["to"]}\nTime: ${route["time"]}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteRoute(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
