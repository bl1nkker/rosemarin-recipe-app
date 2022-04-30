import 'package:flutter/material.dart';

class MLScreen extends StatefulWidget {
  const MLScreen({Key? key}) : super(key: key);

  @override
  State<MLScreen> createState() => _MLScreenState();
}

class _MLScreenState extends State<MLScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('ML Screen'));
  }
}
