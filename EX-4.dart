
enum OrderType { DELIVERY, PICKUP }

class Address {
  final String street;
  final String city;
  final String zipCode;

  Address({
    required this.street,
    required this.city,
    required this.zipCode,
  });

  @override
  String toString() {
    return '$street, $city, $zipCode';
  }
}

class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  }) {
    if (price < 0) {
      throw Exception('Price cannot be negative!');
    }
  }
}

class Customer {
  final int id;
  final String name;
  final String email;

  Customer({
    required this.id,
    required this.name,
    required this.email,
  });
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  }) {
    if (quantity <= 0) {
      throw Exception('Quantity must be positive!');
    }
  }

  double get total => product.price * quantity;
}

class Order {
  final int id;
  final Customer customer;
  final List<OrderItem> items;
  final OrderType type;
  final Address? deliveryAddress;

  Order._({
    required this.id,
    required this.customer,
    required List<OrderItem> items,
    required this.type,
    this.deliveryAddress,
  }) : items = List.unmodifiable(items);

  Order.delivery({
    required int id,
    required Customer customer,
    required List<OrderItem> items,
    required Address address,
  }) : this._(
          id: id,
          customer: customer,
          items: items,
          type: OrderType.DELIVERY,
          deliveryAddress: address,
        );

  Order.pickup({
    required int id,
    required Customer customer,
    required List<OrderItem> items,
  }) : this._(
          id: id,
          customer: customer,
          items: items,
          type: OrderType.PICKUP,
        );

  double getTotalAmount() {
    double total = 0;

    for (var item in items) {
      total += item.total;
    }

    return total;
  }

  void printOrder() {
    print('Order ID: $id');
    print('Customer: ${customer.name}');
    print('Order Type: ${type.name}');

    if (deliveryAddress != null) {
      print('Address: $deliveryAddress');
    } else {
      print('Pickup at shop');
    }

    for (var item in items) {
      print(
        '${item.product.name} x ${item.quantity}'
        ' = \$${item.total.toStringAsFixed(2)}',
      );
    }

    print(
      'Total: \$${getTotalAmount().toStringAsFixed(2)}',
    );
    print('---------------------------');
  }
}

class Shop {
  final String name;
  final List<Product> products = [];
  final List<Order> orders = [];

  Shop({required this.name});

  void addProduct(Product product) {
    products.add(product);
  }

  void addOrder(Order order) {
    orders.add(order);
  }
}

void main() {
  Shop shop = Shop(name: 'Online Pet Shop');

  Product product1 = Product(
    id: 1,
    name: 'Dog Food',
    price: 20,
  );

  Product product2 = Product(
    id: 2,
    name: 'Cat Toy',
    price: 5,
  );

  shop.addProduct(product1);
  shop.addProduct(product2);

  Customer customer = Customer(
    id: 1,
    name: 'Ronan',
    email: 'ronan@example.com',
  );

  Address address = Address(
    street: 'Street 123',
    city: 'Phnom Penh',
    zipCode: '12000',
  );

  List<OrderItem> items = [
    OrderItem(product: product1, quantity: 2),
    OrderItem(product: product2, quantity: 3),
  ];

  Order order1 = Order.delivery(
    id: 101,
    customer: customer,
    items: items,
    address: address,
  );

  Order order2 = Order.pickup(
    id: 102,
    customer: customer,
    items: [
      OrderItem(product: product2, quantity: 2),
    ],
  );

  shop.addOrder(order1);
  shop.addOrder(order2);

  print('Shop: ${shop.name}');
  print('===========================');

  for (var order in shop.orders) {
    order.printOrder();
  }
}
