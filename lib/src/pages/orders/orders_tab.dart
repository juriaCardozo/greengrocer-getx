import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedidos'),),

      body: ListView.separated(
        padding: EdgeInsets.all(16), 
        physics: BouncingScrollPhysics(), 
        itemBuilder: , 
        separatorBuilder: (_, index) => SizedBox(
            height: 10
          ),
        itemCount: ,
        ),
    );
  }
}