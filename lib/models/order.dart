import 'package:intl/intl.dart';
import 'cart_item.dart';

enum OrderStatus { pending, processing, shipped, delivered }

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime orderDate;
  final String? deliveryAddress;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    this.status = OrderStatus.pending,
    required this.orderDate,
    this.deliveryAddress,
  });

  String get formattedDate => DateFormat('MMM dd, yyyy').format(orderDate);
  String get statusText =>
      status.name[0].toUpperCase() + status.name.substring(1);

  Order copyWith({
    String? id,
    List<CartItem>? items,
    double? totalAmount,
    OrderStatus? status,
    DateTime? orderDate,
    String? deliveryAddress,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }
}
