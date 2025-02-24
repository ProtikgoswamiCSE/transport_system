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
  String? selectedPlace;
  String? selectedTransport;

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
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdowns and Search Button in One Row
            Row(
              children: [
                // Place Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedPlace,
                    hint: const Text("start Place"),
                    items: places.map((String place) {
                      return DropdownMenuItem<String>(
                        value: place,
                        child: Text(place),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPlace = newValue;
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

                // Transport Type Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedTransport,
                    hint: const Text("End Place"),
                    items: endPlace.map((String transport) {
                      return DropdownMenuItem<String>(
                        value: transport,
                        child: Text(transport),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTransport = newValue;
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

                // Search Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _onSearch,
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Transport Route List
            Expanded(
              child: ListView(
                children: const [
                  TransportCard(
                    icon: Icons.train,
                    title: "Central Line",
                    from: "Great Portland St.",
                    to: "Baker Street",
                    time: "16:15",
                    price: "£5.00",
                  ),
                ],
              ),
            ),

            // Add New Route Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Add new route",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
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
  final String price;

  const TransportCard({
    super.key,
    required this.icon,
    required this.title,
    required this.from,
    required this.to,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Time
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text("Next arrival: Today / $time"),
              ],
            ),
            const SizedBox(height: 8),

            // From - To
            Row(
              children: [
                const Icon(Icons.arrow_downward, size: 16),
                const SizedBox(width: 4),
                Expanded(child: Text("From: $from")),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.arrow_upward, size: 16),
                const SizedBox(width: 4),
                Expanded(child: Text("To: $to")),
              ],
            ),

            const SizedBox(height: 8),

            //Price
            Text(
              "Price: $price",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
