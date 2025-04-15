import 'package:flutter/material.dart';

class AdvertisementListPage extends StatefulWidget {
  static String routename = "/list";
  const AdvertisementListPage({super.key});

  @override
  _AdvertisementListPageState createState() => _AdvertisementListPageState();
}

class _AdvertisementListPageState extends State<AdvertisementListPage> {
  final List<Map<String, String>> advertisements = List.generate(
    6,
        (index) => {
      "id": "FCC/AC/123",
      "name": "Space Name",
      "address": "Space Category",
      "category": "Category",
      "image": index % 2 == 0
          ? "https://via.placeholder.com/300x200?text=Ad+1"
          : "https://via.placeholder.com/300x200?text=Ad+2",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Advertisement list page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildAdvertisementGrid(),
          ),
          _buildLoadingIndicator(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search space by ID",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            onPressed: () {},
            child: Text("Search", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvertisementGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        itemCount: advertisements.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final ad = advertisements[index];
          return Card(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Image.asset("assets/banner_dummy.png"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Space ID - ${ad["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Space Name - ${ad["name"]}"),
                        Text("Space Address - ${ad["address"]}"),
                        Text("Category - ${ad["category"]}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CircularProgressIndicator(color: Colors.purple),
    );
  }
}
