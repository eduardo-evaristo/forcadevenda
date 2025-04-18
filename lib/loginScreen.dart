import 'package:flutter/material.dart';
import 'package:projeto/controladoraUsuario.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controllerNome = TextEditingController();
  final _controllerSenha = TextEditingController();
  final _usuarioController = UsuarioController();

  bool loginError = false;

  void _login() async {
    final nome = _controllerNome.text.trim();
    final senha = _controllerSenha.text;

    final usuarios = await _usuarioController.loadList();

    final isValid =
        usuarios.isEmpty
            ? nome == 'admin' && senha == 'admin'
            : usuarios.any((u) => u.nome == nome && u.senha == senha);

    setState(() {
      loginError = !isValid;
    });

    // Preent user from coming back!
    if (!loginError) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),

        /// For login purposes
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controllerNome,
                decoration: const InputDecoration(label: Text('Nome')),
              ),
              TextField(
                controller: _controllerSenha,
                obscureText: true,
                decoration: const InputDecoration(label: Text('Senha')),
              ),
              if (loginError)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Usuário ou senha inválidos.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: const Text('Entrar')),
            ],
          ),
        ),
      ),
    );
  }
}
