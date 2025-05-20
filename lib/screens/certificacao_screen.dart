import 'package:flutter/material.dart';

class CertificacaoScreen extends StatelessWidget {
  const CertificacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adiciona espaçamento interno
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
          children: [
            const Text(
              'Certificação de Funcionários',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // Espaçamento entre os textos
            const Text(
              'Aqui será feito o acompanhamento do progresso e certificação dos funcionários.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}