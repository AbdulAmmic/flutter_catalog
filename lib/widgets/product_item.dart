import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final void Function(Product) onDelete;
  final void Function(Product) onEdit;

  ProductItem({
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), 
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/product-detail',
            arguments: product,
          );
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => onEdit(product),
            ),
            IconButton(
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
              onPressed: () => onDelete(product),
            ),
          ],
        ),
      ),
    );
  }
}
