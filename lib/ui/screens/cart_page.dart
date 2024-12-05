/// The `CartPage` class in a Flutter app displays a list of plants added to the cart with quantity
/// controls and calculates the total price.
library;

import 'package:flutter/material.dart';
import 'package:plant_shop_app/constants.dart';
import 'package:plant_shop_app/models/plants.dart';
import 'package:plant_shop_app/ui/screens/payment_screen.dart';
import 'package:plant_shop_app/ui/screens/widgets/plant_widget.dart';

class CartPage extends StatefulWidget {
  final List<Plant> addedToCartPlants;
  const CartPage({super.key, required this.addedToCartPlants});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double getTotalPrice() {
    return widget.addedToCartPlants
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _buildBody(size),
    );
  }

  Widget _buildBody(Size size) {
    if (widget.addedToCartPlants.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset('assets/images/add-cart.png'),
            ),
            const SizedBox(height: 10),
            Text(
              'Your Cart is Empty',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
      height: size.height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.addedToCartPlants.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: PlantWidget(
                            index: index, plantList: widget.addedToCartPlants),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Constants.primaryColor),
                              onPressed: () {
                                setState(() {
                                  if (widget.addedToCartPlants[index].quantity >
                                      1) {
                                    widget.addedToCartPlants[index].quantity--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '${widget.addedToCartPlants[index].quantity}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline,
                                  color: Constants.primaryColor),
                              onPressed: () {
                                setState(() {
                                  widget.addedToCartPlants[index].quantity++;
                                });
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.addedToCartPlants.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              const Divider(thickness: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '\$${getTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.addedToCartPlants.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                            cartItems: widget.addedToCartPlants,
                            totalPrice: getTotalPrice()),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Proceed to Payment',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
