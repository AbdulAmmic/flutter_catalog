import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/product.dart'; // Ensure the path is correct
import 'screens/product_list_screen.dart'; // Import the ProductListScreen
import 'screens/product_detail_screen.dart'; // Import the ProductDetailScreen
import 'screens/product_form_screen.dart'; // Import the ProductFormScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(
      ProductAdapter()); // Ensure this matches the generated adapter name

  runApp(ProductCatalogApp());
}

class ProductCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.blueAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) =>
            ProductListScreen(), // Ensure ProductListScreen is imported correctly
        '/product-detail': (ctx) =>
            ProductDetailScreen(), // Ensure ProductDetailScreen is imported correctly
        '/add-product': (ctx) =>
            ProductFormScreen(), // Ensure ProductFormScreen is imported correctly
      },
    );
  }
}
