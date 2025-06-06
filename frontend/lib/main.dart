// main.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/dashboard_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/product_details_page.dart';
import 'package:frontend/pages/products_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frontend/utils/shared_service.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox'); // <- Abrir box para guardar dados do usuário
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App com Hive + Riverpod',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const DashboardPage(),
        '/products': (context) => const ProductsPage(),
        '/product-details': (context) => const ProductDetailsPage(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SharedService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          Future.microtask(() async {
            final isLoggedIn = snapshot.data ?? false;

            if (isLoggedIn) {
              logger.i("Usuário logado, indo para HomePage");
              Navigator.of(context).pushReplacementNamed('/home');
            } else {
              if (SharedService.getToken() != null &&
                  SharedService.isTokenExpired()) {
                logger.w(
                  "Token expirado, mostrando alerta e aguardando confirmação",
                );

                await SharedService.logout();

                // Espera o usuário confirmar antes de redirecionar
                await showDialog(
                  context: context,
                  barrierDismissible: false, // Impede fechar tocando fora
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Session Expired"),
                      content: const Text("Please log in again."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Fecha o alerta
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );

                // Após o alerta, redireciona
                Navigator.of(context).pushReplacementNamed('/login');
              } else {
                logger.i("Usuário não logado, indo para LoginPage");
                Navigator.of(context).pushReplacementNamed('/login');
              }
            }
          });

          return const Scaffold(body: Center(child: Text("Redirecting...")));
        }
      },
    );
  }
}
