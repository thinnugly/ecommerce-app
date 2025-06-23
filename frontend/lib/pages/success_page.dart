import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String deliveryMethod;

  const SuccessPage({super.key, required this.deliveryMethod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Pagamento realizado com sucesso!',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'COMPLETED',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Método de entrega: ${deliveryMethod == 'pickup' ? 'Retirar no local' : 'Entrega ao domicílio'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              child: const Text('Voltar para a Loja'),
            ),
          ],
        ),
      ),
    );
  }
}




