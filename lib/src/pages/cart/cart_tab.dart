// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItems.remove(cartItem);
      utilsServices.showToast(
          message: '${cartItem.item.itemName} removido do carrinho');
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in app_data.cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text(
          'Carrinho',
        ),
      ),

      // Body
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: app_data.cartItems.length,
              itemBuilder: (_, index) {
                return CartTile(
                    cartItem: app_data.cartItems[index],
                    remove: removeItemFromCart);
              },
            ),
          ),

          // Container Total
          Container(
            padding: const EdgeInsetsDirectional.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),

            // Itens Total
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Texto Total Geral
                const Text(
                  'Total Geral',
                  style: TextStyle(fontSize: 12),
                ),

                // Valor Total
                Text(
                  utilsServices.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Botão Concluir Pedido
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();
                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return PaymentDialog(
                              order: app_data.orders.first,
                            );
                          },
                        );
                      } else {
                        utilsServices.showToast(
                          message: 'Pedido não confirmado',
                          isError: true,
                        );
                      }
                    },
                    child: const Text(
                      'Concluir Pedido',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir seu pedido?'),
          actions: [
            // Botão de Não
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),

            // Botão de Sim
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.customSwatchColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Sim',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
