import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class MonitoreosScreen extends StatelessWidget {
  const MonitoreosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monitoreos')),
      drawer: const AppDrawer(currentRoute: '/monitoreos'),
      body: const Center(
        child: Text(
          'Welcome to Monitoreos',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
