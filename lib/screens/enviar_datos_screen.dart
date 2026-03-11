import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class EnviarDatosScreen extends StatelessWidget {
  const EnviarDatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar datos a Servidor')),
      drawer: const AppDrawer(currentRoute: '/enviar_datos'),
      body: const Center(
        child: Text(
          'Welcome to Enviar datos a Servidor',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
