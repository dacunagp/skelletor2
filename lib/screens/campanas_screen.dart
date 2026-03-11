import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class CampanasScreen extends StatelessWidget {
  const CampanasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campañas')),
      drawer: const AppDrawer(currentRoute: '/campanas'),
      body: const Center(
        child: Text(
          'Welcome to Campañas',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
