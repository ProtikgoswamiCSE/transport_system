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

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Routes', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Transport Route List
            Expanded(
              child: ListView(
                children: const [
                  TransportCard(
                    icon: Icons.directions_bus,
                    title: "Bus № 31",
                    from: "72-74 Oxford St.",
                    to: "20 Grosvenor Sq.",
                    time: "16:00",
                    price: "£10.00",
                  ),
                  TransportCard(
                    icon: Icons.train,
                    title: "Central Line",
                    from: "Great Portland St.",
                    to: "Baker Street",
                    time: "16:15",
                    price: "£5.00",
                  ),
                  TransportCard(
                    icon: Icons.tram,
                    title: "Tram № 17",
                    from: "377 Dumsford Rd.",
                    to: "136 Buckhold Rd.",
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
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

            // Price
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
