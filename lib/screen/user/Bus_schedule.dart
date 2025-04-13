import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UrTransportScreen extends StatefulWidget {
  const UrTransportScreen({super.key});

  @override
  _TransportScreenState createState() => _TransportScreenState();
}

class _TransportScreenState extends State<UrTransportScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedPlace = "Dhanmondi";
  String? selectedTransport = "Mirpur";

  final List<String> places = ["Dhanmondi", "Mirpur", "Uttara", "DSC"];
  final List<String> endPlace = ["Dhanmondi", "Mirpur", "Uttara", "DSC"];

  void _onSearch() {
    if (selectedPlace != null && selectedTransport != null) {
      print("Searching for $selectedTransport from $selectedPlace...");
    } else {
      print("Please select both Place and Transport Type.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Routes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Dropdowns and Search Button in One Row
            Row(
              children: [
                // Place Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedPlace,
                    hint: const Text("start Place",
                        style: TextStyle(fontSize: 10)),
                    isDense: true,
                    menuMaxHeight: 150,
                    items: places.map((String place) {
                      return DropdownMenuItem<String>(
                        value: place,
                        child: Text(place,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                            )),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPlace = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(maxHeight: 32),
                    ),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 4),

                // Transport Type Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedTransport,
                    hint:
                        const Text("End Place", style: TextStyle(fontSize: 10)),
                    isDense: true,
                    menuMaxHeight: 150,
                    items: endPlace.map((String transport) {
                      return DropdownMenuItem<String>(
                        value: transport,
                        child: Text(transport,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                            )),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTransport = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(maxHeight: 32),
                    ),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 4),

                // Search Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    minimumSize: const Size(32, 32),
                  ),
                  onPressed: _onSearch,
                  child:
                      const Icon(Icons.search, color: Colors.white, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Bus Routes List from Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('bus_routes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No bus routes available',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final route = doc.data() as Map<String, dynamic>;

                      return TransportCard(
                        icon: Icons.directions_bus,
                        title: "Bus № ${route['busNumber']}",
                        from: route['from'],
                        to: route['to'],
                        time: route['time'],
                      );
                    },
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

class TransportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String from;
  final String to;
  final String time;

  const TransportCard({
    super.key,
    required this.icon,
    required this.title,
    required this.from,
    required this.to,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Time
            Row(
              children: [
                Icon(icon, color: Colors.blue, size: 16),
                const SizedBox(width: 4),
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Icon(Icons.access_time, size: 12),
                const SizedBox(width: 2),
                Text("Today / $time", style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 4),

            // From - To
            Row(
              children: [
                const Icon(Icons.arrow_downward, size: 12),
                const SizedBox(width: 2),
                Expanded(
                    child: Text("From: $from",
                        style: const TextStyle(fontSize: 16))),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.arrow_upward, size: 12),
                const SizedBox(width: 2),
                Expanded(
                    child:
                        Text("To: $to", style: const TextStyle(fontSize: 16))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
