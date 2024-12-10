import 'package:flutter/material.dart';

class ShoppinScreen extends StatelessWidget {
  const ShoppinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Shopping cart"))
          ],
        ),
      ),
    );
  }
}
