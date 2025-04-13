import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addroute extends StatefulWidget {
  const Addroute({super.key});

  @override
  _AddrouteState createState() => _AddrouteState();
}

class _AddrouteState extends State<Addroute> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedStartPlace;
  String? selectedEndPlace;
  String? busNumber;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final List<String> places = ["Dhanmondi", "Mirpur", "Uttara", "DSC"];
  final List<Map<String, dynamic>> transportRoutes = [];

  final TextEditingController busNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  Future<void> saveRoutes() async {
    try {
      if (transportRoutes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one route before saving'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      print('Saving routes to Firebase: $transportRoutes'); // Debug print

      // Add each route to Firestore
      for (var route in transportRoutes) {
        try {
          final docRef = await _firestore.collection('bus_routes').add({
            'busNumber': route['busNumber'],
            'from': route['from'],
            'to': route['to'],
            'date': route['date'],
            'time': route['time'],
            'timestamp': FieldValue.serverTimestamp(),
          });
          print('Route saved to Firebase with ID: ${docRef.id}'); // Debug print
        } catch (e) {
          print('Error saving individual route: $e');
          throw Exception('Failed to save route: $e');
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Routes saved successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );

        // Wait for snackbar to show before popping
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        });
      }
    } catch (e) {
      print('Error saving routes to Firebase: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving routes: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Set initial values for date and time
    dateController.text =
        "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timeController.text = selectedTime.format(context);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          dateController.text =
              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
        });
      }
    } catch (e) {
      print('Error selecting date: $e');
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    try {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != selectedTime) {
        setState(() {
          selectedTime = picked;
          timeController.text = picked.format(context);
        });
      }
    } catch (e) {
      print('Error selecting time: $e');
    }
  }

  void _addRoute() {
    if (selectedStartPlace != null &&
        selectedEndPlace != null &&
        busNumberController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty) {
      setState(() {
        transportRoutes.add({
          "busNumber": busNumberController.text,
          "from": selectedStartPlace!,
          "to": selectedEndPlace!,
          "date": dateController.text,
          "time": timeController.text,
        });
      });
      busNumberController.clear();
      selectedStartPlace = null;
      selectedEndPlace = null;
      // Keep the date and time as they are for the next entry
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteRoute(int index) {
    setState(() {
      transportRoutes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (transportRoutes.isNotEmpty) {
          final shouldSave = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Save Routes?'),
              content: const Text('Do you want to save the added routes?'),
              actions: [
                TextButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );
          if (shouldSave ?? false) {
            await saveRoutes();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Routes',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => saveRoutes(),
          backgroundColor: Colors.green,
          child: const Icon(Icons.check, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              TextField(
                controller: busNumberController,
                decoration: InputDecoration(
                  hintText: "Bus Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        hintText: "Select Date",
                        prefixIcon: const Icon(Icons.calendar_today),
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
                      readOnly: true,
                      onTap: () => _selectTime(context),
                      decoration: InputDecoration(
                        hintText: "Select Time",
                        prefixIcon: const Icon(Icons.access_time),
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
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text("Add New Route",
                    style:
                        TextStyle(color: Color.fromARGB(255, 129, 120, 120))),
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
                        leading: const Icon(Icons.directions_bus,
                            color: Colors.blue),
                        title: Text("Bus № ${route["busNumber"]}"),
                        subtitle: Text(
                            "From: ${route["from"]} → To: ${route["to"]}\nDate: ${route["date"]} Time: ${route["time"]}"),
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
      ),
    );
  }

  @override
  void dispose() {
    busNumberController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
