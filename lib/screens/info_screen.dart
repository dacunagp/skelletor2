import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info')),
      drawer: const AppDrawer(currentRoute: '/info'),
      body: const Center(
        child: Text(
          'Welcome to Info',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
