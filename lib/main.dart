import 'package:flutter/material.dart';
import 'package:projeto/cadastroClienteListScreen.dart';
import 'package:projeto/cadastroClienteScreen.dart';
import 'package:projeto/cadastroProdutoListScreen.dart';
import 'package:projeto/cadastroProdutoScreen.dart';
import 'package:projeto/cadastroUsuarioListScreen.dart';
import 'package:projeto/cadastroUsuarioScreen.dart';
import 'package:projeto/loginScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro App',
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomeScreen(),
        '/usuarios': (context) => const CadastroUsuarioListScreen(),
        '/clientes': (context) => const CadastroClienteListScreen(),
        '/produtos': (context) => const CadastroProdutoListScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/usuarios'),
              icon: const Icon(Icons.account_circle),
              label: const Text('Cadastrar Usuário'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/clientes'),
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Cadastrar Cliente'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/produtos'),
              icon: const Icon(Icons.shopping_cart_rounded),
              label: const Text('Cadastrar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
