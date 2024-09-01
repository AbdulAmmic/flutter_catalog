import 'package:hive/hive.dart';
import '../models/product.dart';

class HiveDatabaseHelper {
  static const String _boxName = 'productsBox';

  Future<Box<Product>> _getBox() async {
    return await Hive.openBox<Product>(_boxName);
  }

  Future<void> insertProduct(Product product) async {
    final box = await _getBox();
    await box.put(product.id, product);
  }

  Future<List<Product>> getProducts() async {
    final box = await _getBox();
    return box.values.toList();
  }

  Future<void> updateProduct(Product product) async {
    final box = await _getBox();
    await box.put(product.id, product);
  }

  Future<void> deleteProduct(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }
}
