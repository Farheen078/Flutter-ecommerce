import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Sony WH-1000XM5 Wireless Headphones',
      description:
          'Industry-leading noise cancellation with premium sound quality. Features 30-hour battery life, comfortable over-ear design, and adaptive sound control. Touch sensor controls and multipoint connection for seamless switching between devices. Perfect for music lovers and frequent travelers.',
      price: 349.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
      category: 'Electronics',
      stock: 15,
      rating: 4.8,
    ),
    Product(
      id: '2',
      name: 'Apple Watch Series 9',
      description:
          'Advanced health and fitness tracker with always-on Retina display. Monitors heart rate, blood oxygen, ECG, temperature sensing, and sleep tracking. Features GPS, water resistance up to 50m, and cellular connectivity. Supports over 100 workout types with real-time coaching.',
      price: 399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&h=500&fit=crop',
      category: 'Electronics',
      stock: 12,
      rating: 4.7,
    ),
    Product(
      id: '3',
      name: 'Anker PowerCore 20000 Power Bank',
      description:
          'Ultra-reliable 20000mAh portable charger with dual USB-A ports and USB-C. Provides 3x charging for iPhone or 2.5x for Samsung Galaxy. Compact design weighs just 320g. Includes 1.5-meter USB-C cable. Smart technology protects connected devices with multiple safeguards.',
      price: 39.99,
      imageUrl:
          'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=500&h=500&fit=crop',
      category: 'Accessories',
      stock: 45,
      rating: 4.6,
    ),
    Product(
      id: '4',
      name: 'Belkin Braided USB-C Cable',
      description:
          'Ultra-durable premium USB-C cable with 60W fast charging capability. Supports data transfer up to 480Mbps. Nylon braiding provides extra strength and flexibility. Works with all USB-C compatible devices including laptops, tablets, and smartphones. Backed by 2-year warranty.',
      price: 19.99,
      imageUrl:
          'https://images.unsplash.com/photo-1625948515291-69613efd103f?w=500&h=500&fit=crop',
      category: 'Accessories',
      stock: 50,
      rating: 4.4,
    ),
    Product(
      id: '5',
      name: 'Lamicall Adjustable Phone Stand',
      description:
          'Premium aluminum alloy phone stand with 270° rotation capability. Supports phones up to 10 inches and tablets. Non-slip silicone pads protect your device. Compatible with all smartphones and small tablets. Lightweight, portable design perfect for desk or travel use.',
      price: 24.99,
      imageUrl:
          'https://images.unsplash.com/photo-1527814050087-3793815479db?w=500&h=500&fit=crop',
      category: 'Accessories',
      stock: 38,
      rating: 4.5,
    ),
    Product(
      id: '6',
      name: 'Logitech MX Master 3S Wireless Mouse',
      description:
          'Professional-grade ergonomic mouse with MagSpeed electromagnetic scrolling. Supports simultaneous connection to up to 3 devices with Easy-Switch button. Precision tracking on any surface including glass. 70-day battery life on a single charge. Customizable buttons for increased productivity.',
      price: 99.99,
      imageUrl:
          'https://images.unsplash.com/photo-1527814050087-3793815479db?w=500&h=500&fit=crop',
      category: 'Electronics',
      stock: 22,
      rating: 4.7,
    ),
    Product(
      id: '7',
      name: 'Samsung 65" QLED 4K Smart TV',
      description:
          'Ultra-bright QLED display with quantum dots for enhanced colors and contrast. 4K resolution with AI upscaling technology. Smart TV features with Samsung Tizen OS and voice control compatibility. Variable refresh rate up to 120Hz perfect for gaming. Sleek minimalist design with nearly edge-to-edge screen.',
      price: 899.99,
      imageUrl:
          'https://images.unsplash.com/photo-1559056199-641a0ac8b3f7?w=500&h=500&fit=crop',
      category: 'Electronics',
      stock: 8,
      rating: 4.8,
    ),
    Product(
      id: '8',
      name: 'Apple AirPods Pro 2nd Generation',
      description:
          'Legendary AirPods Pro with active noise cancellation and transparency mode. H2 chip ensures fast audio and video sync with Apple devices. Personalized spatial audio with dynamic head tracking. Adaptive audio intelligently blends your content with the world around you. Up to 30 hours total listening time.',
      price: 249.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505470468204-71bd5f7e0d7e?w=500&h=500&fit=crop',
      category: 'Electronics',
      stock: 28,
      rating: 4.9,
    ),
  ];

  List<Product> get products => _products;
  List<String> get categories => ['All', 'Electronics', 'Accessories'];

  List<Product> getProductsByCategory(String category) {
    if (category == 'All') return _products;
    return _products.where((p) => p.category == category).toList();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> searchProducts(String query) {
    return _products
        .where(
          (p) =>
              p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
