import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class EstacionesScreen extends StatelessWidget {
  const EstacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estaciones')),
      drawer: const AppDrawer(currentRoute: '/estaciones'),
      body: const Center(
        child: Text(
          'Welcome to Estaciones',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
