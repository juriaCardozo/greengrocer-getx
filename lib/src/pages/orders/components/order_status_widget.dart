import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool overdue;

  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_shipping': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({super.key, required this.status, required this.overdue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusDot(isActive: true, title: 'Pedido Confirmado'),
        _CustomDivider(),
        if (currentStatus == 1) ...[
          _StatusDot(
            isActive: true,
            title: 'Pix estornado',
            backgroundColor: Colors.orange,
          ),
        ] else if (overdue) ...[
          _StatusDot(
            isActive: true,
            title: 'Pagamento Pix Vencido',
            backgroundColor: Colors.red,
          )
        ]
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backgroundColor;

  const _StatusDot(
      {super.key,
      required this.isActive,
      required this.title,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dot
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColors.customSwatchColor,
              ),
              color: isActive
                  ? backgroundColor ?? CustomColors.customSwatchColor
                  : Colors.transparent),
          child: isActive
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                )
              : SizedBox.shrink(),
        ),

        SizedBox(
          width: 5,
        ),

        // Texto
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
