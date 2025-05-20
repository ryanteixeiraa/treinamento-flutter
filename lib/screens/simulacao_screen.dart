import 'package:flutter/material.dart';

class SimulacaoScreen extends StatelessWidget {
  const SimulacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulações em RA'),
      ),
      body: Center(
        child: Text(
          'Aqui ficarão as simulações de Realidade Aumentada!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
