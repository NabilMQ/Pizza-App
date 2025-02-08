import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMacroWidget extends StatelessWidget {

  final String title;
  final int value;
  final IconData icon;

  const MyMacroWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            FaIcon(
              icon,
              color: Colors.redAccent,
            ),
            SizedBox(height: 4),
            Text(
              title == "Calories"
                ? "$value $title"
                : "${value}g $title",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}