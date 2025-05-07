import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/card_productos/productos_card.dart';
import 'package:flutter_application_2/models/cart_model.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  Future<List<CartItem>> obtenerProductos() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('Productos')
            .get(); // <- nombre exacto
    return snapshot.docs
        .map((doc) => CartItem.fromMap(doc.id, doc.data()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tienda')),
      body: FutureBuilder<List<CartItem>>(
        future: obtenerProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final productos = snapshot.data ?? [];

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return ProductCard(
                id: producto.id,
                name: producto.name,
                imageUrl: producto.imageUrl,
                price: producto.price,
                category: producto.category,
                onAddToCart: () {
                  cart.addItem(
                    producto.id,
                    producto.name,
                    producto.imageUrl,
                    producto.price,
                    producto.category,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${producto.name} agregado al carrito'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
