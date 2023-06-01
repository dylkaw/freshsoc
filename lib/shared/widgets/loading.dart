import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 234, 230, 229),
      child: const Center(
        child: SpinKitRing(
          color: Color.fromARGB(255, 0, 61, 124),
          size: 50.0,
        ),
      ),
    );
  }
}
