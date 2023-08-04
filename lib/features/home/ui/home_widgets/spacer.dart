import 'package:flutter/material.dart';

class HomeSpacer extends StatelessWidget {
  final double height;
  const HomeSpacer({super.key, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
