import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      drawer: const AppDrawer(currentRoute: '/historial'),
      body: const Center(
        child: Text(
          'Welcome to Historial',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
