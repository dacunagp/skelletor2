import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class UsuariosScreen extends StatelessWidget {
  const UsuariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      drawer: const AppDrawer(currentRoute: '/usuarios'),
      body: const Center(
        child: Text(
          'Welcome to Usuarios',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
