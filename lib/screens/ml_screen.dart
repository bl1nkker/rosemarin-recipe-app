import 'package:flutter/material.dart';

class MLScreen extends StatefulWidget {
  const MLScreen({Key? key}) : super(key: key);

  @override
  State<MLScreen> createState() => _MLScreenState();
}

class _MLScreenState extends State<MLScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'This part of the app is still in development. Follow the news about our application!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
      ),
    ));
  }
}
