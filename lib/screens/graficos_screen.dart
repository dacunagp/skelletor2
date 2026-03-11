import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class GraficosScreen extends StatelessWidget {
  const GraficosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gráficos')),
      drawer: const AppDrawer(currentRoute: '/graficos'),
      body: const Center(
        child: Text(
          'Welcome to Gráficos',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
