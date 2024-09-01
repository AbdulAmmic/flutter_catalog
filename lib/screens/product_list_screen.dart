import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/database_helper.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final HiveDatabaseHelper _databaseHelper =
      HiveDatabaseHelper(); // Use HiveDatabaseHelper

  List<Product> _products = [];
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      List<Product> products = await _databaseHelper.getProducts();
      setState(() {
        _products = products;
        _isLoading = false; // Set loading to false after products are loaded
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() {
        _isLoading = false; // Set loading to false even if there's an error
      });
      // Handle errors here, maybe show a Snackbar or AlertDialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        backgroundColor: Colors.blue, // Blue background for AppBar
        actions: [],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator()) // Show loader while loading
          : _products.isEmpty
              ? Center(child: Text('No products found.'))
              : ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (ctx, index) {
                    final product = _products[index];
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: ListTile(
                        leading: product.imageUrl.isNotEmpty
                            ? Image.network(
                                product.imageUrl,
                                width: 50,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.image, size: 50),
                        title: Text(product.name),
                        subtitle: Text('\N${product.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/add-product',
                                  arguments: product,
                                ).then((_) {
                                  _loadProducts(); // Reload products after editing
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await _databaseHelper.deleteProduct(product.id);
                                _loadProducts(); // Reload products after deletion
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/product-detail',
                            arguments: product,
                          );
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-product').then((_) {
            _loadProducts(); // Reload products after adding a new one
          });
        },
        child: Icon(Icons.add),
        tooltip: 'Add Product',
      ),
    );
  }
}
