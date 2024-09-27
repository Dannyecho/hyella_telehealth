import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  const Page404({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .45,
        ),
        const Text(
          "404!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            fontFamily: 'Roboto',
          ),
        ),
        const Text(
          "Page not found 😢",
          style: TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
