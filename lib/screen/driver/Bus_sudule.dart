import 'package:flutter/material.dart';
import 'package:transport_system/screen/driver/wized/addroute.dart';
import 'package:transport_system/utils/database_helper.dart';

class DriTransportScreen extends StatefulWidget {
  const DriTransportScreen({super.key});

  @override
  State<DriTransportScreen> createState() => _DriTransportScreenState();
}

class _DriTransportScreenState extends State<DriTransportScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> busRoutes = [];

  @override
  void initState() {
    super.initState();
    loadRoutes();
  }

  Future<void> loadRoutes() async {
    try {
      final routes = await _databaseHelper.getAllRoutes();
      setState(() {
        busRoutes = routes;
      });
    } catch (e) {
      print('Error loading routes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading routes: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteRoute(int id) async {
    try {
      await _databaseHelper.deleteRoute(id);
      loadRoutes(); // Reload the routes after deletion

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Route deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error deleting route: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting route: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bus Schedule',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Addroute()),
              );
              if (result == true) {
                loadRoutes(); // Reload routes when returning from Add Route page with success
              }
            },
          ),
        ],
      ),
      body: busRoutes.isEmpty
          ? const Center(
              child: Text(
                'No routes available.\nTap + to add new routes.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: busRoutes.length,
              itemBuilder: (context, index) {
                final route = busRoutes[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading:
                        const Icon(Icons.directions_bus, color: Colors.green),
                    title: Text(
                      "Bus № ${route["busNumber"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "From: ${route["fromLocation"]} → To: ${route["toLocation"]}"),
                        Text("Date: ${route["date"]} Time: ${route["time"]}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Route"),
                              content: const Text(
                                  "Are you sure you want to delete this route?"),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: const Text("Delete",
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    deleteRoute(route['id']);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
