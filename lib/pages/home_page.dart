import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../models/cart_model.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CartPage();
            },
          ),
        ),
        backgroundColor: Colors.black,
        child: Icon(Icons.shopping_cart),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 45),
          // greeting text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("Selamat Belanja,"),
          ),

          const SizedBox(height: 0),
          // Let's order Merchandise Items for You
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              "Let's order Merchandise Items for You",
              style: GoogleFonts.notoSerif(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: const Text(
              "Merchandise Items",
              style: TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                hintText: 'Search merchandise...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                final filteredItems = value.shopItems
                    .where(
                      (item) => item[0].toString().toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ),
                    )
                    .toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemCount: filteredItems.length,
                  padding: EdgeInsets.all(12.0),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    final originalIndex = value.shopItems.indexOf(item);
                    return GroceryItemTile(
                      itemName: item[0],
                      itemPrice: item[1],
                      imagePath: item[2],
                      color: item[3],
                      onPressed: () => value.addItemToCart(originalIndex),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
