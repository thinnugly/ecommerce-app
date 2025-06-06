// home_page.dart
// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:frontend/utils/shared_service.dart';
import 'package:frontend/widgets/widget_home_categories.dart';
import 'package:frontend/widgets/widget_home_products.dart';
import 'package:frontend/widgets/widget_home_sliders.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nomeUsuario = '';

  @override
  void initState() {
    super.initState();
    carregarNomeUsuario();
  }

  void carregarNomeUsuario() {
    final nome = SharedService.getNome(); // Pega nome salvo no Hive
    if (nome != null && nome.isNotEmpty) {
      setState(() {
        nomeUsuario = nome;
      });
    }
  }
  

  void _logout(BuildContext context) async {
    await SharedService.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(
      //   title: Text(
      //     // 'Bem-vindo, $nomeUsuario',
      //     'Bem-vindo, $nomeUsuario',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //       color: Colors.deepOrangeAccent,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       tooltip: 'Sair',
      //       onPressed: () => _logout(context),
      //     ),
      //   ],
      // ),
      body: ListView(
        children: const [HomeSliderWidget(), HomeCategoriesWidget(), HomeProductsWidget()],
      ),
    );
  }
}
