import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isInCart = cartProvider.isInCart(widget.product.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey[200],
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                    size: 100,
                  );
                },
              ),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.product.rating}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Category
                  Text(
                    widget.product.category,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 16),

                  // Price
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stock Status
                  Row(
                    children: [
                      Text(
                        'Stock: ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        widget.product.stock > 0
                            ? '${widget.product.stock} available'
                            : 'Out of stock',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.product.stock > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.8,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Key Features
                  const Text(
                    'Key Features',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  ...getKeyFeatures(widget.product.id).map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Quantity Selector
                  if (widget.product.stock > 0)
                    Row(
                      children: [
                        const Text(
                          'Quantity: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 18),
                                onPressed: quantity > 1
                                    ? () {
                                        setState(() => quantity--);
                                      }
                                    : null,
                              ),
                              Text(
                                '$quantity',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 18),
                                onPressed: quantity < widget.product.stock
                                    ? () {
                                        setState(() => quantity++);
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: widget.product.stock > 0
                          ? () {
                              for (int i = 0; i < quantity; i++) {
                                cartProvider.addToCart(widget.product);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Added $quantity item(s) to cart',
                                  ),
                                  duration: const Duration(milliseconds: 1000),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: Text(
                        widget.product.stock > 0
                            ? 'Add to Cart'
                            : 'Out of Stock',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getKeyFeatures(String productId) {
    final features = {
      '1': [
        'Industry-leading active noise cancellation',
        'Up to 30 hours battery life',
        'Premium sound quality with LDAC codec',
        'Comfortable over-ear design',
        'Touch sensor controls',
        'Multipoint connection support',
      ],
      '2': [
        'Always-on Retina display',
        'Advanced health monitoring sensors',
        'ECG and temperature sensing',
        'GPS and cellular connectivity',
        'Water resistant up to 50 meters',
        'Over 100 workout types',
      ],
      '3': [
        '20000mAh ultra-high capacity',
        'Dual USB-A and USB-C ports',
        'Fast charging technology',
        'Lightweight and portable design',
        'Smart protection features',
        'Includes USB-C cable',
      ],
      '4': [
        '60W fast charging support',
        'Nylon braiding for durability',
        'High-speed data transfer',
        'Universal USB-C compatibility',
        '2-year manufacturer warranty',
        'Flexible and tangle-resistant',
      ],
      '5': [
        'Premium aluminum alloy construction',
        '270° rotation capability',
        'Supports up to 10-inch devices',
        'Non-slip silicone pads',
        'Lightweight and portable',
        'Universal device compatibility',
      ],
      '6': [
        'MagSpeed electromagnetic scrolling',
        'Supports 3 device connection',
        'Precision tracking on any surface',
        'Up to 70 days battery life',
        'Customizable buttons',
        'Ergonomic design',
      ],
      '7': [
        '65-inch ultra-bright QLED display',
        '4K resolution with AI upscaling',
        'Variable refresh rate up to 120Hz',
        'Smart TV with Tizen OS',
        'Voice control compatible',
        'Sleek minimalist design',
      ],
      '8': [
        'Active noise cancellation',
        'Spatial audio with head tracking',
        'H2 chip for fast sync',
        'Adaptive audio technology',
        'Up to 30 hours total time',
        'Seamless Apple integration',
      ],
    };
    return features[productId] ?? [];
  }
}
